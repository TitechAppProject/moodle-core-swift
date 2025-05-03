//
//  File.swift
//
//
//  Created by nanashiki on 2020/12/13.
//

import Foundation

#if canImport(os)
import os
#endif

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

protocol APIClient {
    func send<R>(request: R) async throws -> R.Response where R: Request
}

public enum APIClientError: Error {
    case noResponse
    case moodleAPIError(_ response: MoodleAPIErrorResponse)
    case invalidStatusCode(_ code: Int)
    case responseDecode(_ error: Error)
    case policy
}

public struct MoodleAPIErrorResponse: Decodable {
    public let errorcode: String
    public let exception: String
    public let message: String
}

struct APIClientImpl: APIClient {
    private let urlSession: URLSession
    #if !canImport(FoundationNetworking)
    private let urlSessionDelegate: URLSessionTaskDelegate
    #endif
    private let baseURL: URL
    private let userAgent: String

    init(baseURL: URL, userAgent: String, urlSession: URLSession = .shared) {
        self.baseURL = baseURL
        self.userAgent = userAgent
        self.urlSession = urlSession
        #if !canImport(FoundationNetworking)
        self.urlSessionDelegate = HTTPClientDelegate()
        #endif
    }

    func send<R>(request: R) async throws -> R.Response where R: Request {
        let urlRequest = request.generate(baseURL: baseURL, userAgent: userAgent)

        let (data, response) = try await fetchData(request: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIClientError.noResponse
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            throw APIClientError.invalidStatusCode(httpResponse.statusCode)
        }

        return try request.decode(data: data, responseUrl: httpResponse.url)
    }

    func fetchData(request: URLRequest) async throws -> (Data, URLResponse) {
        #if canImport(FoundationNetworking)
        return try await withCheckedThrowingContinuation { continuation in
            urlSession.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: (data ?? Data(), response!))
                }
            }.resume()
        }
        #else
        return try await urlSession.data(for: request, delegate: urlSessionDelegate)
        #endif
    }
}

class HTTPClientDelegate: URLProtocol, URLSessionTaskDelegate {
    #if DEBUG && canImport(os)
    private let logger = Logger(subsystem: "app.titech.moodle-core-swift", category: "HTTPClientDelegate")
    #endif

    func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        willPerformHTTPRedirection response: HTTPURLResponse,
        newRequest request: URLRequest,
        completionHandler: @escaping (URLRequest?) -> Swift.Void
    ) {
        #if DEBUG && canImport(os)
        logger.debug(
            """
            \(response.statusCode) \(task.currentRequest?.httpMethod ?? "") \(task.currentRequest?.url?.absoluteString ?? "")
              requestHeader: \(task.currentRequest?.allHTTPHeaderFields ?? [:])
              requestBody: \(String(data: task.originalRequest?.httpBody ?? Data(), encoding: .utf8) ?? "")
              responseHeader: \(response.allHeaderFields)
              redirect -> \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")
            """
        )
        #endif

        completionHandler(request)
    }

    func urlSession(_: URLSession, task: URLSessionTask, didFinishCollecting _: URLSessionTaskMetrics) {
        #if DEBUG && canImport(os)
        logger.debug(
            """
            200 \(task.currentRequest!.httpMethod!) \(task.currentRequest!.url!.absoluteString)
              requestHeader: \(task.currentRequest!.allHTTPHeaderFields ?? [:])
              requestBody: \(String(data: task.originalRequest!.httpBody ?? Data(), encoding: .utf8) ?? "")
            """
        )
        #endif
    }
}

#if DEBUG
struct APIClientMock: APIClient {
    private let mockData: [(Any.Type, Any)]
    private let mockString: String?
    private let mockResponseUrl: URL?
    private let error: APIClientError?

    init(mockData: [(Any.Type, Any)]) {
        self.mockData = mockData
        self.mockString = nil
        self.mockResponseUrl = nil
        self.error = nil
    }

    init(mockString: String, mockResponseUrl: URL?) {
        self.mockData = []
        self.mockString = mockString
        self.mockResponseUrl = mockResponseUrl
        self.error = nil
    }

    init(error: APIClientError) {
        self.mockData = []
        self.mockString = nil
        self.mockResponseUrl = nil
        self.error = error
    }

    func send<R>(request: R) async throws -> R.Response where R: Request {
        if let error = self.error {
            throw error
        }

        if let mockString = mockString {
            return try request.decode(data: mockString.data(using: .utf8)!, responseUrl: mockResponseUrl)
        }

        for (key, value) in self.mockData {
            if R.self == key, let value = value as? R.Response {
                return value
            }
        }

        fatalError()
    }
}
#endif

//
//  File.swift
//
//
//  Created by nanashiki on 2020/12/13.
//

import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

protocol Request {
    associatedtype Response
    associatedtype RequestBody

    var method: HTTPMethod { get }

    var path: String { get }

    var queryParameters: [String: Any]? { get }

    var requestBody: RequestBody { get }

    func encode(requestBody: RequestBody) throws -> Data

    func decode(data: Data, responseUrl: URL?) throws -> Response
}

struct EmptyRequestBody: Encodable {}

protocol MultipartFormDataBody {
    var data: Data { get }
    var name: String { get }
    var mimeType: String { get }
    var fileName: String { get }
}

protocol WwwFormUrlEncodedBody {
    var query: [String: Any] { get }
}

extension Request {
    var boundary: String {
        "---------------------------123456789abcdefghi"
    }
}

extension Request where RequestBody == EmptyRequestBody {
    var requestBody: RequestBody { EmptyRequestBody() }
}

extension Request {
    var queryParameters: [String: Any]? { nil }
}

extension Request where Response: Decodable {
    func decode(data: Data, responseUrl: URL?) throws -> Response {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        do {
            return try decoder.decode(Response.self, from: data)
        } catch {
            if let errorResponse = try? JSONDecoder().decode(MoodleAPIErrorResponse.self, from: data) {
                throw APIClientError.moodleAPIError(errorResponse)
            } else if let html = String(data: data, encoding: .utf8),
                html.contains("サイトポリシー")
            {
                throw APIClientError.policy
            } else {
                throw APIClientError.responseDecode(error)
            }
        }
    }
}

extension Request where Response == Void {
    func decode(data: Data) throws -> Response {
        return
    }
}

extension Request where RequestBody: Encodable {
    func encode(requestBody: RequestBody) throws -> Data {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .millisecondsSince1970
        return try encoder.encode(requestBody)
    }
}

extension Request where RequestBody: WwwFormUrlEncodedBody {
    func encode(requestBody: RequestBody) throws -> Data {
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "!*'();:@&=+$,/?%#[]")
        let percentEncodedQuery = query(requestBody.query, allowed: allowedCharacterSet)
        return percentEncodedQuery.data(using: .utf8) ?? Data()
    }
}

extension Request where RequestBody: MultipartFormDataBody {
    func encode(requestBody: RequestBody) throws -> Data {
        var body = Data()

        let boundaryText = "--\(boundary)\r\n"

        body.append(boundaryText.data(using: .utf8) ?? Data())
        body.append(
            "Content-Disposition: form-data; name=\"\(requestBody.name)\"; filename=\"\(requestBody.fileName)\"\r\n"
                .data(using: .utf8) ?? Data())
        body.append("Content-Type: \(requestBody.mimeType)\r\n\r\n".data(using: .utf8) ?? Data())
        body.append(requestBody.data)
        body.append("\r\n".data(using: .utf8) ?? Data())
        body.append("--\(boundary)--\r\n".data(using: .utf8) ?? Data())

        return body
    }
}

extension Request where RequestBody == Void {
    var requestBody: Void {
        ()
    }
    func encode(requestBody: RequestBody) throws -> Data {
        Data()
    }
}

extension Request {
    func generate(baseHost: String, userAgent: String) -> URLRequest {
        var request = URLRequest(url: encoded(for: URL(string: "https://\(baseHost)")!.appendingPathComponent(path)))

        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = {
            var header: [String: String] = [
                "Host": baseHost,
                "User-Agent": userAgent,
            ]

            if requestBody is Encodable {
                header["Content-Type"] = "application/json"
            } else if requestBody is WwwFormUrlEncodedBody {
                header["Content-Type"] = "application/x-www-form-urlencoded"
            } else if requestBody is MultipartFormDataBody {
                header["Content-Type"] = "multipart/form-data; boundary=\(boundary)"
            }

            return header
        }()

        if method != .get && !(requestBody is EmptyRequestBody) {
            request.httpBody = try? encode(requestBody: requestBody)
        }

        return request
    }

}

extension Request {
    fileprivate func encoded(for url: URL) -> URL {
        if var components = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let queryParameters = queryParameters, !queryParameters.isEmpty
        {

            var allowedCharacterSet = CharacterSet.urlQueryAllowed
            allowedCharacterSet.remove(charactersIn: "!*'();:@&=+$,/?%#[]")

            let percentEncodedQuery =
                (components.percentEncodedQuery.map { $0 + "&" } ?? "")
                + query(queryParameters, allowed: allowedCharacterSet)
            components.percentEncodedQuery = percentEncodedQuery
            return components.url ?? url
        }
        return url
    }

    fileprivate func query(_ parameters: [String: Any], allowed: CharacterSet = .urlQueryAllowed)
        -> String
    {
        return
            parameters
            .reduce([]) { (result, kvp) in
                result + queryComponents(fromKey: kvp.key, value: kvp.value, allowed: allowed)
            }
            .map { "\($0)=\($1)" }
            .joined(separator: "&")
    }

    fileprivate func queryComponents(
        fromKey key: String, value: Any, allowed: CharacterSet = .urlQueryAllowed
    ) -> [(String, String)] {
        var components: [(String, String)] = []

        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += queryComponents(
                    fromKey: "\(key)[\(nestedKey)]", value: value, allowed: allowed)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += queryComponents(fromKey: "\(key)[]", value: value, allowed: allowed)
            }
        } else if let value = value as? NSNumber {
            components.append((escape(key), escape("\(value)")))
        } else if let bool = value as? Bool {
            components.append((escape(key), escape(bool ? "true" : "false")))
        } else {
            components.append((escape(key), escape("\(value)", allowed: allowed)))
        }

        return components
    }

    // Reserved characters defined by RFC 3986
    // Reference: https://www.ietf.org/rfc/rfc3986.txt
    fileprivate func escape(_ string: String, allowed: CharacterSet = .urlQueryAllowed) -> String {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowedCharacterSet = allowed
        allowedCharacterSet.remove(
            charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")

        return string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

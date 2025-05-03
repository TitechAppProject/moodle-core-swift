import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct CourseContentsRequest: RestAPIRequest {
    typealias RequestBody = Void
    typealias Response = CourseContentsResponse

    let method: HTTPMethod = .get

    let queryParameters: [String: Any]?

    init(courseid: Int, wsToken: String) {
        queryParameters = [
            "moodlewsrestformat": "json",
            "wstoken": wsToken,
            "courseid": courseid,
            "wsfunction": "core_course_get_contents",
        ]
    }
}

public typealias CourseContentsResponse = [CourseContentResponse]

public struct CourseContentResponse: Codable {
    public let id: Int
    public let name: String
    public let summary: String
    public let modules: [CourseContentModule]
}

public struct CourseContentModule: Codable {
    public let id: Int
    public let modname: CourseContentModuleName
    public let url: URL?
    public let name: String
    public let instance: Int
    public let description: String?
    public let modicon: URL
    public let modplural: String
    public let completion: Int
    public let completiondata: CourseContentModuleCompletionData?
    public let contents: [CourseContentModuleContent]?
}

public struct CourseContentModuleCompletionData: Codable {
    public let state: Int
}

public enum CourseContentModuleName: String, Codable {
    case page
    case forum
    case assign
    case elvideo
    case feedback
    case resource
    case choice
    case quiz
    case url
    case folder
    case ttws
    case turnitintooltwo

    case unknown

    public init(from decoder: Decoder) throws {
        let rawValue = try decoder.singleValueContainer().decode(String.self)
        guard let value = CourseContentModuleName(rawValue: rawValue) else {
            self = .unknown
            return
        }
        self = value
    }
}

public struct CourseContentModuleContent: Codable {
    public let type: CourseContentModuleContentType
    public let filename: String
    public let filepath: String?
    public let filesize: UInt64
    public let fileurl: URL?
    public let mimetype: String?
    public let timecreated: Date?
    public let timemodified: Date?
    public let sortorder: Int?
    public let userid: Int?
    public let author: String?
    public let license: String?
}

public enum CourseContentModuleContentType: String, Codable {
    case file
    case url

    case unknown

    public init(from decoder: Decoder) throws {
        let rawValue = try decoder.singleValueContainer().decode(String.self)
        guard let value = CourseContentModuleContentType(rawValue: rawValue) else {
            self = .unknown
            return
        }
        self = value
    }
}

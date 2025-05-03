import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct CourseCategoriesRequest: RestAPIRequest {
    typealias RequestBody = Void
    typealias Response = CourseCategoriesResponse

    let method: HTTPMethod = .get

    let queryParameters: [String: Any]?

    init(wsToken: String) {
        queryParameters = [
            "moodlewsrestformat": "json",
            "wstoken": wsToken,
            "wsfunction": "core_course_get_categories",
        ]
    }
}

public typealias CourseCategoriesResponse = [CourseCategoryResponse]

public struct CourseCategoryResponse: Codable {
    public let id: Int
    public let name: String
    public let parent: Int
    public let depth: Int
    public let path: String
}

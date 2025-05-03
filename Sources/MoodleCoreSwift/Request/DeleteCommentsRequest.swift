import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct DeleteCommentsRequest: RestAPIRequest {
    typealias RequestBody = DeleteCommentsRequestBody
    typealias Response = DeleteCommentsResponse

    let method: HTTPMethod = .post

    var requestBody: RequestBody
    let queryParameters: [String: Any]?

    init(commentId: Int, wsToken: String) {
        queryParameters = [
            "moodlewsrestformat": "json",
            "wsfunction": "core_comment_delete_comments",
        ]
        let query: [String: Any] = [
            "wstoken": wsToken,
            "comments[0]": commentId,  //id of the comment (default: 0)
        ]
        self.requestBody = DeleteCommentsRequestBody(query: query)
    }
}

public struct DeleteCommentsRequestBody: WwwFormUrlEncodedBody {
    public let query: [String: Any]
}

public typealias DeleteCommentsResponse = [DeleteCommentsResponseWarning]?

public struct DeleteCommentsResponseWarning: Codable {
    public let item: String?
    public let itemid: Int?
    // The warning code can be used by the client app to implement specific behaviour.
    public let warningcode: String
    // Untranslated english message to explain the warning.
    public let message: String
}

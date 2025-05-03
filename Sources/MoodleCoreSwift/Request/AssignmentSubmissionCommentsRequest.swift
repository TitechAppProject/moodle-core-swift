import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct AssignmentSubmissionCommentsRequest: RestAPIRequest {
    typealias RequestBody = Void
    typealias Response = AssignmentSubmissionCommentsResponse

    let method: HTTPMethod = .get

    let queryParameters: [String: Any]?

    init(instanceId: Int, itemId: Int, wsToken: String) {
        queryParameters = [
            "moodlewsrestformat": "json",
            "wstoken": wsToken,
            "contextlevel": "module",
            "instanceid": instanceId,
            "component": "assignsubmission_comments",
            "itemid": itemId,
            "area": "submission_comments",
            "wsfunction": "core_comment_get_comments",
        ]
    }
}

public struct AssignmentSubmissionCommentsResponse: Codable {
    public let comments: [AssignmentSubmissionCommentResponse]  //List of comments
    public let count: Int?  //Total number of comments.
    public let perpage: Int?  //Number of comments per page.
    public let canpost: Bool?  //Whether the user can post in this comment area.
    public let warnings: [AssignmentSubmissionCommentsResponseWarning]?  //list of warnings
}

public struct AssignmentSubmissionCommentResponse: Codable {
    public let id: Int  //Comment ID
    public let content: String  //The content text formatted
    public let format: Int  //content format (1 = HTML, 0 = MOODLE, 2 = PLAIN or 4 = MARKDOWN)
    public let timecreated: Int  //Time created (timestamp)
    public let strftimeformat: String  //Time format
    public let profileurl: String  //URL profile
    public let fullname: String  //fullname
    public let time: String  //Time in human format
    public let avatar: String  //HTML user picture
    public let userid: Int  //User ID
    public let delete: Bool?  //Permission to delete=true/false
}

public struct AssignmentSubmissionCommentsResponseWarning: Codable {
    public let item: String?
    public let itemid: Int?
    // The warning code can be used by the client app to implement specific behaviour.
    public let warningcode: String
    // Untranslated english message to explain the warning.
    public let message: String
}

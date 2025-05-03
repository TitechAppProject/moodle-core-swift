import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct AddCommentsRequest: RestAPIRequest {
    typealias RequestBody = AddCommentsRequestBody
    typealias Response = AddCommentsResponse

    let method: HTTPMethod = .post

    var requestBody: RequestBody
    let queryParameters: [String: Any]?

    init(instanceId: Int, itemId: Int, comment: String, wsToken: String) {
        queryParameters = [
            "moodlewsrestformat": "json",
            "wsfunction": "core_comment_add_comments",
        ]
        let query: [String: Any] = [
            "moodlewsrestformat": "json",
            "wstoken": wsToken,
            "wsfunction": "core_comment_add_comments",
            "comments[0][contextlevel]": "module",  //contextlevel system, course, user...
            "comments[0][instanceid]": instanceId,  //the id of item associated with the contextlevel
            "comments[0][component]": "assignsubmission_comments",  //component
            "comments[0][itemid]": itemId,  //associated id
            "comments[0][area]": "submission_comments",  //string comment area (default: "")
            "comments[0][content]": comment,  //component
        ]
        self.requestBody = AddCommentsRequestBody(query: query)
    }
}

public struct AddCommentsRequestBody: WwwFormUrlEncodedBody {
    public let query: [String: Any]
}

public typealias AddCommentsResponse = [AddCommentResponse]

public struct AddCommentResponse: Codable {
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

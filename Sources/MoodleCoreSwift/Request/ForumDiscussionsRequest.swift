import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct ForumDiscussionsRequest: RestAPIRequest {
    typealias RequestBody = Void
    typealias Response = ForumDiscussionsResponse

    let method: HTTPMethod = .get

    let queryParameters: [String: Any]?

    init(wsToken: String, forumId: Int) {
        queryParameters = [
            "moodlewsrestformat": "json",
            "wstoken": wsToken,
            "wsfunction": "mod_forum_get_forum_discussions",
            "forumid": forumId,  // Forum instance id.
        ]
    }
}

public struct ForumDiscussionsResponse: Codable {
    public let discussions: [ForumDiscussionResponse]  // post
}

public struct ForumDiscussionResponse: Codable, Identifiable {
    public let id: Int  // Post id.
    public let name: String  // Discussion name.
    public let groupid: Int  // Group id.
    public let groupname: String?  // Group name (not returned by WS).
    public let timemodified: Date  // Time modified.
    public let usermodified: Int  // The id of the user who last modified.
    public let timestart: Date  // Time discussion can start.
    public let timeend: Date  // Time discussion ends.
    public let discussion: Int  // Discussion id.
    public let parent: Int  // Parent id.
    public let userid: Int  // User who started the discussion id.
    public let created: Date  // Creation time.
    public let modified: Date  // Time modified.
    public let mailed: Int  // Mailed?.
    public let subject: String  // The post subject.
    public let message: String  // The post message.
    public let messageformat: Int  // Message format (1 = HTML, 0 = MOODLE, 2 = PLAIN or 4 = MARKDOWN).
    public let messagetrust: Int  // Can we trust?.
    public let messageinlinefiles: [CoreWSExternalFile]?
    public let attachment: Bool  // Has attachments?.
    public let attachments: [CoreWSExternalFile]?
    public let totalscore: Int  // The post message total score.
    public let mailnow: Int  // Mail now?.
    //    public let userfullname: String | Bool // Post author full name.
    public let usermodifiedfullname: String  // Post modifier full name.
    public let userpictureurl: String?  // Post author picture.
    public let usermodifiedpictureurl: String  // Post modifier picture.
    public let numreplies: Int  // The number of replies in the discussion.
    public let numunread: Int  // The number of unread discussions.
    public let pinned: Bool?  // Is the discussion pinned.
    public let locked: Bool?  // Is the discussion locked.
    public let starred: Bool?  // Is the discussion starred.
    public let canreply: Bool  // Can the user reply to the discussion.
    public let canlock: Bool  // Can the user lock the discussion.
    public let canfavourite: Bool?  // Can the user star the discussion.
}

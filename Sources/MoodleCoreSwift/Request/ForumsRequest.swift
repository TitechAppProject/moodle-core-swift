import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct ForumsRequest: RestAPIRequest {
    typealias RequestBody = Void
    typealias Response = ForumsResponse

    let method: HTTPMethod = .get

    let queryParameters: [String: Any]?

    init(wsToken: String, courseId: Int?) {
        if let courseId = courseId {
            queryParameters = [
                "moodlewsrestformat": "json",
                "wstoken": wsToken,
                "wsfunction": "mod_forum_get_forums_by_courses",
                "courseids[0]": courseId,  // supports only one id
            ]
        } else {
            queryParameters = [
                "moodlewsrestformat": "json",
                "wstoken": wsToken,
                "wsfunction": "mod_forum_get_forums_by_courses",
                    // returns all forum ids that user can check
            ]
        }
    }
}

public typealias ForumsResponse = [ForumResponse]
//public struct ForumsResponse: Codable {
//    public let discussions: [ForumResponse]  // post
//}

public struct ForumResponse: Codable, Identifiable {
    public let id: Int  // Forum id. <- can use at ForumDiscussionRequest
    public let course: Int  // Course id.
    public let type: String  // The forum type.
    public let name: String  // Forum name.
    public let intro: String  // The forum intro.
    public let introformat: Int  // Intro format (1 = HTML, 0 = MOODLE, 2 = PLAIN or 4 = MARKDOWN).
    public let introfiles: [CoreWSExternalFile]?
    public let duedate: Bool?  // Duedate for the user.
    public let cutoffdate: Bool?  // Cutoffdate for the user.
    public let assessed: Int  // Aggregate type.
    public let assesstimestart: Date  // Assess start time.
    public let assesstimefinish: Date  // Assess finish time.
    public let scale: Int  // Scale.
    // eslint-disable-next-line @typescript-eslint/naming-convention
    public let grade_forum: Int  // Whole forum grade.
    // eslint-disable-next-line @typescript-eslint/naming-convention
    public let grade_forum_notify: Int  // Whether to send notifications to students upon grading by default.
    public let maxbytes: Int  // Maximum attachment size.
    public let maxattachments: Int  // Maximum number of attachments.
    public let forcesubscribe: Int  // Force users to subscribe.
    public let trackingtype: Int  // Subscription mode.
    public let rsstype: Int  // RSS feed for this activity.
    public let rssarticles: Int  // Number of RSS recent articles.
    public let timemodified: Date  // Time modified.
    public let warnafter: Int  // Post threshold for warning.
    public let blockafter: Int  // Post threshold for blocking.
    public let blockperiod: Int  // Time period for blocking.
    public let completiondiscussions: Int  // Student must create discussions.
    public let completionreplies: Int  // Student must post replies.
    public let completionposts: Int  // Student must post discussions or replies.
    public let cmid: Int  // Course module id.
    public let numdiscussions: Int?  // Number of discussions in the forum.
    public let cancreatediscussions: Bool?  // If the user can create discussions.
    public let lockdiscussionafter: Int?  // After what period a discussion is locked.
    public let istracked: Bool?  // If the user is tracking the forum.
    public let unreadpostscount: Int?  // The number of unread posts for tracked forums.
}

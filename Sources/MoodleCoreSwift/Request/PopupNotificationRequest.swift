import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct PopupNotificationRequest: RestAPIRequest {
    typealias RequestBody = Void
    typealias Response = PopupNotificationResponse

    let method: HTTPMethod = .get

    let queryParameters: [String: Any]?

    init(userId: Int, wsToken: String) {
        queryParameters = [
            "moodlewsrestformat": "json",
            "wstoken": wsToken,
            "useridto": userId,
            "wsfunction": "message_popup_get_popup_notifications",
        ]
    }
}

public struct PopupNotificationResponse: Codable {
    public let unreadcount: Int  // The number of unread message for the given user.
    public let notifications: [PopupNotification]
}

/// Notification returned by message_popup_get_popup_notifications.
public struct PopupNotification: Codable {
    public let id: Int  // Notification id (this is not guaranteed to be unique within this result set).
    public let useridfrom: Int  // User from id.
    public let useridto: Int  // User to id.
    public let subject: String  // The notification subject.
    public let shortenedsubject: String  // The notification subject shortened with ellipsis.
    public let text: String  // The message text formated.
    public let fullmessage: String  // The message.
    public let fullmessageformat: Int  // Fullmessage format (1 = HTML, 0 = MOODLE, 2 = PLAIN or 4 = MARKDOWN).
    public let fullmessagehtml: String  // The message in html.
    public let smallmessage: String  // The shorten message.
    public let contexturl: String  // Context URL.
    public let contexturlname: String  // Context URL link name.
    public let timecreated: Int  // Time created.
    public let timecreatedpretty: String  // Time created in a pretty format.
    public let timeread: Int?  // Time read.
    public let read: Bool  // Notification read status.
    public let deleted: Bool  // Notification deletion status.
    public let iconurl: String  // URL for notification icon.
    public let component: String?  // The component that generated the notification.
    public let eventtype: String?  // The type of notification.
    public let customdata: String?  // @since 3.7. Custom data to be passed to the message processor.
}

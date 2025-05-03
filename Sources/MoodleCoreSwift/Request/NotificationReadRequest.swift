import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct NotificationReadRequest: RestAPIRequest {
    typealias RequestBody = Void
    typealias Response = NotificationReadResponse

    let method: HTTPMethod = .get

    let queryParameters: [String: Any]?

    init(notificationId: Int, wsToken: String) {
        queryParameters = [
            "moodlewsrestformat": "json",
            "wstoken": wsToken,
            "notificationid": notificationId,
            "wsfunction": "core_message_mark_notification_read",
        ]
    }
}

public struct NotificationReadResponse: Codable {
    public let notificationid: Int  // Id of the notification.
    public let warnings: [NotificationReadResponseWarning]?
}

public struct NotificationReadResponseWarning: Codable {
    public let item: String?
    public let itemid: Int?
    // The warning code can be used by the client app to implement specific behaviour.
    public let warningcode: String
    // Untranslated english message to explain the warning.
    public let message: String
}

import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct UpdateActivityCompletionStatusManuallyRequest: RestAPIRequest {
    typealias RequestBody = Void
    typealias Response = UpdateActivityCompletionStatusManuallyResponse

    let method: HTTPMethod = .get

    let queryParameters: [String: Any]?

    init(moduleId: Int, completed: Bool, wsToken: String) {
        queryParameters = [
            "moodlewsrestformat": "json",
            "wstoken": wsToken,
            "wsfunction": "core_completion_update_activity_completion_status_manually",
            "cmid": moduleId,
            "completed": completed ? 1 : 0,
        ]
    }
}

public struct UpdateActivityCompletionStatusManuallyResponse: Codable {
    public let status: Bool
}

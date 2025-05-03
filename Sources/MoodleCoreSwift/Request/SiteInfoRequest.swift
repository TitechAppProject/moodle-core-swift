import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct SiteInfoRequest: RestAPIRequest {
    typealias RequestBody = Void
    typealias Response = SiteInfoResponse

    let method: HTTPMethod = .get

    let queryParameters: [String: Any]?

    init(wsToken: String) {
        queryParameters = [
            "moodlewsrestformat": "json",
            "wstoken": wsToken,
            "wsfunction": "core_webservice_get_site_info",
        ]
    }
}

public struct SiteInfoResponse {
    public let userid: Int
    public let username: String
    public let fullname: String
    public let firstname: String
    public let lastname: String
}

extension SiteInfoResponse: Codable {}

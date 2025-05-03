import Foundation

protocol RestAPIRequest: Request {}

extension RestAPIRequest {
    var path: String {
        "webservice/rest/server.php"
    }
}

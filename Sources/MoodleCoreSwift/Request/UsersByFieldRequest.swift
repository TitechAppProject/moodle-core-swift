import Foundation

struct UsersByFieldRequest: RestAPIRequest {
    typealias RequestBody = Void
    typealias Response = UsersByFieldResponse

    let method: HTTPMethod = .get

    let queryParameters: [String: Any]?

    init(userIds: [Int], wsToken: String) {
        var q: [String: Any] = [
            "moodlewsrestformat": "json",
            "wstoken": wsToken,
            "wsfunction": "core_user_get_users_by_field",
            "field": "id",
        ]

        for userId in userIds.enumerated() {
            q["values[\(userId.offset)]"] = userId.element
        }

        queryParameters = q
    }
}

public typealias UsersByFieldResponse = [UserByFieldResponse]

public struct UserByFieldResponse: Decodable {
    public let id: Int  // ID of the user.
    public let username: String?  // The username.
    public let firstname: String?  // The first name(s) of the user.
    public let lastname: String?  // The family name of the user.
    public let fullname: String  // The fullname of the user.
    public let email: String?  // An email address - allow email as root@localhost.
    public let address: String?  // Postal address.
    public let phone1: String?  // Phone 1.
    public let phone2: String?  // Phone 2.
    public let icq: String?  // Icq number.
    public let skype: String?  // Skype id.
    public let yahoo: String?  // Yahoo id.
    public let aim: String?  // Aim id.
    public let msn: String?  // Msn number.
    public let department: String?  // Department.
    public let institution: String?  // Institution.
    public let idnumber: String?  // An arbitrary ID code number perhaps from the institution.
    public let interests: String?  // User interests (separated by commas).
    public let firstaccess: Date?  // First access to the site (0 if never).
    public let lastaccess: Date?  // Last access to the site (0 if never).
    public let auth: String?  // Auth plugins include manual, ldap, etc.
    public let suspended: Bool?  // Suspend user account, either false to enable user login or true to disable it.
    public let confirmed: Bool?  // Active user: 1 if confirmed, 0 otherwise.
    public let lang: String?  // Language code such as "en", must exist on server.
    public let calendartype: String?  // Calendar type such as "gregorian", must exist on server.
    public let theme: String?  // Theme name such as "standard", must exist on server.
    public let timezone: String?  // Timezone code such as Australia/Perth, or 99 for default.
    public let mailformat: Int?  // Mail format code is 0 for plain text, 1 for HTML etc.
    public let description: String?  // User profile description.
    public let descriptionformat: Int?  // Int format (1 = HTML, 0 = MOODLE, 2 = PLAIN or 4 = MARKDOWN).
    public let city: String?  // Home city of the user.
    public let url: String?  // URL of the user.
    public let country: String?  // Home country code of the user, such as AU or CZ.
    public let profileimageurlsmall: String  // User image profile URL - small version.
    public let profileimageurl: String  // User image profile URL - big version.
    // public let customfields?: CoreUserProfileField[] // User custom fields (also known as user profile fields).
    // public let preferences?: CoreUserPreference[] // Users preferences.
}

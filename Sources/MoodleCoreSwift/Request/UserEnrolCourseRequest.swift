import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct UserEnrolCoursesRequest: RestAPIRequest {
    typealias RequestBody = Void
    typealias Response = UserEnrolCoursesResponse

    let method: HTTPMethod = .get

    let queryParameters: [String: Any]?

    init(userId: Int, wsToken: String) {
        queryParameters = [
            "moodlewsrestformat": "json",
            "wstoken": wsToken,
            "wsfunction": "core_enrol_get_users_courses",
            "userid": userId,
        ]
    }
}

public typealias UserEnrolCoursesResponse = [UserEnrolCourseResponse]

public struct UserEnrolCourseResponse {
    public let id: Int  // Course id.
    public let fullname: String  // Course full name.
    public let displayname: String?  // Course display name.
    public let shortname: String  // Course short name.
    public let summary: String  // Summary.
    public let summaryformat: Int  // Summary format (1 = HTML, 0 = MOODLE, 2 = PLAIN or 4 = MARKDOWN).
    public let categoryid: Int?  // Course category id.
    public let idnumber: String?  // Id number of course.
    public let visible: Int?  // 1 means visible, 0 means not yet visible course.
    public let format: String?  // Course format: weeks, topics, social, site.
    public let showgrades: Bool?  // True if grades are shown, otherwise false.
    public let lang: String?  // Forced course language.
    public let enablecompletion: Bool?  // True if completion is enabled, otherwise false.
    public let startdate: Date?  // Timestamp when the course start.
    public let enddate: Date?  // Timestamp when the course end.
    public let enrolledusercount: Int?  // Number of enrolled users in this course.
    public let completionhascriteria: Bool?  // If completion criteria is set.
    public let completionusertracked: Bool?  // If the user is completion tracked.
    public let progress: Double?  // Progress percentage.
    public let completed: Bool?  // Whether the course is completed.
    public let marker: Int?  // Course section marker.
    public let lastaccess: Date?  // Last access to the course (timestamp).
    public let isfavourite: Bool?  // If the user marked this course a favourite.
    public let hidden: Bool?  // If the user hide the course from the dashboard.
    //    public let overviewfiles?: CoreWSExternalFile[]
    public let showactivitydates: Bool?  // @since 3.11. Whether the activity dates are shown or not.
    public let showcompletionconditions: Bool?  // @since 3.11. Whether the activity completion conditions are shown or not.
    public let category: Int?  // Course category id.
}

extension UserEnrolCourseResponse: Codable {}

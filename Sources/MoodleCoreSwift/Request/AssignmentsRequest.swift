import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct AssignmentsRequest: RestAPIRequest {
    typealias RequestBody = Void
    typealias Response = AssignmentsResponse

    let method: HTTPMethod = .get

    let queryParameters: [String: Any]?

    init(wsToken: String) {
        queryParameters = [
            "moodlewsrestformat": "json",
            "wstoken": wsToken,
            "wsfunction": "mod_assign_get_assignments",
        ]
    }
}

public struct AssignmentsResponse: Codable {
    public let courses: [AssignmentCourseResponse]  // List of courses.

}

public struct AssignmentCourseResponse: Codable {
    public let id: Int  // Course id.
    public let fullname: String  // Course full name.
    public let shortname: String  // Course short name.
    public let timemodified: Date  // Last time modified.
    public let assignments: [AssignmentResponse]  // Assignment info.
}

public struct AssignmentResponse: Codable {
    public let id: Int  // Assignment id.
    public let cmid: Int  // Course module id.
    public let course: Int  // Course id.
    public let name: String  // Assignment name.
    public let nosubmissions: Int  // No submissions.
    public let submissiondrafts: Int  // Submissions drafts.
    public let sendnotifications: Int  // Send notifications.
    public let sendlatenotifications: Int  // Send notifications.
    public let sendstudentnotifications: Int  // Send student notifications (default).
    public let duedate: Date  // Assignment due date.
    public let allowsubmissionsfromdate: Date  // Allow submissions from date.
    public let grade: Int  // Grade type.
    public let timemodified: Date  // Last time assignment was modified.
    public let completionsubmit: Int  // If enabled, set activity as complete following submission.
    public let cutoffdate: Date  // Date after which submission is not accepted without an extension.
    public let gradingduedate: Date?  // @since 3.3. The expected date for marking the submissions.
    public let teamsubmission: Int  // If enabled, students submit as a team.
    public let requireallteammemberssubmit: Int  // If enabled, all team members must submit.
    public let teamsubmissiongroupingid: Int  // The grouping id for the team submission groups.
    public let blindmarking: Int  // If enabled, hide identities until reveal identities actioned.
    public let hidegrader: Int?  // @since 3.7. If enabled, hide grader to student.
    public let revealidentities: Int  // Show identities for a blind marking assignment.
    public let attemptreopenmethod: String  // Method used to control opening new attempts.
    public let maxattempts: Int  // Maximum number of attempts allowed.
    public let markingworkflow: Int  // Enable marking workflow.
    public let markingallocation: Int  // Enable marking allocation.
    public let requiresubmissionstatement: Int  // Student must accept submission statement.
    public let preventsubmissionnotingroup: Int?  // @since 3.2. Prevent submission not in group.
    public let submissionstatement: String?  // @since 3.2. Submission statement formatted.
    public let submissionstatementformat: Int?  // @since 3.2. Submissionstatement format (1 = HTML, 0 = MOODLE, 2 = PLAIN or 4 = MARKDOWN).
    //    public let configs: AddonModAssignConfig[]; // Configuration settings.
    public let intro: String?  // Assignment intro, not allways returned because it deppends on the activity configuration.
    public let introformat: Int?  // Intro format (1 = HTML, 0 = MOODLE, 2 = PLAIN or 4 = MARKDOWN).
    public let introfiles: [CoreWSExternalFile]?  // @since 3.2.
    public let introattachments: [CoreWSExternalFile]?
}

/// Structure of files returned by WS.
public struct CoreWSExternalFile: Codable {
    /**
     * File name.
     */
    public let filename: String?

    /**
     * File path.
     */
    public let filepath: String?

    /**
     * File size.
     */
    public let filesize: Int?

    /**
     * Downloadable file url.
     */
    public let fileurl: String?

    /**
     * Time modified.
     */
    public let timemodified: Date?

    /**
     * File mime type.
     */
    public let mimetype: String?

    /**
     * Whether is an external file.
     */
    public let isexternalfile: Bool?

    /**
     * The repository type for external files.
     */
    public let repositorytype: String?
}

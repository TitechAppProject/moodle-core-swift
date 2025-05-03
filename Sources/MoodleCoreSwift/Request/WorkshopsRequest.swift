import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct WorkshopsRequest: RestAPIRequest {
    typealias RequestBody = Void
    typealias Response = WorkshopsResponse

    let method: HTTPMethod = .get

    let queryParameters: [String: Any]?

    init(wsToken: String) {
        queryParameters = [
            "moodlewsrestformat": "json",
            "wstoken": wsToken,
            "wsfunction": "mod_workshop_get_workshops_by_courses",
        ]
    }
}

public struct WorkshopsResponse: Codable {
    public let workshops: [WorkshopResponse]

}

public struct WorkshopResponse: Codable {
    public let id: Int  // The primary key of the record.
    public let course: Int  // Course id this workshop is part of.
    public let name: String  // Workshop name.
    public let intro: String  // Workshop introduction text.
    public let introformat: Int?  // Intro format (1 = HTML, 0 = MOODLE, 2 = PLAIN or 4 = MARKDOWN).
    public let instructauthors: String?  // Instructions for the submission phase.
    public let instructauthorsformat: Int?  // Instructauthors format (1 = HTML, 0 = MOODLE, 2 = PLAIN or 4 = MARKDOWN).
    public let instructreviewers: String?  // Instructions for the assessment phase.
    public let instructreviewersformat: Int?  // Instructreviewers format (1 = HTML, 0 = MOODLE, 2 = PLAIN or 4 = MARKDOWN).
    public let timemodified: Date?  // The timestamp when the module was modified.
    public let phase: Int  // The current phase of workshop.
    public let useexample: Bool?  // Optional feature: students practise evaluating on example submissions from teacher.
    public let usepeerassessment: Bool?  // Optional feature: students perform peer assessment of others' work.
    public let useselfassessment: Bool?  // Optional feature: students perform self assessment of their own work.
    public let grade: Double?  // The maximum grade for submission.
    public let gradinggrade: Double?  // The maximum grade for assessment.
    public let strategy: String?  // The type of the current grading strategy used in this workshop.
    public let evaluation: String?  // The recently used grading evaluation method.
    public let gradedecimals: Int?  // Number of digits that should be shown after the decimal point when displaying grades.
    public let submissiontypetext: Int?  // Indicates whether text is required as part of each submission. 0 for no, 1 for optional, 2 for required.
    public let submissiontypefile: Int?  // Indicates whether a file upload is required as part of each submission. 0 for no, 1 for optional, 2 for required.
    public let nattachments: Int?  // Maximum number of submission attachments.
    public let submissionfiletypes: String?  // Comma separated list of file extensions.
    public let latesubmissions: Bool?  // Allow submitting the work after the deadline.
    public let maxbytes: Int?  // Maximum size of the one attached file.
    public let examplesmode: Int?  // 0 = example assessments are voluntary, 1 = examples must be assessed before submission, 2 = examples are available after own submission and must be assessed before peer/self assessment phase.
    public let submissionstart: Date?  // 0 = will be started manually, greater than 0 the timestamp of the start of the submission phase.
    public let submissionend: Date?  // 0 = will be closed manually, greater than 0 the timestamp of the end of the submission phase.
    public let assessmentstart: Date?  // 0 = will be started manually, greater than 0 the timestamp of the start of the assessment phase.
    public let assessmentend: Date?  // 0 = will be closed manually, greater than 0 the timestamp of the end of the assessment phase.
    public let phaseswitchassessment: Bool?  // Automatically switch to the assessment phase after the submissions deadline.
    public let conclusion: String?  // A text to be displayed at the end of the workshop.
    public let conclusionformat: Int?  // Conclusion format (1 = HTML, 0 = MOODLE, 2 = PLAIN or 4 = MARKDOWN).
    public let overallfeedbackmode: Int?  // Mode of the overall feedback support.
    public let overallfeedbackfiles: Int?  // Number of allowed attachments to the overall feedback.
    public let overallfeedbackfiletypes: String?  // Comma separated list of file extensions.
    public let overallfeedbackmaxbytes: Int?  // Maximum size of one file attached to the overall feedback.
    public let coursemodule: Int?  // Coursemodule.
    public let introfiles: [CoreWSExternalFile]?  // Introfiles.
    public let instructauthorsfiles: [CoreWSExternalFile]?  // Instructauthorsfiles.
    public let instructreviewersfiles: [CoreWSExternalFile]?  // Instructreviewersfiles.
    public let conclusionfiles: [CoreWSExternalFile]?  // Conclusionfiles.
}

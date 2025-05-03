import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct QuizzesRequest: RestAPIRequest {
    typealias RequestBody = Void
    typealias Response = QuizzesResponse

    let method: HTTPMethod = .get

    let queryParameters: [String: Any]?

    init(wsToken: String) {
        queryParameters = [
            "moodlewsrestformat": "json",
            "wstoken": wsToken,
            "wsfunction": "mod_quiz_get_quizzes_by_courses",
        ]
    }
}

public struct QuizzesResponse: Codable {
    public let quizzes: [QuizResponse]

}

public struct QuizResponse: Codable {
    public let id: Int  //  Standard Moodle primary key.
    public let course: Int  //  Foreign key reference to the course this quiz is part of.
    public let coursemodule: Int  //  Course module id.
    public let name: String  //  Quiz name.
    public let intro: String?  //  Quiz introduction text.
    public let introformat: Int?  //  intro format (1 = HTML, 0 = MOODLE, 2 = PLAIN or 4 = MARKDOWN)
    //  public let introfiles: [File] //  Files in the introduction text
    public let timeopen: Date?  //  The time when this quiz opens. (0 = no restriction.)
    public let timeclose: Date?  //  The time when this quiz closes. (0 = no restriction.)
    public let timelimit: Date?  //  The time limit for quiz attempts, in seconds.
    public let overduehandling: String?  //  The method used to handle overdue attempts. 'autosubmit', 'graceperiod' or 'autoabandon'.
    public let graceperiod: Date?  //  The amount of time (in seconds) after the time limit runs out during which attempts can still be submitted, if overduehandling is set to allow it.
    public let preferredbehaviour: String?  //  The behaviour to ask questions to use.
    public let canredoquestions: Int?  //  Allows students to redo any completed questionwithin a quiz attempt.
    public let attempts: Int?  //  The maximum number of attempts a student is allowed.
    public let attemptonlast: Int?  //  Whether subsequent attempts start from the answer to the previous attempt (1) or start blank (0).
    public let grademethod: Int?  //  One of the values QUIZ_GRADEHIGHEST, QUIZ_GRADEAVERAGE, QUIZ_ATTEMPTFIRST or QUIZ_ATTEMPTLAST.
    public let decimalpoints: Int?  //  Number of decimal points to use when displaying grades.
    public let questiondecimalpoints: Int?  //  Number of decimal points to use when displaying question grades. (-1 means use decimalpoints.)
    public let reviewattempt: Int?  //  Whether users are allowed to review their quiz attempts at various times. This is a bit field, decoded by the mod_quiz_display_options class. It is formed by ORing together the constants defined there.
    public let reviewcorrectness: Int?  //  Whether users are allowed to review their quizattempts at various times.A bit field, like reviewattempt.
    public let reviewmarks: Int?  //  Whether users are allowed to review their quiz attempts at various times. A bit field, like reviewattempt.
    public let reviewspecificfeedback: Int?  //  Whether users are allowed to review their quiz attempts at various times. A bit field, like reviewattempt.
    public let reviewgeneralfeedback: Int?  //  Whether users are allowed to review their quiz attempts at various times. A bit field, like reviewattempt.
    public let reviewrightanswer: Int?  //  Whether users are allowed to review their quizattempts at various times. A bit field, likereviewattempt.
    public let reviewoverallfeedback: Int?  //  Whether users are allowed to review their quiz attempts at various times. A bit field, like reviewattempt.
    public let questionsperpage: Int?  //  How often to insert a page break when editingthe quiz, or when shuffling the question order.
    public let navmethod: String?  //  Any constraints on how the user is allowed to navigate around the quiz. Currently recognised values are 'free' and 'seq'.
    public let shuffleanswers: Int?  //  Whether the parts of the question should be shuffled, in those question types that support it.
    public let sumgrades: Double  //  The total of all the question instance maxmarks.
    public let grade: Double  //  The total that the quiz overall grade is scaled to beout of.
    public let timecreated: Date?  //  The time when the quiz was added to the course.
    public let timemodified: Date?  //  Last modified time.
    public let password: String?  //  A password that the student must enter before starting or continuing a quiz attempt.
    public let subnet: String?  //  Used to restrict the IP addresses from which this quiz canbe attempted. The format is as requried by the address_in_subnetfunction.
    public let browsersecurity: String?  //  Restriciton on the browser the student must use. E.g. 'securewindow'.
    public let delay1: Int?  //  Delay that must be left between the first and second attempt,in seconds.
    public let delay2: Int?  //  Delay that must be left between the second and subsequentattempt, in seconds.
    public let showuserpicture: Int?  //  Option to show the user's picture during the attempt and on the review page.
    public let showblocks: Int?  //  Whether blocks should be shown on the attempt.php and review.php pages.
    public let completionattemptsexhausted: Int?  //  Mark quiz complete when the student has exhausted the maximum number of attempts
    public let completionpass: Int?  //  Whether to require passing grade
    public let allowofflineattempts: Int?  //  Whether to allow the quiz to be attempted offline in the mobile app
    public let autosaveperiod: Int?  //  Auto-save delay
    public let hasfeedback: Int?  //  Whether the quiz has any non-blank feedback text
    public let hasquestions: Int?  //  Whether the quiz has questions
    public let section: Int?  //  Course section id
    //  Bool | Int のどちらも入る可能性があり、使わないのでコメントアウト
    //    public let visible: Bool?  //  Module visibility
    public let groupmode: Int?  //  Group mode
    public let groupingid: Int?  //  Grouping id

}

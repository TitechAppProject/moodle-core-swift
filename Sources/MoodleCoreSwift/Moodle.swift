import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public struct Moodle {
    let apiClient: APIClient

    public init(
        baseURL: URL,
        userAgent: String,
        urlSession: URLSession = .shared
    ) {
        self.apiClient = APIClientImpl(baseURL: baseURL, userAgent: userAgent, urlSession: urlSession)
    }

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    public func getSiteInfo(wsToken: String) async throws -> SiteInfoResponse {
        try await apiClient.send(request: SiteInfoRequest(wsToken: wsToken))
    }

    public func getUsersByField(userIds: [Int], wsToken: String) async throws -> UsersByFieldResponse {
        try await apiClient.send(request: UsersByFieldRequest(userIds: userIds, wsToken: wsToken))
    }

    public func getUserCourses(userId: Int, wsToken: String) async throws -> UserEnrolCoursesResponse {
        try await apiClient.send(request: UserEnrolCoursesRequest(userId: userId, wsToken: wsToken))
    }

    public func getCourseCategories(wsToken: String) async throws -> CourseCategoriesResponse {
        try await apiClient.send(request: CourseCategoriesRequest(wsToken: wsToken))
    }

    public func getCourseContents(courseId: Int, wsToken: String) async throws -> CourseContentsResponse {
        try await apiClient.send(request: CourseContentsRequest(courseid: courseId, wsToken: wsToken))
    }

    public func getAssignments(wsToken: String) async throws -> AssignmentsResponse {
        try await apiClient.send(request: AssignmentsRequest(wsToken: wsToken))
    }

    public func getAssignmentSubmissionStatus(assignmentId: Int, userId: Int, wsToken: String) async throws -> AssignmentSubmissionStatusResponse {
        try await apiClient.send(request: AssignmentSubmissionStatusRequest(assignmentId: assignmentId, userId: userId, wsToken: wsToken))
    }

    public func updateActivityCompletionStatusManually(moduleId: Int, completed: Bool, wsToken: String) async throws -> UpdateActivityCompletionStatusManuallyResponse {
        try await apiClient.send(request: UpdateActivityCompletionStatusManuallyRequest(moduleId: moduleId, completed: completed, wsToken: wsToken))
    }

    public func getPopupNotification(userId: Int, wsToken: String) async throws -> PopupNotificationResponse {
        try await apiClient.send(request: PopupNotificationRequest(userId: userId, wsToken: wsToken))
    }

    public func markNotificationRead(notificationId: Int, wsToken: String) async throws -> NotificationReadResponse {
        try await apiClient.send(request: NotificationReadRequest(notificationId: notificationId, wsToken: wsToken))
    }

    public func getAssignmentSubmissionComments(instanceId: Int, itemId: Int, wsToken: String) async throws -> AssignmentSubmissionCommentsResponse {
        try await apiClient.send(request: AssignmentSubmissionCommentsRequest(instanceId: instanceId, itemId: itemId, wsToken: wsToken))
    }

    public func addComments(instanceId: Int, itemId: Int, comment: String, wsToken: String) async throws -> AddCommentsResponse {
        try await apiClient.send(request: AddCommentsRequest(instanceId: instanceId, itemId: itemId, comment: comment, wsToken: wsToken))
    }

    public func deleteComments(commentId: Int, wsToken: String) async throws -> DeleteCommentsResponse {
        try await apiClient.send(request: DeleteCommentsRequest(commentId: commentId, wsToken: wsToken))
    }

    public func getQuizzes(wsToken: String) async throws -> QuizzesResponse {
        try await apiClient.send(request: QuizzesRequest(wsToken: wsToken))
    }

    public func getWorkshops(wsToken: String) async throws -> WorkshopsResponse {
        try await apiClient.send(request: WorkshopsRequest(wsToken: wsToken))
    }

    public func getForumDiscussions(wsToken: String, forumId: Int) async throws -> ForumDiscussionsResponse {
        try await apiClient.send(request: ForumDiscussionsRequest(wsToken: wsToken, forumId: forumId))
    }

    public func getForumByCourse(wsToken: String, courseId: Int?) async throws -> ForumsResponse {
        try await apiClient.send(request: ForumsRequest(wsToken: wsToken, courseId: courseId))
    }
}

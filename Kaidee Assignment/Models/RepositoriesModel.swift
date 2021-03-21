import Foundation

struct RepositoriesModel: Codable, Equatable {
    let id: Int?
    let nodeId: String?
    let name: String?
    let fullName: String?
    let isPrivate: Bool?
    let owner: UserModel?
    let htmlUrl: String?
    let description: String?
    let fork: Bool?
    let url: String?
    let forksUrl: String?
    let keysUrlsUrl: String?
    let collaboratorsUrl: String?
    let teamsUrl: String?
    let hooksUrl: String?
    let issueEventsUrl: String?
    let eventsUrl: String?
    let assigneesUrl: String?
    let branchesUrl: String?
    let tagsUrl: String?
    let blobsUrl: String?
    let gitTagsUrl: String?
    let gitRefsUrl: String?
    let treesUrl: String?
    let statusesUrl: String?
    let languagesUrl: String?
    let stargazersUrl: String?
    let contributorsUrl: String?
    let subscribersUrl: String?
    let subscriptionUrl: String?
    let commitsUrl: String?
    let gitCommitsUrl: String?
    let commentsUrl: String?
    let issueCommentUrl: String?
    let contentsUrl: String?
    let compareUrl: String?
    let mergesUrl: String?
    let archiveUrl: String?
    let downloadsUrl: String?
    let issuesUrl: String?
    let pullsUrl: String?
    let milestonesUrl: String?
    let notificationsUrl: String?
    let labelsUrl: String?
    let releasesUrl: String?
    let deploymentsUrl: String?
    let createdAt: String?
    let updatedAt: String?
    let pushedAt: String?
    let gitUrl: String?
    let sshUrl: String?
    let cloneUrl: String?
    let svnUrl: String?
    let homepage: String?
    let size: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case nodeId = "node_id"
        case name
        case fullName = "full_name"
        case isPrivate = "private"
        case owner
        case htmlUrl = "html_url"
        case description
        case fork
        case url
        case forksUrl = "forks_url"
        case keysUrlsUrl = "keys_url"
        case collaboratorsUrl = "collaborators_url"
        case teamsUrl = "teams_url"
        case hooksUrl = "hooks_url"
        case issueEventsUrl = "issue_events_url"
        case eventsUrl = "events_url"
        case assigneesUrl = "assignees_url"
        case branchesUrl = "branches_url"
        case tagsUrl = "tags_url"
        case blobsUrl = "blobs_url"
        case gitTagsUrl = "git_tags_url"
        case gitRefsUrl = "git_refs_url"
        case treesUrl = "trees_url"
        case statusesUrl = "statuses_url"
        case languagesUrl = "languages_url"
        case stargazersUrl = "stargazers_url"
        case contributorsUrl = "contributors_url"
        case subscribersUrl = "subscribers_url"
        case subscriptionUrl = "subscription_url"
        case commitsUrl = "commits_url"
        case gitCommitsUrl = "git_commits_url"
        case commentsUrl = "comments_url"
        case issueCommentUrl = "issue_comment_url"
        case contentsUrl = "contents_url"
        case compareUrl = "compare_url"
        case mergesUrl = "merges_url"
        case archiveUrl = "archive_url"
        case downloadsUrl = "downloads_url"
        case issuesUrl = "issues_url"
        case pullsUrl = "pulls_url"
        case milestonesUrl = "milestones_url"
        case notificationsUrl = "notifications_url"
        case labelsUrl = "labels_url"
        case releasesUrl = "releases_url"
        case deploymentsUrl = "deployments_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case gitUrl = "git_url"
        case sshUrl = "ssh_url"
        case cloneUrl = "clone_url"
        case svnUrl = "svn_url"
        case homepage
        case size
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        nodeId = try values.decodeIfPresent(String.self, forKey: .nodeId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
        isPrivate = try values.decodeIfPresent(Bool.self, forKey: .isPrivate)
        owner = try values.decodeIfPresent(UserModel.self, forKey: .owner)
        htmlUrl = try values.decodeIfPresent(String.self, forKey: .htmlUrl)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        fork = try values.decodeIfPresent(Bool.self, forKey: .fork)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        forksUrl = try values.decodeIfPresent(String.self, forKey: .forksUrl)
        keysUrlsUrl = try values.decodeIfPresent(String.self, forKey: .keysUrlsUrl)
        collaboratorsUrl = try values.decodeIfPresent(String.self, forKey: .collaboratorsUrl)
        teamsUrl = try values.decodeIfPresent(String.self, forKey: .teamsUrl)
        hooksUrl = try values.decodeIfPresent(String.self, forKey: .hooksUrl)
        issueEventsUrl = try values.decodeIfPresent(String.self, forKey: .issueEventsUrl)
        eventsUrl = try values.decodeIfPresent(String.self, forKey: .eventsUrl)
        assigneesUrl = try values.decodeIfPresent(String.self, forKey: .assigneesUrl)
        branchesUrl = try values.decodeIfPresent(String.self, forKey: .branchesUrl)
        tagsUrl = try values.decodeIfPresent(String.self, forKey: .tagsUrl)
        blobsUrl = try values.decodeIfPresent(String.self, forKey: .blobsUrl)
        gitTagsUrl = try values.decodeIfPresent(String.self, forKey: .gitTagsUrl)
        gitRefsUrl = try values.decodeIfPresent(String.self, forKey: .gitRefsUrl)
        treesUrl = try values.decodeIfPresent(String.self, forKey: .treesUrl)
        statusesUrl = try values.decodeIfPresent(String.self, forKey: .statusesUrl)
        languagesUrl = try values.decodeIfPresent(String.self, forKey: .languagesUrl)
        stargazersUrl = try values.decodeIfPresent(String.self, forKey: .stargazersUrl)
        contributorsUrl = try values.decodeIfPresent(String.self, forKey: .contributorsUrl)
        subscribersUrl = try values.decodeIfPresent(String.self, forKey: .subscribersUrl)
        subscriptionUrl = try values.decodeIfPresent(String.self, forKey: .subscriptionUrl)
        commitsUrl = try values.decodeIfPresent(String.self, forKey: .commitsUrl)
        gitCommitsUrl = try values.decodeIfPresent(String.self, forKey: .gitCommitsUrl)
        commentsUrl = try values.decodeIfPresent(String.self, forKey: .commentsUrl)
        issueCommentUrl = try values.decodeIfPresent(String.self, forKey: .issueCommentUrl)
        contentsUrl = try values.decodeIfPresent(String.self, forKey: .contentsUrl)
        compareUrl = try values.decodeIfPresent(String.self, forKey: .compareUrl)
        mergesUrl = try values.decodeIfPresent(String.self, forKey: .mergesUrl)
        archiveUrl = try values.decodeIfPresent(String.self, forKey: .archiveUrl)
        downloadsUrl = try values.decodeIfPresent(String.self, forKey: .downloadsUrl)
        issuesUrl = try values.decodeIfPresent(String.self, forKey: .issuesUrl)
        pullsUrl = try values.decodeIfPresent(String.self, forKey: .pullsUrl)
        milestonesUrl = try values.decodeIfPresent(String.self, forKey: .milestonesUrl)
        notificationsUrl = try values.decodeIfPresent(String.self, forKey: .notificationsUrl)
        labelsUrl = try values.decodeIfPresent(String.self, forKey: .labelsUrl)
        releasesUrl = try values.decodeIfPresent(String.self, forKey: .releasesUrl)
        deploymentsUrl = try values.decodeIfPresent(String.self, forKey: .deploymentsUrl)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        pushedAt = try values.decodeIfPresent(String.self, forKey: .pushedAt)
        gitUrl = try values.decodeIfPresent(String.self, forKey: .gitUrl)
        sshUrl = try values.decodeIfPresent(String.self, forKey: .sshUrl)
        cloneUrl = try values.decodeIfPresent(String.self, forKey: .cloneUrl)
        svnUrl = try values.decodeIfPresent(String.self, forKey: .svnUrl)
        homepage = try values.decodeIfPresent(String.self, forKey: .homepage)
        size = try values.decodeIfPresent(Int.self, forKey: .size)
    }
}

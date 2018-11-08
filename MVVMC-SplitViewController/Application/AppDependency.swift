//
//  AppDependency.swift
//  MVVMC-SplitViewController
//
//  Created by Mathew Gacy on 1/2/18.
//  Copyright © 2018 Mathew Gacy. All rights reserved.
//

import Foundation

// MARK: - A
// http://merowing.info/2017/04/using-protocol-compositon-for-dependency-injection/
// https://www.swiftbysundell.com/posts/dependency-injection-using-factories-in-swift

protocol HasClient {
    var client: APIClient { get }
}

protocol HasUserManager {
    var userManager: UserManager { get }
}

protocol HasAlbumService {
    var albumService: AlbumServiceType { get }
}

protocol HasPostService {
    var postService: PostServiceType { get }
}

protocol HasTodoService {
    var todoService: TodoServiceType { get }
}

struct AppDependency: HasClient, HasUserManager, HasAlbumService, HasPostService, HasTodoService {
    let client: APIClient
    let userManager: UserManager
    let albumService: AlbumServiceType
    let postService: PostServiceType
    let todoService: TodoServiceType

    init() {
        self.client = APIClient()
        self.userManager = UserManager()
        self.albumService = AlbumService(client: client)
        self.postService = PostService(client: client)
        self.todoService = TodoService(client: client)
    }

}

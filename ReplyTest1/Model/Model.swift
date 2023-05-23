//
//  Model.swift
//  ReplyTest1
//
//  Created by PTK on 2023/05/22.
//

import Foundation

class Comment {
    var commentId: Int
    var commentText: String
    var replies: [Reply]

    init(commentId: Int, commentText: String, replies: [Reply]) {
        self.commentId = commentId
        self.commentText = commentText
        self.replies = replies
    }
}

class Reply {
    var replyId: Int
    var replyText: String

    init(replyId: Int, replyText: String) {
        self.replyId = replyId
        self.replyText = replyText
    }
}

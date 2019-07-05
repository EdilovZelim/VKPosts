//
//  NewsfeedModels.swift
//  VKPosts
//
//  Created by MacBook on 23/05/2019.
//  Copyright (c) 2019 Зелимхан Эдилов. All rights reserved.
//

import UIKit

enum Newsfeed {
   
  enum Model {
    struct Request {
      enum RequestType {
       case getNewsfeed
        case revealPostIds(postId: Int)
      }
    }
    
    struct Response {
      enum ResponseType {
        case presentNewsfeed(feed: FeedResponse, revealedPostIds: [Int])
        
      }
    }
    
    struct ViewModel {
      enum ViewModelData {
        case displayNewsfeed(feedViewModel: FeedViewModel)
      }
    }
  }
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
    
        var postId: Int
        
        var sizes: FeedCellSizes
        var iconUrl: String
        var name: String
        var date: String
        var text: String?
        var lakes: String?
        var comments: String?
        var shares: String?
        var views: String?
        var photoAttachments: [FeedCellPhotoAttachmentViewModel]
    }
    
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
        var photoUrlString: String?
        var width: Int
        var height: Int
    }
    
    let cells: [Cell]
}

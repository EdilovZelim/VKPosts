//
//  NewsfeedLayoutCalculator.swift
//  VKPosts
//
//  Created by MacBook on 07/06/2019.
//  Copyright © 2019 Зелимхан Эдилов. All rights reserved.
//

import Foundation
import UIKit

struct Sizes:FeedCellSizes {
    var moreTexButtonFrame: CGRect
    
    var bottomView: CGRect
    var totalHeight: CGFloat
    
    var postLabelFrame: CGRect
    var attachmentFrame: CGRect
}

struct Constsnts {
    static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
    static let topViewHeight: CGFloat = 50
    static let postLabelInsets = UIEdgeInsets(top: 8 + Constsnts.topViewHeight + 8, left: 8, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    static let bottomViewHeight: CGFloat = 44
    static let bottomViewViewHeight: CGFloat = 39
    static let bottomViewViewWidth: CGFloat = 76
    static let bottomViewViewsIconSize: CGFloat = 24
    static let minifiedPostLimitLines: CGFloat = 8
    static let minifiedPostLines: CGFloat = 6
    static let moreTextButtonSize = CGSize(width: 170, height: 30)
    static let moreTextButtonInsets = UIEdgeInsets(top: 0, left: 8 , bottom: 0, right: 0)
}

protocol FCLCP {
    func sizes(postTex: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizedPost: Bool) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FCLCP {
    
    private let screenWidth: CGFloat
    init(screenWidth: CGFloat) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postTex: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizedPost: Bool) -> FeedCellSizes {
        
        var showMoreTextButton = false
        
        let cardViewWidth = screenWidth - Constsnts.cardInsets.left - Constsnts.cardInsets.right
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constsnts.postLabelInsets.left, y: Constsnts.postLabelInsets.top), size: CGSize.zero)
        
        if let text = postTex, !text.isEmpty {
            let width = cardViewWidth - Constsnts.postLabelInsets.left - Constsnts.postLabelInsets.right
            var height = text.height(width: width, font: Constsnts.postLabelFont)
            
            let limitHeight = Constsnts.postLabelFont.lineHeight * Constsnts.minifiedPostLimitLines
            
            if !isFullSizedPost && height > limitHeight {
              height = Constsnts.postLabelFont.lineHeight * Constsnts.minifiedPostLines
              showMoreTextButton = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
//        работа с moreTextButtonFrame
        var moreTextButtonSize = CGSize.zero
        
        if showMoreTextButton {
            moreTextButtonSize = Constsnts.moreTextButtonSize
        }
        
        let moreTextButtonOrigin = CGPoint(x: Constsnts.moreTextButtonInsets.left , y: postLabelFrame.maxY)
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
//        работа с attachmentFrame
        
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constsnts.postLabelInsets.top: moreTextButtonFrame .maxY + Constsnts.postLabelInsets.bottom
        
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop),
                                     size: CGSize.zero)
        
//        if let attachment = photoAttachment {
//            let photoHeight: Float = Float(attachment.height)
//            let photoWidth: Float = Float(attachment.width)
//            let ratio = CGFloat(photoHeight / photoWidth)
//            attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
//        }
        
        if let attachment = photoAttachments.first {
            let photoHeight: Float = Float(attachment.height)
            let photoWidth: Float = Float(attachment.width)
            let ratio = CGFloat(photoHeight / photoWidth)
            if photoAttachments.count == 1 {
                attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
            } else if photoAttachments.count > 1 {
                var photos = [CGSize]()
                for photo in photoAttachments {
                    let photoSize = CGSize(width: CGFloat(photo.width), height: CGFloat(photo.height))
                    photos.append(photoSize)
                }
                
                let rowHeight = RowLayout.rowHeightCounter(superviewWidth: cardViewWidth, photosArray: photos)
                attachmentFrame.size = CGSize(width: cardViewWidth, height: rowHeight!)
            }
        }
        
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        let bottomView = CGRect(origin: CGPoint(x: 0, y: bottomViewTop),
                                size: CGSize(width: cardViewWidth, height: Constsnts.bottomViewHeight))
        
        
        let totalHeight = bottomView.maxY + Constsnts.cardInsets.bottom
        
        
        return Sizes(moreTexButtonFrame: moreTextButtonFrame,
                     bottomView: bottomView,
                     totalHeight: totalHeight,
                     postLabelFrame: postLabelFrame,
                     attachmentFrame: attachmentFrame)
    }
}

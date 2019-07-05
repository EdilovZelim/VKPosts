//
//  NewsfeedCell.swift
//  VKPosts
//
//  Created by MacBook on 23/05/2019.
//  Copyright © 2019 Зелимхан Эдилов. All rights reserved.
//

import Foundation
import UIKit

protocol FeedCellViewModel {
    var iconUrl: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var lakes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttachments: [FeedCellPhotoAttachmentViewModel] { get }
    var sizes: FeedCellSizes { get }
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    var bottomView: CGRect { get }
    var totalHeight: CGFloat { get }
    var moreTexButtonFrame: CGRect { get }
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String? { get }
    var width: Int { get }
    var height: Int { get }
}

class NewsfeedCell: UITableViewCell {
    static let reuseId = "NewsfeedCell"
    @IBOutlet weak var iconImageView: WebImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postImageView: WebImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       iconImageView.clipsToBounds = true
//       iconImageView.layer.cornerRadius = Constsnts.topViewHeight / 2
//       cardView.layer.cornerRadius = 10
       cardView.clipsToBounds = true
        
       backgroundColor = .clear
       selectionStyle = .none
    }
    
//    func set(viewModel: FeedCellViewModel) {
//        iconImageView.set(imageURL: viewModel.iconUrl)
//        nameLabel.text = viewModel.name
//        dateLabel.text = viewModel.date
//        postLabel.text = viewModel.text
//        likesLabel.text = viewModel.lakes
//        commentsLabel.text = viewModel.comments
//        sharesLabel.text = viewModel.shares
//        viewsLabel.text = viewModel.views
//        
//        postLabel.frame = viewModel.sizes.postLabelFrame
//        postImageView.frame = viewModel.sizes.attachmentFrame
//        bottomView.frame = viewModel.sizes.bottomView
//        
//        if let photoAttachment = viewModel.photoAttachment {
//            postImageView.set(imageURL: photoAttachment.photoUrlString)
//            postImageView.isHidden = false
//        } else {
//            postImageView.isHidden = true
//        }
//    }
}

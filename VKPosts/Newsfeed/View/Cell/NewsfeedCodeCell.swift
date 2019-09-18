//
//  NewsfeedCodeCell.swift
//  VKPosts
//
//  Created by MacBook on 22/06/2019.
//  Copyright © 2019 Зелимхан Эдилов. All rights reserved.
//

import Foundation
import UIKit

protocol NewsFeedCodeCellDelegate: class {
    func revealPost(for cell: NewsfeedCodeCell)
}

final class NewsfeedCodeCell: UITableViewCell {
    
    static let reuseId = "NewsfeedCodeCell "
    
    weak var delegate: NewsFeedCodeCellDelegate?
    
    override func prepareForReuse() {
        iconImageView.set(imageURL: nil)
        postImageView.set(imageURL: nil)
    }
    
    override init(style: UITableViewCell.CellStyle,reuseIdentifier : String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        overlayFirstLayer() // первый слой
        overlaySecondLayer() // второй слой
        overlayThirdLayerOnTopView() // третий слой на топ вью
        overlayThirdLayerbottomView() // третий слой на bottomView
        overlayFourthLayerbottomView() // четвертый слой на bottomView
        
        moreTextButton.addTarget(self, action: #selector(moreTextButtonTouch), for: .touchUpInside )
        
        backgroundColor = .clear
        selectionStyle = .none
        iconImageView.layer.cornerRadius = Constsnts.topViewHeight / 2
        iconImageView.clipsToBounds = true
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
    }
    
    @objc func moreTextButtonTouch() {
       delegate?.revealPost(for: self)
    }
    
    func set(viewModel: FeedCellViewModel) {
        
        iconImageView.set(imageURL: viewModel.iconUrl)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.lakes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        postLabel.frame = viewModel.sizes.postLabelFrame
        
        bottomView.frame = viewModel.sizes.bottomView
        moreTextButton.frame = viewModel.sizes.moreTexButtonFrame
        
//        if let photoAttachment = viewModel.photoAttachment {
//            postImageView.set(imageURL: photoAttachment.photoUrlString)
//            postImageView.isHidden = false
//        } else {
//            postImageView.isHidden = true
//        }
        
        if let photoAttachment = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
            postImageView.set(imageURL: photoAttachment.photoUrlString)
            postImageView.isHidden = false
            galleryCollectionView.isHidden = true
            postImageView.frame = viewModel.sizes.attachmentFrame
        } else if viewModel.photoAttachments.count > 1 {
            galleryCollectionView.frame = viewModel.sizes.attachmentFrame
            postImageView.isHidden = true
            galleryCollectionView.isHidden = false
            galleryCollectionView.set(photos: viewModel.photoAttachments)
        }
        else {
            postImageView.isHidden = true
            galleryCollectionView.isHidden = true
        }
        
    }
    
//    первый слой
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//   второй слой
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Constsnts.postLabelFont
        label.textColor = #colorLiteral(red: 0.1051704958, green: 0.105195798, blue: 0.1051671281, alpha: 1)
        return label
    }()
    
    let moreTextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полностью...", for: .normal)
        
        return button
    }()
    
    let galleryCollectionView = GalleryCollectionView()
    
    let postImageView: WebImageView = {
        let imageView = WebImageView()
        return imageView
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
//    третий слой на topView
    let iconImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.1051704958, green: 0.105195798, blue: 0.1051671281, alpha: 1)
        return label
    }()
     
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.7165312171, green: 0.7233562469, blue: 0.7430844307, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
//    третий слой на bottomView
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    четвертый слой на bottomView
    
    let likeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "like")
        return imageView
    }()
    
    let commentImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "comment")
        return imageView
    }()
    
    let shareImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "share")
        return imageView
    }()
    
    let viewImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "eye")
        return imageView
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "350k"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.lineBreakMode = .byClipping
        return label
    }()
    
    private func overlayFourthLayerbottomView() {
        likesView.addSubview(likeImage)
        likesView.addSubview(likesLabel)
        
        commentsView.addSubview(commentImage)
        commentsView.addSubview(commentsLabel)
        
        sharesView.addSubview(shareImage)
        sharesView.addSubview(sharesLabel)
        
        viewsView.addSubview(viewImage)
        viewsView.addSubview(viewsLabel)
        
        
        helpInFourthLayer(view: likesView, imageView: likeImage, label: likesLabel)
        helpInFourthLayer(view: commentsView, imageView: commentImage, label: commentsLabel)
        helpInFourthLayer(view: sharesView, imageView: shareImage, label: sharesLabel)
        helpInFourthLayer(view: viewsView, imageView: viewImage, label: viewsLabel)
    }
    
    private func helpInFourthLayer(view: UIView, imageView: UIImageView, label: UILabel) {
//        imageView constraints
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constsnts.bottomViewViewsIconSize).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constsnts.bottomViewViewsIconSize).isActive = true
        
//        label constraints
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 4).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func overlayThirdLayerbottomView() {
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(sharesView)
        bottomView.addSubview(viewsView)
        
//        likesView constraints
        likesView.leftAnchor.constraint(equalTo: bottomView.leftAnchor).isActive = true
        likesView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        likesView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        likesView.heightAnchor.constraint(equalToConstant: Constsnts.bottomViewViewHeight).isActive = true
        likesView.widthAnchor.constraint(equalToConstant: Constsnts.bottomViewViewWidth).isActive = true
        
//        commentsView constraints
        commentsView.leftAnchor.constraint(equalTo: likesView.rightAnchor).isActive = true
        commentsView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        commentsView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        commentsView.heightAnchor.constraint(equalToConstant: Constsnts.bottomViewViewHeight).isActive = true
        commentsView.widthAnchor.constraint(equalToConstant: Constsnts.bottomViewViewWidth).isActive = true
        
//        sharesView constraints
        sharesView.leftAnchor.constraint(equalTo: commentsView.rightAnchor).isActive = true
        sharesView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        sharesView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        sharesView.heightAnchor.constraint(equalToConstant: Constsnts.bottomViewViewHeight).isActive = true
        sharesView.widthAnchor.constraint(equalToConstant: Constsnts.bottomViewViewWidth).isActive = true
        
//        viewsView constraints
        viewsView.rightAnchor.constraint(equalTo: bottomView.rightAnchor).isActive = true
        viewsView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        viewsView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        viewsView.heightAnchor.constraint(equalToConstant: 39).isActive = true
        viewsView.widthAnchor.constraint(equalToConstant: 84).isActive = true
        
    }
    
    private func overlayThirdLayerOnTopView() {
        topView.addSubview(iconImageView)
        topView.addSubview(nameLabel)
        topView.addSubview(dateLabel)
        
//        iconImageView constraints
        iconImageView.leftAnchor.constraint(equalTo: topView.leftAnchor).isActive = true
        iconImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: Constsnts.topViewHeight).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: Constsnts.topViewHeight).isActive = true
        
//        nameLabel constraints
        nameLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 8).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -8).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: Constsnts.topViewHeight / 2 - 2).isActive = true
     
//        dateLabel constraints
        dateLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 8).isActive = true
        dateLabel.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -8).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -2).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    private func overlaySecondLayer() {
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        cardView.addSubview(postImageView)
        cardView.addSubview(galleryCollectionView )
        cardView.addSubview(bottomView)
        cardView.addSubview(moreTextButton)
        
//        topView constraints
        topView.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 8).isActive = true
        topView.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -8).isActive = true
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constsnts.topViewHeight).isActive = true
        
//        postLabel constraints
//        не нужно, так как размеры задаются динамически
        
//        postImageView constraints
//        не нужно, так как размеры задаются динамически
        
//        bottomView constraints
//        не нужно, так как размеры задаются динамически
        
//        moreTexButton constraints
//        не нужно, так как размеры задаются динамически
        
    }
    
    private func overlayFirstLayer() {
        addSubview(cardView)
        
        cardView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        cardView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        cardView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  GalleryCollectionViewCell.swift
//  VKPosts
//
//  Created by MacBook on 01/07/2019.
//  Copyright © 2019 Зелимхан Эдилов. All rights reserved.
//

import Foundation
import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "GalleryCollectionViewCell"
    
    let myImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(myImageView)
        
//        myImageView constraints
        myImageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        myImageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        myImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        myImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        myImageView.image = nil
    }
    
    func set(imageUrl: String?) {
        myImageView.set(imageURL: imageUrl)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myImageView.layer.masksToBounds = true
        myImageView.layer.cornerRadius = 10
        self.layer.shadowRadius = 3
        layer.shadowOpacity = 0.4
        layer.shadowOffset = CGSize(width: 2.5, height: 4)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

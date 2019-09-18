//
//  TitleView.swift
//  VKPosts
//
//  Created by MacBook on 21/07/2019.
//  Copyright © 2019 Зелимхан Эдилов. All rights reserved.
//

import Foundation
import UIKit


class TitleView: UIView {
    
    
    private var myTextField = InsetableTextField()

    private var myAvatarView: WebImageView = {
        
        let imageView = WebImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .orange
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
//        makeConsrtaints()
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(myTextField)
        addSubview(myAvatarView)
    }
    
    private func makeConsrtaints() {
        myAvatarView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        myAvatarView.rightAnchor.constraint(equalTo: rightAnchor, constant: -4).isActive = true
//        myAvatarView.leftAnchor.constraint(equalTo: myTextField.leftAnchor).isActive = true
//        myAvatarView.bottomAnchor.constraint(equalTo: myTextField.bottomAnchor).isActive = true
        myAvatarView.heightAnchor.constraint(equalTo: myTextField.heightAnchor, multiplier: 1).isActive = true
        myAvatarView.widthAnchor.constraint(equalTo: myTextField.heightAnchor, multiplier: 1).isActive = true


        myTextField.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        myTextField.rightAnchor.constraint(equalTo: myAvatarView.leftAnchor, constant: -12).isActive = true
        myTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 4).isActive = true
        myTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true

    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myAvatarView.layer.masksToBounds = true
        myAvatarView.layer.cornerRadius = myAvatarView.frame.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implementedd")
    }
}

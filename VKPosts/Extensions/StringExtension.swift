//
//  String  + Height.swift
//  VKPosts
//
//  Created by MacBook on 08/06/2019.
//  Copyright © 2019 Зелимхан Эдилов. All rights reserved.
//

import Foundation
import UIKit

// Расширение для подсчета высоты в зависимости от текста

extension String {
    func height(width: CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes:[NSAttributedString.Key.font : font],
                                     context:nil)
        return ceil(size.height)
    }
}

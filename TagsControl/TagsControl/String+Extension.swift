//
//  String+CIExtension.swift
//  CommerceInteraction
//
//  Created by liujianlin on 16/5/12.
//  Copyright © 2016年 ocm. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    /**
     字符串限定宽度时的高度
     */
    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height+10.0
    }
    
    /**
     字符串限定高度时的宽度
     */
    func widthWithConstrainedHeight(_ height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.width+10.0
    }
}

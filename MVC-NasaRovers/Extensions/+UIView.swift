//
//  +UIView.swift
//  MVC-NasaRovers
//
//  Created by Hasan Dag on 24.03.2022.
//

import UIKit

extension UIView {
    
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static var leftPadding : CGFloat {
        let window = UIApplication.shared.windows.first
        return window?.safeAreaInsets.left ?? 8
    }
    
    static var rightPadding : CGFloat   {
        let window = UIApplication.shared.windows.first
        return window?.safeAreaInsets.left ?? 8
    }
}

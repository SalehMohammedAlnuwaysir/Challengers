//
//  button1.swift
//  Challengers
//
//  Created by YAZEED NASSER on 08/10/2018.
//  Copyright © 2018 YAZEED NASSER. All rights reserved.
//

import UIKit

class button1: UIButton {
    override func draw(_ rect: CGRect) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Color Declarations
        let color2 = UIColor(red: 0.121, green: 0.837, blue: 0.870, alpha: 1.000)
        
        //// Shadow Declarations
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.darkGray.withAlphaComponent(0.4)
        shadow.shadowOffset = CGSize(width: 0, height: 6)
        shadow.shadowBlurRadius = 5
        
        //// crateBtn Drawing
        context.saveGState()
        context.setAlpha(0.9)
        context.setBlendMode(.darken)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        let crateBtnRect = CGRect(x: 32.75, y: 33.5, width: 180.5, height: 45.25)
        let crateBtnPath = UIBezierPath(roundedRect: crateBtnRect, cornerRadius: 22.62)
        context.saveGState()
        context.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as! UIColor).cgColor)
        color2.setFill()
        crateBtnPath.fill()
        context.restoreGState()
        
        let crateBtnTextContent = "Create"
        let crateBtnStyle = NSMutableParagraphStyle()
        crateBtnStyle.alignment = .center
        let crateBtnFontAttributes = [
            .font: UIFont(name: "HelveticaNeue", size: 24)!,
            .foregroundColor: UIColor.white,
            .paragraphStyle: crateBtnStyle,
            ] as [NSAttributedStringKey: Any]
        
        let crateBtnTextHeight: CGFloat = crateBtnTextContent.boundingRect(with: CGSize(width: crateBtnRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: crateBtnFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: crateBtnRect)
        crateBtnTextContent.draw(in: CGRect(x: crateBtnRect.minX, y: crateBtnRect.minY + (crateBtnRect.height - crateBtnTextHeight) / 2, width: crateBtnRect.width, height: crateBtnTextHeight), withAttributes: crateBtnFontAttributes)
        context.restoreGState()
        
        context.endTransparencyLayer()
        context.restoreGState()
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

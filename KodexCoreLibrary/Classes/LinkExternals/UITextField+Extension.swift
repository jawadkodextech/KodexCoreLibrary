//
//  UITextField+Extension.swift
//  LFW
//
//  Created by J Aiden on 25/05/2018.
//  Copyright © 2018 
//

import Foundation
import UIKit


extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

extension UIButton{
    
    func setBackgroundView(view: UIView) {
        view.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        view.isUserInteractionEnabled = false
        self.addSubview(view)
    }
}

protocol LinkedLabelDelegate:class {
    func openWebViewAc(link:String)
}

class LinkedLabel: UILabel {
    
    fileprivate let layoutManager = NSLayoutManager()
    fileprivate let textContainer = NSTextContainer(size: CGSize.zero)
    fileprivate var textStorage: NSTextStorage?
    var delegateLink:LinkedLabelDelegate?
    
    override init(frame aRect:CGRect){
        super.init(frame: aRect)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    func initialize(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LinkedLabel.handleTapOnLabel))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }
    
    override var attributedText: NSAttributedString?{
        didSet{
            if let _attributedText = attributedText{
                self.textStorage = NSTextStorage(attributedString: _attributedText)
                
                self.layoutManager.addTextContainer(self.textContainer)
                self.textStorage?.addLayoutManager(self.layoutManager)
                
                self.textContainer.lineFragmentPadding = 0.0;
                self.textContainer.lineBreakMode = self.lineBreakMode;
                self.textContainer.maximumNumberOfLines = self.numberOfLines;
            }
            
        }
    }
    
    @objc func handleTapOnLabel(tapGesture:UITapGestureRecognizer){
        
        let locationOfTouchInLabel = tapGesture.location(in: tapGesture.view)
        let labelSize = tapGesture.view?.bounds.size
        let textBoundingBox = self.layoutManager.usedRect(for: self.textContainer)
        let textContainerOffset = CGPoint(x: ((labelSize?.width)! - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: ((labelSize?.height)! - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = self.layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: self.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        
        self.attributedText?.enumerateAttribute(NSAttributedString.Key.link, in: NSMakeRange(0, (self.attributedText?.length)!), options: NSAttributedString.EnumerationOptions(rawValue: UInt(0)), using:{
            (attrs: Any?, range: NSRange, stop: UnsafeMutablePointer<ObjCBool>) in
            
            if NSLocationInRange(indexOfCharacter, range){
                if let _attrs = attrs{
                    self.delegateLink?.openWebViewAc(link: _attrs as! String)
                    //                    UIApplication.shared.openURL(URL(string: _attrs as! String)!)
                }
            }
        })
        
    }
    
}




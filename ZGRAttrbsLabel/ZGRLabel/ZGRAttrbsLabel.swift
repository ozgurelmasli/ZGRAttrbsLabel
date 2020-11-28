//
//  ZGRAttrbsLabel.swift
//  ZGRAttrbsLabel
//
//  Created by Mac on 29.11.2020.
//

import Foundation
import UIKit


class ZGRAttrbsLabel : UILabel {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.numberOfLines = 0
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// Max Length of collapse
    open var maxLength : Int = 50 {
        didSet {
            self.configureCollapseText()
        }
    }
    /// Full Text
    open var fullText : String = "" {
        didSet {
            self.configureCollapseText()
        }
    }
    /// Show more text String
    open var showMore : String = "... (daha fazla)" {
        didSet {
            self.showText()
        }
    }
    /// Show less text String
    open var showLess : String = "(daha az)" {
        didSet {
            self.showText()
        }
    }
    ///  show more Attrbs
    open var showMoreAttributes : [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.systemBlue, .font: UIFont.systemFont(ofSize: 17)] {
        didSet {
            self.showText()
        }
    }
    
    ///  text Attrbs
    open var textAttributes : [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.red, .font: UIFont.systemFont(ofSize:  15)] {
        didSet {
            self.showText()
        }
    }
    
    /// Animate fade-in fade-out
    open var isAnimate : Bool = false
    
    private var collapseText : String = ""
    private var isCollapse : Bool = false {
        didSet {
            self.showText()
        }
    }
}
//MARK:-> Private Funcs
extension ZGRAttrbsLabel {
    fileprivate func configureCollapseText(){
        if fullText.count > self.maxLength {
            self.collapseText = String(self.fullText.prefix(self.maxLength))
            self.isCollapse = true
        }else {
            self.isCollapse = false
        }
    }
    fileprivate func showText(){
        let collapseAttrbs = NSMutableAttributedString(string: self.collapseText, attributes: self.textAttributes)
        let showMoreAttrbs = NSMutableAttributedString(string: self.showMore, attributes: self.showMoreAttributes)
        showMoreAttrbs.addAttribute(.link, value: "showMoreTrigger"
                                    , range: NSRange(location: 0, length: self.showMore.count))
        collapseAttrbs.append(showMoreAttrbs)
        
        
        let fullTextAttrbs = NSMutableAttributedString(string: self.fullText, attributes: self.textAttributes)
        let showLess = NSMutableAttributedString(string: self.showLess, attributes: self.showMoreAttributes)
        showLess.addAttribute(.link, value: "showLessTrigger"
                                    , range: NSRange(location: 0, length: self.showLess.count))
        
        fullTextAttrbs.append(showLess)
        let isBigger = fullText.count > self.maxLength
        self.attributedText = self.isCollapse == true ? collapseAttrbs : isBigger == false ? NSMutableAttributedString(string: self.fullText, attributes:textAttributes): fullTextAttrbs
        
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showToggleTapped(gesture:))))
    }
}


//MARK:-> Toggle
extension ZGRAttrbsLabel {
      @objc func showToggleTapped(gesture: UITapGestureRecognizer){
          //OR
          // you can directly use
          // self.isCollapse = !self.isCollapse
          
          let showMoreIsTapped = (self.text! as NSString).range(of: self.showMore)
          let showLessIsTapped = (self.text! as NSString).range(of: self.showLess)
          if gesture.didTapAttributedTextInLabel(label: self, inRange: showMoreIsTapped) {
            if self.isAnimate == true {
                UIView.animate(withDuration: 0.2) {
                    self.alpha = 0.0
                } completion: { (_) in
                    self.isCollapse = false
                    UIView.animate(withDuration: 0.2) {
                        self.alpha = 1.0
                    }
                }
            }else {
                self.isCollapse = false
            }
          }  else if gesture.didTapAttributedTextInLabel(label: self, inRange: showLessIsTapped) {
                if self.isAnimate == true {
                    UIView.animate(withDuration: 0.2) {
                        self.alpha = 0.0
                    } completion: { (_) in
                        self.isCollapse = true
                        UIView.animate(withDuration: 0.2) {
                            self.alpha = 1.0
                        }
                    }
                }else {
                    self.isCollapse = true
                }
          }
      }
}

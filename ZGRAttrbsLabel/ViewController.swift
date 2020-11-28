//
//  ViewController.swift
//  ZGRAttrbsLabel
//
//  Created by Mac on 29.11.2020.
//

import UIKit

class ViewController: UIViewController {

    private var ZGRLabel : ZGRAttrbsLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.setLabel()
    }
}
//MARK:-> SET LABEL
extension ViewController {
    
    fileprivate func setLabel(){
        
        self.ZGRLabel = ZGRAttrbsLabel()
        
        self.ZGRLabel.textAlignment = .center
        self.ZGRLabel.isAnimate = true
        self.ZGRLabel.fullText = "Hi! It's Ozgur. I graduated as Computer Engineer from Erciyes University.. I have been working as iOS Developer in Nektar Software and Design. You can reach me and read my posts ->  www.benozgurelmasli.com. Thank you !"
        self.ZGRLabel.textAttributes = [.foregroundColor: UIColor.black, .font: UIFont.systemFont(ofSize:  15)]
        self.ZGRLabel.showMoreAttributes = [.foregroundColor: UIColor.systemBlue, .font: UIFont.systemFont(ofSize:  17)]
    
        
        self.ZGRLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.ZGRLabel)
        self.ZGRLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.ZGRLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.ZGRLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor
                                             , multiplier: 0.8).isActive = true
    }
}

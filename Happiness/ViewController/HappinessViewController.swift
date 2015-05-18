//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Michael Vilabrera on 5/16/15.
//  Copyright (c) 2015 Giving Tree. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController
{
    var face: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        face.backgroundColor = UIColor.blueColor()
//        self.view.addSubview(face)
        makeLayout()
    }
    
    func makeLayout() {
        face = UIView()
        face.setTranslatesAutoresizingMaskIntoConstraints(false)
//        face.backgroundColor = UIColor(red: 0.3, green: 0.4, blue: 0.1, alpha: 1)
        face.backgroundColor = UIColor.blueColor()
        view.addSubview(face)
        
        //-------------------- constraints
        
        // make dictionary for views
        let viewsDictionary = ["face":face]
        
        // constraint strings
        let face_H: String! = "H:[face(300)]"
        let face_V: String! = "V:[face(500)]"
        // sizing constraints
        let face_constraint_H: Array = NSLayoutConstraint.constraintsWithVisualFormat(face_H, options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let face_constraint_V: Array = NSLayoutConstraint.constraintsWithVisualFormat(face_V, options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        face.addConstraints(face_constraint_H)
        face.addConstraints(face_constraint_V)
    }
}

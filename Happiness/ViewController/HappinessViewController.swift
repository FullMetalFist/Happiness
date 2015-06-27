//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Michael Vilabrera on 5/16/15.
//  Copyright (c) 2015 Giving Tree. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource
{
    var face: FaceView! {
        didSet {
            face.dataSource = self
            face.addGestureRecognizer(UIPinchGestureRecognizer(target: face, action: "scale:"))
            face.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "changeHappiness:"))
            
        }
    }
    var slider: UISlider!
    
    var happiness: Int = 15 {
        // 0 = sad, 100 = ecstatic
        didSet {
            happiness = min(max(happiness, 0), 100)
            println("happiness = \(happiness)")
            updateUI()
        }
    }
    
    private struct Constants {
        static let HappinessGestureScale: CGFloat = 4
        
    }
    
    func changeHappiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(face)
            
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: face)
            }
        default: break
        }
    }
    
    func slideHappiness(slider: UISlider) {
        
        let translation = Double(slider.value)
        let happinessChange = -Double(translation / Double(Constants.HappinessGestureScale))
        if happinessChange != 0 {
            happiness += Int(happinessChange)
        }
    }
    
    func sliderValueChanged(sender: UISlider) {
        // changes the value of the slider
        var currentValue = CGFloat(sender.value)
        
        happiness = Int(currentValue * 150)
        
        println("scale: \(currentValue)")
    }
    
    
    
    func updateUI()
    {
        face.setNeedsDisplay()
    }
    
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 15) / 50
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        face.backgroundColor = UIColor.blueColor()
//        self.view.addSubview(face)
        makeLayout()
    }
    
    func makeLayout() {
        face = FaceView()
        face.setTranslatesAutoresizingMaskIntoConstraints(false)
        face.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 1.0, alpha: 1)
        view.addSubview(face)
        
        slider = UISlider()
        slider.setTranslatesAutoresizingMaskIntoConstraints(false)
        slider.addTarget(self, action: "sliderValueChanged:", forControlEvents: .ValueChanged)
        view.addSubview(slider)
        
        //-------------------- constraints
        
        // make dictionary for views
        let viewsDictionary = ["face":face, "slider":slider]
        
        // constraint strings
        let face_H: String! = "H:[face]"
        let face_V: String! = "V:[face]"
        
        let slider_H: String! = "H:[slider]"
        let slider_V: String! = "V:[slider]"
        
        // sizing constraints
        let face_constraint_H: Array = NSLayoutConstraint.constraintsWithVisualFormat(face_H, options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let face_constraint_V: Array = NSLayoutConstraint.constraintsWithVisualFormat(face_V, options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        let slider_constraint_H: Array = NSLayoutConstraint.constraintsWithVisualFormat(slider_H, options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        let slider_constraint_V: Array = NSLayoutConstraint.constraintsWithVisualFormat(slider_V, options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary)
        
        face.addConstraints(face_constraint_H)
        face.addConstraints(face_constraint_V)
        
        let spinNumber: CGFloat = CGFloat(M_PI) * 1.5
        let transform: CGAffineTransform = CGAffineTransformMakeRotation(spinNumber)
        
        slider.transform = transform
        
        slider.addConstraints(slider_constraint_H)
        slider.addConstraints(slider_constraint_V)
        
        
        // necessary to add constraints to superview
        // use the pipe here
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[face][slider(50)]|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        //view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[slider]", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[slider]|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[face]|", options: NSLayoutFormatOptions(0), metrics: nil, views: viewsDictionary))
    }
}

//
//  BePresentViewController.swift
//  Okay
//
//  Created by William Gu on 4/30/16.
//  Copyright © 2016 Gu Studios. All rights reserved.
//

import UIKit

class BePresentViewController: UIViewController {

    
    @IBOutlet weak var countdownLabel: UILabel!
    
    private var exerciseNumber: Int = 1;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        countdownLabel.text = "";
        exerciseNumber = 1;
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleLongPress(sender: UITapGestureRecognizer? = nil) {
        //TODO: Animate that circle
        
    }
    
    var circle: CAShapeLayer?
    var drawAnimation: CABasicAnimation?

    func configCircle() {
        let radius: CGFloat = 50.0;
        self.circle = CAShapeLayer();
        self.circle?.path = UIBezierPath(roundedRect: CGRectMake(0, 0, 2.0*radius, 2.0*radius), cornerRadius: radius).CGPath;

        self.circle?.position = CGPointMake(self.countdownLabel.center.x, self.countdownLabel.center.y)
        self.circle?.fillColor = UIColor.clearColor().CGColor;
        self.circle?.strokeColor = UIColor.grayColor().CGColor;
        self.circle?.lineWidth = 1.5;
        
        self.circle?.strokeEnd = 0.0;
        
        self.view.layer.addSublayer(self.circle!);
        
        
        
    }
    
    func startCircleAnimation() {
        if (self.drawAnimation != nil) {
            self.resumeLayer(self.circle!);
        } else {
            self.circleAnimation();
        }
    }
    
    func endCircleAnimation() {
        self.pauseLayer(self.circle!);
    }
    
    
    func pauseLayer(layer: CALayer){
        let pausedTime = layer.convertTime(CACurrentMediaTime(), fromLayer: nil);
        layer.speed = 0.0;
        layer.timeOffset = pausedTime;
    }

    func resumeLayer(layer: CALayer){
        let pausedTime = layer.timeOffset;
        layer.speed = 1.0;
        layer.timeOffset = 0.0;
        layer.beginTime = 0.0;
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime;
        layer.beginTime = timeSincePause;
    }
    
    func circleAnimation() {
        // Configure animation
        self.drawAnimation = CABasicAnimation(keyPath: "strokeEnd");

        self.drawAnimation!.duration            = 10.0;
        self.drawAnimation!.repeatCount         = 1.0; // Animate only once..
    
    
        // Animate from no part of the stroke being drawn to the entire stroke being drawn
        self.drawAnimation!.fromValue = NSNumber(float:0.0);
    
        // Set your to value to one to complete animation
        self.drawAnimation!.toValue   = NSNumber(float:1.0);
        
        // Experiment with timing to get the appearence to look the way you want
        self.drawAnimation!.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn);
        // Add the animation to the circle
        self.circle?.addAnimation(self.drawAnimation!, forKey: "draw");
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

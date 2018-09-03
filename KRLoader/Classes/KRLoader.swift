//
//  KRLoader.swift
//  CustomeLoader
//
//  Created by kamalraj venkatesan on 03/09/18.
//  Copyright © 2018 Kamalraj. All rights reserved.
//

import UIKit

class KRLoader: UIView {


  /** Radius of loader */
  @IBInspectable var radius: CGFloat = 0.0

  /** Loader color */
  @IBInspectable var loaderColor: UIColor = UIColor.blue

  /** Tracker color */
  @IBInspectable var trackerColor: UIColor = UIColor.clear

  /** duration to complete each cycle */
  @IBInspectable var duration: Double = 1.0

  /** Loader Width */
  @IBInspectable var loaderWidth: CGFloat = 5

  /** Hiding the loader when animation stops */
  @IBInspectable var hideWhenStopped: Bool = false

  private var centerPoint: CGPoint = CGPoint(x: 0, y: 0)
  private let shapeLayer = CAShapeLayer()


  override public func draw(_ rect: CGRect) {
    super.draw(rect)

    self.centerPoint = CGPoint(x: rect.midX, y: rect.midY)
    createLoader()
  }

  public func startAnimation() {

    UIView.animate(withDuration: 0.2, animations: {
      self.alpha = 1.0
      self.transform = CGAffineTransform.identity
    }, completion: { _ in

      let rotationAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
      rotationAnimation.toValue = NSNumber(value: Double.pi * 2.0)
      rotationAnimation.duration = self.duration
      rotationAnimation.isCumulative = true
      rotationAnimation.repeatCount = HUGE

      self.layer.add(rotationAnimation, forKey: "rotationAnimation")

    })

  }

  public func stopAnimation() {

    UIView.animate(withDuration: 0.2, animations: {
      self.layer.removeAnimation(forKey: "rotationAnimation")

      self.alpha = 0
      self.transform = CGAffineTransform(scaleX: 0, y: 0)
    })

  }


  private func createLoader() {

    let radius = (self.radius > 0.0) ? self.radius : min(self.bounds.width, self.bounds.height) / 2

    let circularPath = UIBezierPath(arcCenter: self.centerPoint, radius: radius, startAngle: 0, endAngle: -(CGFloat.pi / 2), clockwise: true)

    shapeLayer.path = circularPath.cgPath
    shapeLayer.fillColor = trackerColor.cgColor
    shapeLayer.strokeColor = loaderColor.cgColor
    shapeLayer.lineWidth = loaderWidth

    self.layer.addSublayer(shapeLayer)

    self.transform = CGAffineTransform(scaleX: 0, y: 0)
    self.alpha = 0

  }

}

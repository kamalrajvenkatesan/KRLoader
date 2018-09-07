//
//  KRLoader.swift
//  CustomeLoader
//
//  Created by kamalraj venkatesan on 03/09/18.
//  Copyright © 2018 Kamalraj. All rights reserved.
//

import UIKit

public class KRLoader: UIView {


  /** Radius of loader */
  @IBInspectable var radius: CGFloat = 0.0

  /** Loader color */
  @IBInspectable var loaderColor: UIColor = UIColor.blue

  /** Tracker color */
//  @IBInspectable var trackerColor: UIColor = UIColor.clear

  /** duration to complete each cycle */
  @IBInspectable var duration: Double = 1.0

  /** Loader Width */
  @IBInspectable var loaderWidth: CGFloat = 5

  /** Hiding the loader when animation stops */
//  @IBInspectable var hideWhenStopped: Bool = false

  private let shapeLayer = CAShapeLayer()
  public var isAnimating = false

  private var isDrawnNow = true


  override public func draw(_ rect: CGRect) {
    super.draw(rect)

    createLoader()

    self.isDrawnNow = true
  }

  public override func willMove(toWindow newWindow: UIWindow?) {
    super.willMove(toWindow: newWindow)

    guard !isDrawnNow else {
      self.isDrawnNow = false
      return
    }
    resumeAnimation()
  }

  /** Will resume if isAnimation is true*/
  public func resumeAnimation() {
    guard isAnimating else {
      return
    }

    self.startAnimation()
  }

  /** Starting loading animation */
  public func startAnimation() {

    isAnimating = true

    UIView.animate(withDuration: 0.2, animations: {
      self.alpha = 1.0
      self.transform = CGAffineTransform.identity
    }, completion: { _ in

      let rotationAnimation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
      rotationAnimation.toValue = NSNumber(value: Double.pi * 2.0)
      rotationAnimation.duration = self.duration
      rotationAnimation.isCumulative = true
      rotationAnimation.repeatCount = HUGE

      self.shapeLayer.add(rotationAnimation, forKey: "rotationAnimation")

    })
  }

  /** Stop loading animation */
  public func stopAnimation() {

    isAnimating = false

    UIView.animate(withDuration: 0.2, animations: {
      self.layer.removeAnimation(forKey: "rotationAnimation")

      self.alpha = 0
      self.transform = CGAffineTransform(scaleX: 0, y: 0)
    })

  }


  private func createLoader() {

    shapeLayer.bounds = bounds
    shapeLayer.position = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
    shapeLayer.path = UIBezierPath(ovalIn: bounds).cgPath

    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = loaderColor.cgColor
    shapeLayer.lineWidth = loaderWidth
    shapeLayer.strokeStart = 0.25
    shapeLayer.strokeEnd = 1

    self.layer.addSublayer(shapeLayer)

    guard !isAnimating else {
      // Animating
      return
    }

    self.transform = CGAffineTransform(scaleX: 0, y: 0)
    self.alpha = 0

  }

}

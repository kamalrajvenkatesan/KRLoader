//
//  ViewController.swift
//  KRLoader
//
//  Created by kamalraj.venkatesan on 09/03/2018.
//  Copyright (c) 2018 kamalraj.venkatesan. All rights reserved.
//

import UIKit
import KRLoader

class ViewController: UIViewController {

  @IBOutlet weak var loader: KRLoader!
  
  override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
  @IBAction func startAnimating(_ sender: UIButton) {

    loader.startAnimation()

  }
  @IBAction func stopAnimating(_ sender: UIButton) {

    loader.stopAnimation()
  }
  
}


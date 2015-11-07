//
//  ViewController.swift
//  What's That Whistle
//
//  Created by Yohannes Wijaya on 11/5/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Methods Override

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "What's that Whistle?"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addWhistle")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: .Plain, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Local Methods
    
    func addWhistle() {
        let vc = RecordWhistleViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


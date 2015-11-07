//
//  RecordWhistleViewController.swift
//  What's That Whistle
//
//  Created by Yohannes Wijaya on 11/7/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit

class RecordWhistleViewController: UIViewController {
    
    // MARK: - Stored Properties
    
    var stackView: UIStackView!
    
    // MARK: - Methods Override

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = UIColor.grayColor()
        
        
        
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

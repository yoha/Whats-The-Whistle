//
//  AddCommentsViewController.swift
//  What's That Whistle
//
//  Created by Yohannes Wijaya on 11/16/15.
//  Copyright © 2015 Yohannes Wijaya. All rights reserved.
//

import UIKit

class AddCommentsViewController: UIViewController, UITextViewDelegate {
    
    // MARK: - Stored Properties
    
    var genre: String!
    var comments: UITextView!
    let placeHolder = "If you have any addition comment that might help identify your tune, enter them here."

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Comments"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: .Plain, target: self, action: "submitTapped")
        self.comments.text = self.placeHolder
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        super.loadView()
        
        self.comments = UITextView()
        self.comments.translatesAutoresizingMaskIntoConstraints = false
        self.comments.delegate = self
        self.comments.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.view.addSubview(self.comments)
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[comments]|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["comments": comments]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[comments]|", options: .AlignAllCenterX, metrics: nil, views: ["comments": comments]))
    }
    
    // MARK: - Delegate Methods
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.text == self.placeHolder { textView.text = "" }
    }
    
    // MARK: - Local Methods
    
    func submitTapped() {
        let submitViewController = SubmitViewController()
        submitViewController.genre = self.genre
        submitViewController.comments = self.comments.text == self.placeHolder ? "" : self.comments.text
        
        self.navigationController?.pushViewController(submitViewController, animated: true)
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

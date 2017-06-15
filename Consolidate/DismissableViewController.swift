//
//  DismissableViewController.swift
//  Consolidate
//
//  Created by Conrad Koh on 10/4/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import UIKit
import SafariServices
class DismissableViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var UIButton_Cancel: UIButton!
    var subView:UIView?;
    override func viewDidLoad() {
        super.viewDidLoad()
        if let sv = subView{
            let views = ["subView" : subView!]
            self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|", options: .alignAllLeft, metrics: nil, views: views))
            self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|", options: .alignAllLeft, metrics: nil, views: views))
            containerView.addSubview(sv);
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func UIButton_Cancel_Touch_Up_Inside(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil);
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

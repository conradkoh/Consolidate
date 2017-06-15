//
//  SummaryViewController.swift
//  Consolidate
//
//  Created by Conrad Koh on 29/3/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    @IBOutlet weak var UIButton_Cancel: UIButton!
    @IBOutlet weak var UITextView_Title: UITextView!
    @IBOutlet weak var UITextView_Content: UITextView!
    
    override internal var title:String?{
        get{
            return _title;
        }
        set{
            _title = newValue;
            if(UITextView_Title != nil){
                UITextView_Title.text = _title;
            }
        }
    }
    
    internal var content:String?{
        get{
            return _content;
        }
        set{
            _content = newValue;
            if(UITextView_Content != nil){
                UITextView_Content.text = _content;
            }
        }
    }
    
    fileprivate var _title:String?;
    fileprivate var _content:String?;
    override func viewDidLoad() {
        super.viewDidLoad()
        UITextView_Title.text = _title;
        UITextView_Content.text = _content;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func UIButton_Cancel_Touch_Up_Inside(_ sender: AnyObject) {
        let model = Model.singleton;
        model.activeView = nil;
        model.activeTableViewItem = nil;
        self.dismiss(animated: true, completion: {});
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent;
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

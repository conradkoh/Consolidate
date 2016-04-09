//
//  FirstViewController.swift
//  Consolidate
//
//  Created by Conrad Koh on 18/2/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import UIKit
import SafariServices

//HACK:
extension SFSafariViewController{
    override public func prefersStatusBarHidden() -> Bool {
        return true;
    }
}
class FirstViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {

    //==============================================
    //Outlets
    //==============================================
    
    //Constraints
    @IBOutlet weak var NSLayoutConstraint_InputView_Bottom: NSLayoutConstraint!
    @IBOutlet weak var NSLauoutConstraint_InputView_Height: NSLayoutConstraint!
    
    //UI elements
    @IBOutlet weak var UIView_InputView: UIView!
    @IBOutlet weak var UITextField_Input: UITextField!
    @IBOutlet weak var UITableView_Results: UITableView!
    
    //==============================================
    //System variables
    //==============================================
    let notificationCenter = NSNotificationCenter.defaultCenter();
    
    //==============================================
    //Variables
    //==============================================
    let _model = Model.singleton;
    
    //==============================================
    //Framework
    //==============================================
    override func viewDidLoad() {
        super.viewDidLoad()
        Initialize();
        _model.Command(Definitions.Commands.HOME);
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.endEditing(true);
        textField.text = "";
        _model.Command(Definitions.Commands.HOME);
        return true;
    }
    override func viewWillAppear(animated: Bool) {
        UITextField_Input.becomeFirstResponder();
    }
    
    //==============================================
    //Notification Observers
    //==============================================
    var count = 1;
    func keyboardWillShow(notification:NSNotification){
        let keyboardFrame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue();
        let kbheight = keyboardFrame!.height;
        let tabbarheight = self.tabBarController?.tabBar.frame.size.height;
        self.modifyConstaint(NSLayoutConstraint_InputView_Bottom, toValue: kbheight - tabbarheight!);
    }
    
    func keyboardWillHide(notification:NSNotification){
        self.modifyConstaint(NSLayoutConstraint_InputView_Bottom, toValue: 0);
    }
    
    func modifyConstaint(constraint:NSLayoutConstraint, toValue value:CGFloat){
        //constraint.constant = value;
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(0.1, animations: {
            constraint.constant = value
            self.view.layoutIfNeeded()
        })
    }
    
    func applicationBecameActive(notification:NSNotification){
        UITextField_Input.becomeFirstResponder();
    }
    //==============================================
    //Targets
    //==============================================
    
    func textFieldDidChange(textField:UITextField){
        _model.Query(textField.text!);
    }
    
    //==============================================
    //Initialization
    //==============================================
    func Initialize(){
        InitializeObservers();
        InitializeTargets();
        InitializeDelegates();
        InitializeModel();
        InitializeUI();
    }
    
    func InitializeObservers(){
        notificationCenter.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil);
        notificationCenter.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil);
        notificationCenter.addObserver(self, selector: #selector(self.applicationBecameActive(_:)), name: UIApplicationDidBecomeActiveNotification, object: nil);
    }
    
    func InitializeTargets(){
        UITextField_Input.addTarget(self, action: #selector(FirstViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged);
    }
    
    func InitializeDelegates(){
        UITextField_Input.delegate = self;
    }
    
    func InitializeModel(){
        UITableView_Results.dataSource = _model;
        UITableView_Results.delegate = self;
        _model.tableView = UITableView_Results;
    }
    
    func InitializeUI(){
        UITextField_Input.clearsOnBeginEditing = true;
    }
    
    //==============================================
    //Selectors
    //==============================================
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true);
        let isQuery = _model.isQueryAtIndex(indexPath.row);
        let isCommand = _model.isCommandAtIndex(indexPath.row);
        if(isQuery){
            _model.performQueryAtIndex(indexPath.row);
        }
        else if(isCommand){
            let shouldPresent = _model.shouldPresentAtIndex(indexPath.row);
            if(shouldPresent){
                let url_string = _model.pathForPresentationAtIndex(indexPath.row);
                let checked_url = URLParser.Normalize(url_string);
                let url = NSURL(string: checked_url);
                let vc = SFSafariViewController(URL: url!);
                vc.modalPresentationStyle = .OverFullScreen;
                vc.modalPresentationCapturesStatusBarAppearance = true;
                
                self.presentViewController(vc, animated: true, completion: nil)
            }
            else{
                _model.performCommandAtIndex(indexPath.row);
            }
            
        }
        else{
            let vc = SummaryViewController();
            let summary = _model.summaryAtIndex(indexPath.row);
            if(summary != nil){
                //vc.title = summary![ActionableKeys.TITLE];
                //vc.content = summary![ActionableKeys.SUMMARY];
                vc.title = summary?.title;
                vc.content = summary?.summary;
                _model.activeViewIndex = indexPath.row;
                _model.activeView = vc;
                self.presentViewController(vc, animated: true, completion: {
                });
            }
        }
        
        
    }
//    //==============================================
//    //API Delegate
//    //==============================================
//    func QueryResponse(data: NSData) {
//        //UITextField_Input.text = data;
//        let busstop = BusStop(data: data);
//    }
}


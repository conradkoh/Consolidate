//
//  FirstViewController.swift
//  Consolidate
//
//  Created by Conrad Koh on 18/2/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import UIKit
import SafariServices
import WebKit
import AVKit
import AVFoundation
//HACK:
extension SFSafariViewController{
    override open var prefersStatusBarHidden : Bool {
        return true;
    }
}
class FirstViewController: UIViewController {
    
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
    let notificationCenter = NotificationCenter.default;
    
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UITextField_Input.becomeFirstResponder();
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent;
    }
    //==============================================
    //Notification Observers
    //==============================================
    var count = 1;
    func keyboardWillShow(_ notification:Notification){
        let keyboardFrame = ((notification as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue;
        let kbheight = keyboardFrame!.height;
        let tabbarheight = self.tabBarController?.tabBar.frame.size.height;
        self.modifyConstaint(NSLayoutConstraint_InputView_Bottom, toValue: kbheight - tabbarheight!);
    }
    
    func keyboardWillHide(_ notification:Notification){
        self.modifyConstaint(NSLayoutConstraint_InputView_Bottom, toValue: 0);
    }
    
    func modifyConstaint(_ constraint:NSLayoutConstraint, toValue value:CGFloat){
        //constraint.constant = value;
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.1, animations: {
            constraint.constant = value
            self.view.layoutIfNeeded()
        })
    }
    
    func applicationBecameActive(_ notification:Notification){
        UITextField_Input.becomeFirstResponder();
    }
    //==============================================
    //Targets
    //==============================================
    
    func textFieldDidChange(_ textField:UITextField){
        if(textField.text == ""){
            _model.Command(Definitions.Commands.HOME);
        }
        else{
            if let query = textField.text{
                _model.Query(query);
            }
        }
        
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
        notificationCenter.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil);
        notificationCenter.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil);
        notificationCenter.addObserver(self, selector: #selector(self.applicationBecameActive(_:)), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil);
    }
    
    func InitializeTargets(){
        UITextField_Input.addTarget(self, action: #selector(FirstViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged);
    }
    
    func InitializeDelegates(){
        UITextField_Input.delegate = self;
        _model.delegate = self;
    }
    
    func InitializeModel(){
        UITableView_Results.dataSource = _model;
        UITableView_Results.delegate = self;
        _model.tableView = UITableView_Results;
    }
    
    func InitializeUI(){
        UITextField_Input.clearsOnBeginEditing = true;
        UITableView_Results.backgroundView = nil; //enables setting of color for tableview
        UITableView_Results.backgroundColor = UIColor.clear;
    }
    
    //==============================================
    //Selectors
    //==============================================
    
    
    
    
    //    //==============================================
    //    //API Delegate
    //    //==============================================
    //    func QueryResponse(data: NSData) {
    //        //UITextField_Input.text = data;
    //        let busstop = BusStop(data: data);
    //    }
}

extension FirstViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        _model.Select((indexPath as NSIndexPath).row);
    }
    
}
//MARK: - UITextFieldDelegate
extension FirstViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if(textField.text == ""){
            _model.Command(Definitions.Commands.HOME);
            textField.endEditing(true);
        }
        else{
            if let cmd = textField.text{
                _model.Command(cmd);
                textField.endEditing(true);
                textField.text = "";
            }
        }
        return true;
    }
}

//MARK: - ModelDelegate
extension FirstViewController:ModelDelegate{
    
    //==============================================
    //Model Delegate
    //==============================================
    
    func PresentSafariViewController(_ url: URL) {
        let vc = SFSafariViewController(url: url);
        vc.modalPresentationStyle = .overFullScreen;
        vc.modalPresentationCapturesStatusBarAppearance = true;
        self.present(vc, animated: true, completion: nil)
        
        //        let vc = WebPageViewController();
        //        vc.url = url;
        //        //        vc.LoadWebPage();
        //        vc.modalPresentationStyle = .OverFullScreen;
        //        vc.modalPresentationCapturesStatusBarAppearance = true;
        //        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    func PresentSummaryViewController(_ tableViewItem:TableViewItem?) {
        let vc = SummaryViewController();
        vc.title = tableViewItem?.title;
        vc.content = tableViewItem?.summary;
        _model.activeTableViewItem = tableViewItem;
        _model.activeView = vc;
        self.present(vc, animated: true, completion: {
            self._model.activeTableViewItem = nil;
        });
    }
    
    //Opening File Extensions
    func OpenMP4(_ url: URL) {
        let vc = AVPlayerViewController();
        vc.player = AVPlayer(url: url);
        vc.player?.play();
        self.present(vc, animated: true, completion: nil);
    }
    
}

//
//  WebPageViewController.swift
//  Consolidate
//
//  Created by Conrad Koh on 9/4/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import UIKit
import WebKit

class WebPageViewController: UIViewController {
    var webView:WKWebView?;
    @IBOutlet weak var containerView: UIView!;
    internal var url:URL?;
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func load(){
        super.viewDidLoad();
        // Create the user content controller
        let userContentController: WKUserContentController = WKUserContentController()
        // Create the configuration with the user content controller
        let configuration: WKWebViewConfiguration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        // Create the web view with the configuration
        webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView!.translatesAutoresizingMaskIntoConstraints = false;
        self.view = webView;
        //self.containerView = webView;
        //self.containerView.addSubview(webView!)
        if(url != nil){
            let request = NSMutableURLRequest(url: url!);
            webView!.load(request as URLRequest);
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    func LoadWebPage(){
    //        // Create the user content controller
    //        let userContentController: WKUserContentController = WKUserContentController()
    //        // Create the configuration with the user content controller
    //        let configuration: WKWebViewConfiguration = WKWebViewConfiguration()
    //        configuration.userContentController = userContentController
    //
    //        // Create the web view with the configuration
    //        webView = WKWebView(frame: CGRectZero, configuration: configuration)
    //        webView!.translatesAutoresizingMaskIntoConstraints = false;
    //        self.containerView.addSubview(webView!)
    //        if(url != nil){
    //            let request = NSMutableURLRequest(URL: url!);
    //            webView!.loadRequest(request);
    //        }
    //    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

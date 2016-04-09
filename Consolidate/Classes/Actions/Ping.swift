//
//  Ping.swift
//  Consolidate
//
//  Created by Conrad Koh on 9/4/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
public class Ping:Actionable{
    public var delegate: ActionDelegate?
    public var ip:String?;
    public func Execute() {
        if(ip != nil){
            let url_string = URLParser.Normalize(ip!);
            let url = NSURL.init(string: url_string);
            let request = NSMutableURLRequest.init(URL: url!);
            
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {_,_,_ in 
            })
            task.resume();
        }
    }
    public func Cancel() {
        
    }
}
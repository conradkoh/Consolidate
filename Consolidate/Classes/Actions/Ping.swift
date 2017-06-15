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
            let url = URL.init(string: url_string);
            let request = URLRequest.init(url: url!)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (_,_,_) -> Void in
                
            })
            task.resume();
        }
    }
    public func Cancel() {
        
    }
}

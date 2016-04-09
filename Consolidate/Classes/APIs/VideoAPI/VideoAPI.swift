//
//  VideoAPI.swift
//  Consolidate
//
//  Created by Conrad Koh on 7/4/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
public class VideoAPI:API{
    public var delegate:APIDelegate?;
    public func Query(query: String) {
        let tokens = query.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                          .componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
        let checkedQuery = tokens[0];
        //let url = NSURL.init(string: Constants.URI + Constants.path + Keys.BUSSTOPID + query + Keys.SST);
        let url = NSURL.init(string: Constants.IP_ADDRESS + Constants.PORT + checkedQuery);
        let request = NSMutableURLRequest.init(URL: url!);
//        request.setValue(Values.ACCOUNTKEY, forHTTPHeaderField: Keys.ACCOUNTKEY);
//        request.setValue(Values.UNIQUEUSERID, forHTTPHeaderField: Keys.UNIQUEUSERID);
//        request.setValue(Values.ACCEPT, forHTTPHeaderField: Keys.ACCEPT);
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {
            (data,response,error) in
            if(data != nil){
                self.delegate?.QueryResponse(data!);
            }
            if(error != nil){
                NSLog("\(error)");
            }
        })
        
        task.resume();

    }
    
    public class Constants{
        static let IP_ADDRESS = "http://192.168.1.177";
        static let PORT = ":8080";
    }
}
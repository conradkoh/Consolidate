//
//  BusAPI.swift
//  Consolidate
//
//  Created by Conrad Koh on 24/3/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
//==============================================
//Bus API
//==============================================
open class BusAPI:API{
    open var delegate:APIDelegate?;
    open func Query(_ query:String) {
        //Check string for white spaces
        
        var checkedQuery = query.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
        let tokens = checkedQuery.components(separatedBy: CharacterSet.whitespacesAndNewlines);
        if tokens.count > 0{
            checkedQuery = tokens[0];
            //Begin request
            if let url = URL.init(string: Constants.URI + Constants.path + Keys.BUSSTOPID + checkedQuery + Keys.SST){
            //let url = NSURL.init(string: "http://datamall2.mytransport.sg/ltaodataservice/BusArrival?BusStopID=83139");
            
            let request = NSMutableURLRequest.init(url: url);
            request.setValue(Values.ACCOUNTKEY, forHTTPHeaderField: Keys.ACCOUNTKEY);
            request.setValue(Values.UNIQUEUSERID, forHTTPHeaderField: Keys.UNIQUEUSERID);
            request.setValue(Values.ACCEPT, forHTTPHeaderField: Keys.ACCEPT);
            
            //        //Cancel old requests
            //        NSURLSession.sharedSession().getTasksWithCompletionHandler { (dataTasks, uploadTasks, downloadTasks) in
            //            for dataTask in dataTasks{
            //                dataTask.cancel();
            //            }
            //            for uploadTask in uploadTasks{
            //                uploadTask.cancel();
            //            }
            //            for downloadTask in dataTasks{
            //                downloadTask.cancel();
            //            }
            //        };
            
            
            let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
                (data,response,error) in
                if(data != nil){
                    //let htmlData = String(data: data!, encoding: NSUTF8StringEncoding);
                    self.delegate?.QueryResponse(data!);
                }
                if(error != nil){
                    NSLog("\(error)");
                }
            })
            //        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response,data,error) in
            //            let htmlData = String(data: data!, encoding: NSUTF8StringEncoding);
            //            self.delegate?.QueryResponse(htmlData!);
            //        })
            task.resume();
            }
        }
    }
    public struct Constants{
        public static let URI = "http://datamall2.mytransport.sg";
        public static let path = "/ltaodataservice/BusArrival?";
    }
    public struct Keys{
        public static let ACCOUNTKEY = "AccountKey";
        public static let UNIQUEUSERID = "UniqueUserID";
        public static let ACCEPT = "accept";
        public static let BUSSTOPID = "BusStopID="
        public static let SST = "&SST=True"
        
    }
    public struct Values{
        public static let ACCOUNTKEY = "/Q0e5uJt1upn30IR63an1g==";
        public static let UNIQUEUSERID = "a36607c9-707a-477c-b655-2978b21d1abc";
        public static let ACCEPT = "application/json";
    }
}

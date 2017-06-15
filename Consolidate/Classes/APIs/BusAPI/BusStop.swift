//
//  BusStop.swift
//  Consolidate
//
//  Created by Conrad Koh on 29/3/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
//==============================================
//Bus Stop Object
//==============================================
public struct BusStop{
    public var services:[BusService]{
        return _services;
    }
    fileprivate var _services:[BusService] = [BusService]();
    public init(data:Data){
        do{
            
            let jsonData = try JSONSerialization.jsonObject(with: data, options: []);
            //let str = String.init(data: data, encoding: NSUTF8StringEncoding);
            let jsonDict = jsonData as! NSDictionary;
            let services = jsonDict.value(forKey: Keys.SERVICES) as? [[String:AnyObject]];
            if(services != nil){
                _services = [BusService]();
                for service in services!{
                    let svc = BusService(data: service);
                    _services.append(svc);
                }
            }
        }
        catch{
            
        }
    }
    
    public struct Keys{
        public static let ODATAMETADATA = "odata.metadata";
        public static let SERVICES = "Services";
        public static let BUSSTOPID = "BusStopID";
        
        public static let SERVICENUMBER = "ServiceNo";
        public static let NEXTBUS = "NextBus";
    }
}

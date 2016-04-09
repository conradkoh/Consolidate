//
//  Service.swift
//  Consolidate
//
//  Created by Conrad Koh on 29/3/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
//==============================================
//Bus Stop Object
//==============================================
public struct BusService{
    //==============================================
    //Explorable Protocol
    //==============================================
    public var title: String?;
    
    public var summary:String?{
        get{
            var output:String;
            output = "";
            output += DisplayInfo.SERVICENUMBER + _serviceNumber! + "\n";
            output += DisplayInfo.STATUS + _status! + "\n";
            output += DisplayInfo.OPERATOR + _operator! + "\n";
            output += DisplayInfo.ORIGINATINGID + _originatingID! + "\n";
            output += DisplayInfo.TERMINATINGID + _terminatingID! + "\n";
            if(_nextBus != nil){
                output += DisplayInfo.NEXTBUS + (_nextBus?.timeToArrival)! + "\n";
            }
            if(_subsequentBus != nil){
                output += DisplayInfo.SUBSEQUENTBUS + (_subsequentBus?.timeToArrival)! + "\n";
            }
            if(_subsequentBus2 != nil){
                output += DisplayInfo.SUBSEQUENTBUS2 + (_subsequentBus2?.timeToArrival)!;
            }
            
            return output;
        }
        set{
        }
    }
    
    public var nextBus:Bus?{
        get{
            return _nextBus;
        }
    }
//    public var buses:[Bus]{get{
//        return _buses;
//        }
//    }
//    private var _buses:[Bus] = [Bus]();
    private var _serviceNumber:String?;
    private var _status:String?;
    private var _operator:String?;
    private var _originatingID:String?;
    private var _terminatingID:String?;
    
    private var _nextBus:Bus?;
    private var _subsequentBus:Bus?;
    private var _subsequentBus2:Bus?;
    public init(data:[String:AnyObject]){
        _serviceNumber = data[Keys.SERVICENUMBER] as? String;
        _status = data[Keys.STATUS] as? String;
        _operator = data[Keys.OPERATOR] as? String;
        _originatingID = data[Keys.ORIGINATINGID] as? String;
        _terminatingID = data[Keys.TERMINATINGID] as? String;
        
        _nextBus = Bus(service: _serviceNumber, data: data[Keys.NEXTBUS] as! [String:String]);
        _subsequentBus = Bus(service: _serviceNumber, data: data[Keys.SUBSEQUENTBUS] as! [String:String]);
        _subsequentBus2 = Bus(service: _serviceNumber, data: data[Keys.SUBSEQUENTBUS2] as! [String:String]);
//        let svc = service as NSDictionary;
//        let nextBusData = svc.valueForKey(Keys.NEXTBUS) as? NSDictionary;
//        let svcNo = svc.valueForKey(Keys.SERVICENUMBER) as? String;
//        if(nextBusData != nil){
//            let bus = Bus(service: svcNo, data: nextBusData!);
//            _services.append(bus);
//        }
        
        
//        let nextBusData = svc.valueForKey(Keys.NEXTBUS) as? NSDictionary;
//        let svcNo = svc.valueForKey(Keys.SERVICENUMBER) as? String;
//        if(nextBusData != nil){
//            let bus = Bus(service: svcNo, data: nextBusData!);
//            _services.append(bus);
//        }

    }
    public struct DisplayInfo{
        public static let SERVICENUMBER = "Service Number: ";
        public static let STATUS = "Status: "
        public static let OPERATOR = "Operator: ";
        public static let ORIGINATINGID = "Origin ID: ";
        public static let TERMINATINGID = "Terminating ID: ";
        
        public static let NEXTBUS = "Next Bus: ";
        public static let SUBSEQUENTBUS = "Subsequent Bus: ";
        public static let SUBSEQUENTBUS2 = "Subsequent Bus 2: ";
    }
    
    public struct Keys{
        public static let SERVICENUMBER = "ServiceNo";
        public static let STATUS = "Status"
        public static let OPERATOR = "Operator";
        public static let ORIGINATINGID = "OriginatingID";
        public static let TERMINATINGID = "TerminatingID";
        
        public static let NEXTBUS = "NextBus";
        public static let SUBSEQUENTBUS = "SubsequentBus";
        public static let SUBSEQUENTBUS2 = "SubsequentBus3";
    }
}
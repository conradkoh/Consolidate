//
//  Bus.swift
//  Consolidate
//
//  Created by Conrad Koh on 29/3/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
//==============================================
//Bus Delegate
//==============================================
public protocol BusDelegate{
    func NextBusTiming(timeToArrival:String);
}

//==============================================
//Bus Object
//==============================================
public class Bus{
    //==============================================
    //Variables
    //==============================================
    public var delegate:BusDelegate?;
    //    private var _timer:NSTimer?;
    //==============================================
    //Raw Data
    //==============================================
    let serviceNumber:String?;
    
    let estimatedArrival:String?;
    let latitude:String?;
    let longitude:String?;
    let visitNumber:String?;
    let load:String?;
    let feature:String?;

    
    //==============================================
    //Number
    //==============================================

    
    //==============================================
    //Next Bus (deprecated)
    //==============================================
//    let logitude:String?;
//    let load:String?;
//    let visitNumber:String?;
//    let feature:String?;
    
    var eta:NSDate?;
    public var timeToArrival:String?{get{
        let interval = eta?.timeIntervalSinceNow;
        if(interval != nil){
            return interval?.InHoursAndMinutes();
        }
        else{
            return "";
        }
        }
    };
    //    private var _timeToArrival:String?;
    //let dict:NSDictionary?;
    
    //==============================================
    //Public Interface
    //==============================================
    public init(service:String?, data:[String:String]){
        //Raw Data
        serviceNumber = service;
        estimatedArrival = data[Keys.ESTIMATEDARRIVAL];
        latitude = data[Keys.LATITUDE];
        longitude = data[Keys.LONGITUDE];
        visitNumber = data[Keys.VISITNUMBER];
        load = data[Keys.LOAD];
        feature = data[Keys.FEATURE];
        
        if(estimatedArrival != nil){
            let dateFormatter = NSDateFormatter();
            dateFormatter.timeZone = NSCalendar.currentCalendar().timeZone;
            dateFormatter.dateFormat = Constants.DATEFORMAT;
            eta = dateFormatter.dateFromString(estimatedArrival!);
        }
    }

//    public init(service:String?, data:NSDictionary){
//        serviceNumber = service;
//        dict = data;
//        logitude = data.valueForKey(Keys.LONGITUDE) as? String;
//        load = data.valueForKey(Keys.LOAD) as? String;
//        visitNumber = data.valueForKey(Keys.VISITNUMBER) as? String;
//        feature = data.valueForKey(Keys.FEATURE) as? String;
//        let eta_s = data.valueForKey(Keys.ETA) as? String;
//        //        super.init();//let variables must be initialized before super init call
//        
//        
//        if(eta_s != nil){
//            let dateFormatter = NSDateFormatter();
//            dateFormatter.timeZone = NSCalendar.currentCalendar().timeZone;
//            dateFormatter.dateFormat = Constants.DATEFORMAT;
//            eta = dateFormatter.dateFromString(eta_s!);
//        }
//        //        if(eta != nil){
//        //            let interval = eta!.timeIntervalSinceNow;
//        ////            _timeToArrival = interval.InHoursAndMinutes();
//        //        }
//    }
    
    //    public func backgroundRefresh(timer:NSTimer){
    //        let interval = eta!.timeIntervalSinceNow;
    //        timeToArrival = interval.InHoursAndMinutes();
    //        delegate?.NextBusTiming(timeToArrival);
    //    }
    
    public struct Constants{
        public static let REGEXPATTERN_TIME = "(?<=T)[0-9][0-9]:[0-9][0-9]:[0-9][0-9]";
        public static let REGEXPATTER_DATE = "[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]";
        public static let DATEFORMAT = "yyyy-MM-dd'T'HH:mm:ssZZZZZ";
    }
    
    
    public struct Keys{
        
        public static let ESTIMATEDARRIVAL = "EstimatedArrival";
        public static let LATITUDE = "Latitude";
        public static let LONGITUDE = "Longitude";
        public static let VISITNUMBER = "VisitNumber";
        public static let LOAD = "Load";
        public static let FEATURE = "Feature";
    }
}
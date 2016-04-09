//
//  Search.swift
//  Consolidate
//
//  Created by Conrad Koh on 24/3/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
public class BusSearch:NSObject, Actionable, APIDelegate{
    public static let singleton = BusSearch();
    public var query:String?;
    private var _timer:NSTimer?;
    private var _staticTimer:NSTimer?;
    private var _services:[BusService]?;
    public var delegate: ActionDelegate?;
    private override init(){
        
    }
    
    //========================================
    //Actionable Protocol
    //========================================
    public func Execute() {
        let busapi = BusAPI();
        busapi.delegate = self;
        if(query != nil){
            busapi.Query(query!);
            _timer?.invalidate();
            _timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: #selector(BusSearch.APIRefresh(_:)), userInfo: nil, repeats: true);
            _timer?.fire();
        }
    }
    
    public func Cancel() {
        self.delegate = nil;
    }
    
    public func QueryResponse(data: NSData) {
        let stop = BusStop(data: data);
        _services = stop.services;
        
//        var listview = [[String:String]]();
        var listView = [TableViewItem]();
        for service in _services!{
            let nextBus = service.nextBus;
//            var result = [String:String]();
            
//            result[ActionableKeys.TITLE] = nextBus?.serviceNumber;
//            result[ActionableKeys.DETAIL] = nextBus?.timeToArrival;
//            result[ActionableKeys.SUMMARY] = service.summary;
            let result = TableViewItem();
            result.title = nextBus?.serviceNumber;
            result.detail = nextBus?.timeToArrival;
            result.summary = service.summary;
            listView.append(result);
        }
        
//        delegate?.ActionCallback(listview);
    }
    //======================================
    //Timed Refresh
    //======================================
    public func APIRefresh(timer:NSTimer){
        let busapi = BusAPI();
        busapi.delegate = self;
        busapi.Query(query!);
        _staticTimer?.invalidate();
        _staticTimer = NSTimer.scheduledTimerWithTimeInterval(4, target: self, selector: #selector(BusSearch.staticTimerRefresh(_:)), userInfo: nil, repeats: true);
        _staticTimer?.fire();
    }
    
    
    public func staticTimerRefresh(timer:NSTimer){
        if(_services != nil){
//            var listview = [[String:String]]();
//            for service in _services!{
//                let nextBus = service.nextBus;
//                var result = [String:String]();
//                
//                result[ActionableKeys.TITLE] = nextBus?.serviceNumber;
//                result[ActionableKeys.DETAIL] = nextBus?.timeToArrival;
//                result[ActionableKeys.SUMMARY] = service.summary;
//                
//                listview.append(result);
//            }
            var listview = [TableViewItem]();
            for service in _services!{
                let nextBus = service.nextBus;
                let result = TableViewItem();
                
                result.title = nextBus?.serviceNumber;
                result.detail = nextBus?.timeToArrival;
                result.summary = service.summary;
                
                listview.append(result);
            }
            
            delegate?.ActionCallback(listview);
        }
    }
    
    

}
//
//  Search.swift
//  Consolidate
//
//  Created by Conrad Koh on 24/3/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
open class BusSearch:NSObject, Actionable, APIDelegate{
    open static let singleton = BusSearch();
    open var query:String?;
    fileprivate var _timer:Timer?;
    fileprivate var _staticTimer:Timer?;
    fileprivate var _services:[BusService]?;
    open var delegate: ActionDelegate?;
    fileprivate override init(){
        
    }
    
    //========================================
    //Actionable Protocol
    //========================================
    open func Execute() {
        let busapi = BusAPI();
        busapi.delegate = self;
        if(query != nil){
            delegate?.ActionCallback([TableViewItem.searchingStateItem]);
            busapi.Query(query!);
            _timer?.invalidate();
            _timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(BusSearch.APIRefresh(_:)), userInfo: nil, repeats: true);
            _timer?.fire();
        }
    }
    
    open func Cancel() {
        self.delegate = nil;
        _timer?.invalidate();
        _staticTimer?.invalidate();
    }
    
    open func QueryResponse(_ data: Data) {
        let stop = BusStop(data: data);
        _services = stop.services;
        
        var listView = [TableViewItem]();
        for service in _services!{
            let nextBus = service.nextBus;
            let result = TableViewItem();
            result.title = nextBus?.serviceNumber;
            result.detail = nextBus?.timeToArrival;
            result.summary = service.summary;
            result.command = Definitions.Commands.SUMMARIZE;
            listView.append(result);
        }
        delegate?.ActionCallback(listView);
    }
    //======================================
    //Timed Refresh
    //======================================
    open func APIRefresh(_ timer:Timer){
        let busapi = BusAPI();
        busapi.delegate = self;
        busapi.Query(query!);
        _staticTimer?.invalidate();
        _staticTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(BusSearch.staticTimerRefresh(_:)), userInfo: nil, repeats: true);
        _staticTimer?.fire();
    }
    
    
    open func staticTimerRefresh(_ timer:Timer){
        if(_services != nil){
            var listview = [TableViewItem]();
            for service in _services!{
                let nextBus = service.nextBus;
                let result = TableViewItem();
                
                result.title = nextBus?.serviceNumber;
                result.detail = nextBus?.timeToArrival;
                result.summary = service.summary;
                result.command = Definitions.Commands.SUMMARIZE;
                listview.append(result);
            }
            
            delegate?.ActionCallback(listview);
        }
    }
    
    
    
}

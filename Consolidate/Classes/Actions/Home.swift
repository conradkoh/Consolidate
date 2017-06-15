//
//  Home.swift
//  Consolidate
//
//  Created by Conrad Koh on 9/4/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
open class Home:Actionable{
    open var delegate: ActionDelegate?
    open func Execute() {
        var homeTable = [TableViewItem]();
        let boot = self.bootItem();
        let hibernate = self.hibernateItem();
        let video = self.videoDirectioryItem();
        homeTable.append(boot);
        homeTable.append(hibernate);
        homeTable.append(video);
        delegate?.ActionCallback(homeTable);
        
    }
    open func Cancel() {
        
    }
    
    fileprivate func bootItem() -> TableViewItem{
        let boot = TableViewItem();
        let IP_ADDRESS = "192.168.1.177";
        boot.title = "Boot PC";
        boot.detail = IP_ADDRESS;
        boot.command = Definitions.Commands.PING + IP_ADDRESS;
        return boot;
    }
    
    fileprivate func hibernateItem() -> TableViewItem{
        let hibernate = TableViewItem();
        let queryAddress = "192.168.1.177:14254/cmd?=hibernate";
        hibernate.title = "Hibernate PC";
        hibernate.detail = "192.168.1.177";
        hibernate.command = Definitions.Commands.PING + queryAddress;
        return hibernate;
    }
    
    fileprivate func videoDirectioryItem() -> TableViewItem{
        let video = TableViewItem();
        video.title = "Videos";
        video.command = Definitions.Commands.VIDEO;
        return video;
    }
}

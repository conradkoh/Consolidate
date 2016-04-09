//
//  Home.swift
//  Consolidate
//
//  Created by Conrad Koh on 9/4/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
public class Home:Actionable{
    public var delegate: ActionDelegate?
    public func Execute() {
        var homeTable = [TableViewItem]();
        let boot = self.bootItem();
        let video = self.videoDirectioryItem();
        homeTable.append(boot);
        homeTable.append(video);
        delegate?.ActionCallback(homeTable);
        
    }
    public func Cancel() {
        
    }
    
    private func bootItem() -> TableViewItem{
        let boot = TableViewItem();
        let IP_ADDRESS = "192.168.1.177";
        boot.title = "Boot PC";
        boot.detail = IP_ADDRESS;
        boot.command = Definitions.Commands.PING + IP_ADDRESS;
        return boot;
    }
    
    private func videoDirectioryItem() -> TableViewItem{
        let video = TableViewItem();
        video.title = "Videos";
        video.command = Definitions.Commands.VIDEO;
        return video;
    }
}
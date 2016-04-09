//
//  Open.swift
//  Consolidate
//
//  Created by Conrad Koh on 9/4/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
public class Open:Actionable{
    public var delegate: ActionDelegate?
    public static let singleton = Open();
    public var path:String{
        get{
            return _path;
        }
        set{
            _path = URLParser.Normalize(newValue);
        }
    }
    
    private var _path:String = "";
    
    
    private init(){}
    
    public func Execute() {
        let viewItem = TableViewItem();
        let cmd = Definitions.Commands.OPEN + _path;
        viewItem.title = cmd;
        viewItem.detail = _path;
        viewItem.command = cmd;
        
        delegate?.ActionCallback([viewItem]);
    }
    public func Cancel() {
        
    }
}
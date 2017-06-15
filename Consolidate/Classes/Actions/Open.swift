//
//  Open.swift
//  Consolidate
//
//  Created by Conrad Koh on 9/4/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
open class Open:Actionable{
    open var delegate: ActionDelegate?
    open static let singleton = Open();
    open var path:String{
        get{
            return _path;
        }
        set{
            _path = URLParser.Normalize(newValue);
        }
    }
    
    fileprivate var _path:String = "";
    
    
    fileprivate init(){}
    
    open func Execute() {
//        let viewItem = TableViewItem();
//        let cmd = Definitions.Commands.OPEN + _path;
//        viewItem.title = cmd;
//        viewItem.detail = _path;
//        viewItem.command = cmd;
        
        
//        let url = NSURL(string: _path);
//        if(url != nil){
//            delegate?.OpenURL(url!);
//        }
        
        
        //delegate?.ActionCallback([viewItem]);
        
        delegate?.OpenFile(_path);
    }
    open func Cancel() {
        
    }
}

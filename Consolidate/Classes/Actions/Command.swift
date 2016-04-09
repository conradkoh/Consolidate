//
//  CommandAction.swift
//  Consolidate
//
//  Created by Conrad Koh on 20/2/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
public class Command:Actionable{
    public var delegate:ActionDelegate?;
//    override init(){
//        
//    }
    
    public func Execute() {
//        var listview = [[String:String]]();
//        var result = [String:String]();
        
        
//        result[Actionable.Keys.TITLE] = Constants.EXECUTE_SUCCESS;
//        result[Actionable.Keys.DETAIL] = "detail"
//        listview.append(result);
//        delegate?.ActionCallback(listview);
    }
    
    public func Cancel(){
        
    }
    
    public class Constants{
        public static let EXECUTE_SUCCESS = "Command executed";
        public static let EXECUTE_FAILED = "Command execute failed";
    }
}

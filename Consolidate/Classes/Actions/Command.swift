//
//  CommandAction.swift
//  Consolidate
//
//  Created by Conrad Koh on 20/2/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
open class Command:Actionable{
  open var delegate:ActionDelegate?;
  //    override init(){
  //
  //    }
  
  open func Execute() {
    //        var listview = [[String:String]]();
    //        var result = [String:String]();
    
    
    //        result[Actionable.Keys.TITLE] = Constants.EXECUTE_SUCCESS;
    //        result[Actionable.Keys.DETAIL] = "detail"
    //        listview.append(result);
    //        delegate?.ActionCallback(listview);
  }
  
  open func Cancel(){
    
  }
  
  open class Constants{
    open static let EXECUTE_SUCCESS = "Command executed";
    open static let EXECUTE_FAILED = "Command execute failed";
  }
}

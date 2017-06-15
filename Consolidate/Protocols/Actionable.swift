//
//  Command.swift
//  Consolidate
//
//  Created by Conrad Koh on 20/2/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
public protocol ActionDelegate{
    //func ActionCallback(result:[[String:String]]);
    func ActionCallback(_ result:[TableViewItem]);
    func Summarize(_ tableViewItemIndex:Int);
    func OpenFile(_ url_string:String);
}
public protocol Actionable{
    var delegate:ActionDelegate?{get set};
    func Execute();
    func Cancel();
}

open class ActionableKeys{
    open static let TITLE = "title";
    open static let DETAIL = "detail";
    open static let SUMMARY = "summary";
    open static let TYPE = "type";
}

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
    func ActionCallback(result:[TableViewItem]);
}
public protocol Actionable{
    var delegate:ActionDelegate?{get set};
    func Execute();
    func Cancel();
}

public class ActionableKeys{
    public static let TITLE = "title";
    public static let DETAIL = "detail";
    public static let SUMMARY = "summary";
    public static let TYPE = "type";
}
//
//  Summarize.swift
//  Consolidate
//
//  Created by Conrad Koh on 9/4/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
open class Summarize:Actionable{
    open var delegate: ActionDelegate?
    open var tableViewItemIndex:Int?;
    open func Execute() {
        if(tableViewItemIndex != nil){
            delegate?.Summarize(tableViewItemIndex!);
        }
    }
    open func Cancel() {
        
    }
}

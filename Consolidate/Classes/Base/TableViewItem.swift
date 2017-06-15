//
//  TableViewItem.swift
//  Consolidate
//
//  Created by Conrad Koh on 7/4/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
open class TableViewItem:Explorable{
    open var detail: String?
    open var summary: String?
    open var title: String?
    open var command: String?
    open var query:String?
    
    open static var emptyQueryItem:TableViewItem{
        get{
            let item = TableViewItem();
            item.title = Constants.EMPTYQUERY_TITLE;
            item.detail = Constants.EMPTYQUERY_DETAIL;
            item.command = Definitions.Commands.HOME;
            return item;
        }
    }
    
    open static var emptyCommandItem:TableViewItem{
        get{
            let item = TableViewItem();
            item.title = Constants.EMPTYCOMMAND_TITLE;
            item.detail = Constants.EMPTYCOMMAND_DETAIL;
            item.command = Definitions.Commands.HOME;
            return item;
        }
    }
    
    open static var searchingStateItem:TableViewItem{
        get{
            let item = TableViewItem();
            item.title = Constants.SEARCHSTATE_TITLE;
            item.detail = Constants.SEARCHSTATE_DETAIL;
            item.command = Definitions.Commands.HOME;
            return item;
        }
    }
    
    open class Constants{
        open static let EMPTYQUERY_TITLE = "No items found matching query";
        open static let EMPTYQUERY_DETAIL = "Tap to return to home";
        open static let EMPTYCOMMAND_TITLE = "No items found matching command";
        open static let EMPTYCOMMAND_DETAIL = "Tap to return to home";
        
        open static let SEARCHSTATE_TITLE = "Searching...";
        open static let SEARCHSTATE_DETAIL = "Tap to return to home";
    }
}

//
//  Model.swift
//  Consolidate
//
//  Created by Conrad Koh on 7/3/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
import EventKitUI
public class Model:NSObject, UITableViewDataSource, ActionDelegate{
    public static let singleton = Model();
    public var tableView:UITableView?;
//    private var _view = [[String:String]]();
    private var _view = [TableViewItem]();
//    private var _context:String?;
    internal var activeView:SummaryViewController?;
    internal var activeViewIndex:Int?;
    
    //==============================================
    //Private Variables
    //==============================================
    private var activeAction:Actionable?;
    
    private override init(){}
    
    //==============================================
    //UITableViewDataSource
    //==============================================
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _view.count;
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let actionCell = UITableViewCell.init(style: .Subtitle, reuseIdentifier: Constants.ACTION_CELL_ID);
        let tableViewItem = _view[indexPath.row];
        actionCell.textLabel!.text = tableViewItem.title;
        actionCell.detailTextLabel?.text = tableViewItem.detail;
        return actionCell;
    }

    //==============================================
    //Public Interface
    //==============================================
    public func Query(query:String){
        activeAction?.Cancel(); //Cancel existing action
        let checkedQuery = Parser.Normalize(query);
        activeAction = Parser.actionFromQuery(checkedQuery);
        activeAction?.delegate = self;
        activeAction?.Execute();
    }
    
    public func Command(command:String){
        activeAction?.Cancel(); //Cancel existing action
        let checkedCommand = Parser.Normalize(command);
        activeAction = Parser.actionFromCommand(checkedCommand);
        activeAction?.delegate = self;
        activeAction?.Execute();
    }
    public func shouldPresentAtIndex(index:Int) -> Bool{
        if(index < _view.count){
            let subQuery = _view[index].command;
            if(subQuery != nil){
                let cmdType = Parser.RetrieveActionType(subQuery!);
                if(cmdType == Definitions.ACTIONTYPE.OPEN){
                    return true;
                }
            }
        }
        return false;
    }
    
    public func pathForPresentationAtIndex(index:Int) -> String{
        if(index < _view.count){
            return _view[index].detail!; //detail is set to contain the filePath in Open Action
        }
        return "";
    }
    public func isQueryAtIndex(index:Int) -> Bool{
        if(index < _view.count){
            if(_view[index].query != nil){
                return true;
            }
        }
        return false;
    }
    
    public func isCommandAtIndex(index:Int) -> Bool{
        if(index < _view.count){
            if(_view[index].command != nil){
                return true;
            }
        }
        return false;
    }
    
    public func performQueryAtIndex(index:Int){
        if(index < _view.count){
            let item = _view[index];
            let query = item.command;
            if(query != nil){
                self.Query(query!);
            }
        }
    }
    
    public func performCommandAtIndex(index:Int){
        if(index < _view.count){
            let item = _view[index];
            let command = item.command;
            if(command != nil){
                self.Command(command!);
            }
        }
    }
    
    public func summaryAtIndex(index:Int) -> TableViewItem?{
        if(index < _view.count){
            return _view[index];
        }
        return nil;
    }
    
    public func setActiveIndex(index:Int){
        if(index < _view.count){
            activeViewIndex = index;
        }
    }
    
    //==============================================
    //Action Delegate
    //==============================================
    
    public func ActionCallback(result: [TableViewItem]) {
        _view = result;
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView?.reloadData();
            if(self.activeViewIndex != nil){
                let summary = self._view[self.activeViewIndex!];
                self.activeView?.title = summary.title;
                self.activeView?.content = summary.summary;
            }
        })
        
    }
    
//    public func ActionCallback(result: [[String:String]]) {
//        _view = result;
//        dispatch_async(dispatch_get_main_queue(), {
//            self.tableView?.reloadData();
//            if(self.activeViewIndex != nil){
//                let summary = self._view[self.activeViewIndex!];
//                self.activeView?.title = summary[ActionableKeys.TITLE];
//                self.activeView?.content = summary[ActionableKeys.SUMMARY];
//            }
//        })
//        
//    }
    
    struct Constants{
        static let ACTION_CELL_ID = "Cell_Action";
    }
    
}
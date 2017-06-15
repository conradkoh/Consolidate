//
//  Model.swift
//  Consolidate
//
//  Created by Conrad Koh on 7/3/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
import EventKitUI
import AVFoundation
open class Model:NSObject, UITableViewDataSource, ActionDelegate{
    open static let singleton = Model();
    open var tableView:UITableView?;
    open var delegate:ModelDelegate?;
    
//    private var _view = [[String:String]]();
    fileprivate var _view = [TableViewItem]();
//    private var _context:String?;
    internal var activeView:SummaryViewController?;
    internal var activeTableViewItem:TableViewItem?;
//    internal var activeViewIndex:Int?;
    
    //==============================================
    //Private Variables
    //==============================================
    fileprivate var activeAction:Actionable?;
    
    fileprivate override init(){}
    
    //==============================================
    //UITableViewDataSource
    //==============================================
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _view.count;
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let actionCell = UITableViewCell.init(style: .subtitle, reuseIdentifier: Constants.ACTION_CELL_ID);
        let tableViewItem = _view[(indexPath as NSIndexPath).row];
//        actionCell.selectionStyle = .Default;
        actionCell.textLabel!.text = tableViewItem.title;
        actionCell.detailTextLabel?.text = tableViewItem.detail;
        actionCell.textLabel?.textColor = UIColor.white;
        actionCell.detailTextLabel?.textColor = UIColor.white;
        
        actionCell.contentView.backgroundColor = UIColor.clear;
        actionCell.backgroundColor = UIColor.clear;
        
        actionCell.selectedBackgroundView = UIView();
        actionCell.selectedBackgroundView?.backgroundColor = Style.darkOverlayColor;
        return actionCell;
    }

    //==============================================
    //Public Interface
    //==============================================
    open func Query(_ query:String){
        activeAction?.Cancel(); //Cancel existing action
        let checkedQuery = query;
        activeAction = Parser.actionFromQuery(checkedQuery);
        activeAction?.delegate = self;
        activeAction?.Execute();
    }
    
    open func Command(_ command:String){
        activeAction?.Cancel(); //Cancel existing action
        activeAction = Parser.actionFromCommand(command, index: -1);
        activeAction?.delegate = self;
        activeAction?.Execute();
    }
    
    open func Select(_ index:Int){
        if(index < _view.count){
            let tableViewItem = _view[index];
            let command = tableViewItem.command;
            if(command != nil){
                activeAction = Parser.actionFromCommand(command!, index: index);
                activeAction?.delegate = self;
                activeAction?.Execute();
            }
        }
    }
    

    
    open func setActiveTableViewItem(_ tableViewItem:TableViewItem){
        activeTableViewItem = tableViewItem;
    }
    
    //==============================================
    //Action Delegate
    //==============================================
    
    open func ActionCallback(_ result: [TableViewItem]) {
        if(result.count > 0){
            _view = result;
        }
        else{
            _view = [TableViewItem.emptyQueryItem];
        }
        //reload the table
        DispatchQueue.main.async(execute: {
            self.tableView?.reloadData();
            if let item = self.activeTableViewItem{
                if let view = self.activeView{
                    view.title = item.title;
                    view.content = item.summary;
                }
            }
        })
    }
    
    open func Summarize(_ tableViewItemIndex:Int) {
        if(tableViewItemIndex < _view.count){
            let tableViewItem = _view[tableViewItemIndex];
            delegate?.PresentSummaryViewController(tableViewItem);
            var x = 1;
        }
    }
    
    open func OpenFile(_ url_string:String) {
        let url = URL.init(string: url_string);
        if(url != nil){
            let file_ext = URLParser.FileExtensionFromURL(url_string);
            if(Definitions.AVPLAYER_FILE_FORMATS.index(of: file_ext!) != nil){
                delegate?.OpenMP4(url!);
            }
            else{
                delegate?.PresentSafariViewController(url!);
            }
        }
        
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

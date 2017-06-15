//
//  VideoSearch.swift
//  Consolidate
//
//  Created by Conrad Koh on 7/4/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
import NetworkExtension
open class VideoSearch:Actionable, APIDelegate{
  open var delegate: ActionDelegate?
  open static let singleton = VideoSearch();
  open var query:String?;
  fileprivate init(){
  }
  open func Execute() {
    let api = VideoAPI();
    api.delegate = self;
    if(query != nil){
      api.Query(query!);
    }
  }
  
  open func Cancel() {
    
  }
  
  open func QueryResponse(_ data: Data) {
    
    let htmlContent = String.init(data: data, encoding: String.Encoding.utf8);
    //        let delimiters_step_1 = [Constants.DELIMITER_FILE_START,Constants.DELIMITER_DIRECTORY_START];
    //        let delimiters_step_2 = [Constants.DELIMITER_FILE_END, Constants.DELIMITER_DIRECTORY_END];
    //        let results_step_1 = htmlContent?.componentsSeparatedByAnyOf(delimiters_step_1);
    //        var results_step_2 = [String]();
    //        if(results_step_1 != nil){
    //            for result in results_step_1!{
    //                let tokens = result.componentsSeparatedByAnyOf(delimiters_step_2);
    //                results_step_2.appendContentsOf(tokens);
    //            }
    //        }
    
    //DIRECTORIES
    var listView = [TableViewItem]();
    if(htmlContent != nil){
      let directory_entries = htmlContent!.componentsMatchingRegex(Constants.REGEX_DIRECTORY_ENTRY);
      for entry in directory_entries{
        let viewItem = TableViewItem();
        let titleRange = entry.range(of: Constants.REGEX_TITLE, options: .regularExpression);
        if(titleRange != nil){
          let title = entry.substring(with: titleRange!);
          viewItem.title = title;
        }
        let pathRange = entry.range(of: Constants.REGEX_PATH, options: .regularExpression);
        if(pathRange != nil){
          let path = entry.substring(with: pathRange!);
          viewItem.detail = path;
          let videoPath = VideoURLPath.init(string: Definitions.Commands.VIDEO + path);
          viewItem.command = videoPath.normalized();
        }
        listView.append(viewItem);
      }
      
      //FILES
      let file_entries = htmlContent!.componentsMatchingRegex(Constants.REGEX_FILE_ENTRY);
      for entry in file_entries{
        let fileInfoRng = entry.range(of: Constants.REGEX_FILE_INFO, options: .regularExpression);
        if(fileInfoRng != nil){
          let fileInfo = entry.substring(with: fileInfoRng!);
          
          let viewItem = TableViewItem();
          let titleRange = fileInfo.range(of: Constants.REGEX_FILE_INFO_TITLE, options: .regularExpression);
          if(titleRange != nil){
            let title = fileInfo.substring(with: titleRange!);
            viewItem.title = "File: " + title;
          }
          let pathRange = fileInfo.range(of: Constants.REGEX_FILE_INFO_PATH, options: .regularExpression);
          if(pathRange != nil){
            let path = fileInfo.substring(with: pathRange!);
            viewItem.detail = VideoAPI.Constants.IP_ADDRESS + VideoAPI.Constants.PORT + path;
            viewItem.summary = path;
            viewItem.command = Definitions.Commands.OPEN + VideoAPI.Constants.IP_ADDRESS + VideoAPI.Constants.PORT + path;
          }
          else{
            
          }
          listView.append(viewItem);
        }
        
      }
    }
    
    
    //            for result in results_step_1!{
    //                //check that the result is not the write permissions string
    //                if(result.rangeOfString(Constants.REGEX_FILE_PERMISSIONS, options: .RegularExpressionSearch)?.startIndex != result.startIndex){
    //
    //                    let viewItem = TableViewItem();
    //                    viewItem.title = result;
    //                    viewItem.detail = result;
    //                    viewItem.summary = result;
    //                    //begin checking if path should be followed
    //                    let matches = result.rangeOfString(Constants.REGEX_FILE_PATH_COMPONENT, options: .RegularExpressionSearch);
    //                    if(matches != nil){
    //                        let path_component = result.substringWithRange(matches!);
    //                        viewItem.subQuery = query! + path_component;
    //                    }
    //                    //                let separatorRange = result.rangeOfString(Constants.STRING_DELIMITERS[2]);
    //                    //                if(separatorRange != nil){
    //                    //                    let subPath = result.substringToIndex(separatorRange!.startIndex);
    //                    //                    if(query != nil){
    //                    //                        viewItem.subQuery = query! + subPath;
    //                    //                    }
    //                    //                }
    //
    //                    listView.append(viewItem);
    //                }
    //
    //            }
    //        delegate?.ActionCallback(newListView);
    delegate?.ActionCallback(listView);
  }
  
  open class Constants{
    //        public static let DELIMITER_PATH_START = "</code></td><td style=\"padding-left: 1em\"><a href=\"";
    //        public static let DELIMITER_PATH_END = "\">";
    open static let REGEX_DIRECTORY_ENTRY = "<\\/code><\\/td><td style=\"text-align: right; padding-left: 1em\"><code><\\/code>.+<\\/a><\\/td><\\/tr>";
    open static let REGEX_TITLE = "(?<=\\/\">).+(?=<\\/a><\\/td><\\/tr>)";
    //        public static let REGEX_TITLE = "(?<=\\/\\\\\">).+(?=<\\/a><\\/td><\\/tr>)";
    open static let REGEX_PATH = "(?<=<\\/code><\\/td><td style=\"padding-left: 1em\"><a href=\").+(?=\\/\">)";
    open static let REGEX_FILE_ENTRY = "<\\/code><\\/td><td style=\"text-align: right; padding-left: 1em\"><code>[^<]+.+<\\/a><\\/td><\\/tr>"
    open static let REGEX_FILE_INFO = "<a href=\\\".+<\\/a><\\/td><\\/tr>";
    open static let REGEX_FILE_INFO_TITLE = "(?<=\">).+(?=<\\/a><\\/td><\\/tr>)";
    open static let REGEX_FILE_INFO_PATH = "(?<=<a href=\").+(?=\">)";
    //        public static let DELIMITER_FILE_START = "</td><td style=\"text-align: right; padding-left: 1em\"><code>255.6M</code></td><td style=\"padding-left: 1em\"><a href=\"";
    //        public static let DELIMITER_FILE_END = "\">";
    //        public static let STRING_DELIMITERS =
    //            ["</code></td><td style=\"text-align: right; padding-left: 1em\"><code></code></td><td style=\"padding-left: 1em\"><a href=\"",
    //             "</a></td></tr>\n<tr><td><code>",
    //             "\">"];
    //        public static let REGEX_FILE_PERMISSIONS = "\\(..........\\)";
    //        public static let REGEX_FILE_PATH_COMPONENT = "(?<=\\/)[^\\s\\/]+\\/"
  }
}

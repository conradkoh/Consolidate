//
//  VideoSearch.swift
//  Consolidate
//
//  Created by Conrad Koh on 7/4/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
import NetworkExtension
public class VideoSearch:Actionable, APIDelegate{
    public var delegate: ActionDelegate?
    public static let singleton = VideoSearch();
    public var query:String?;
    private init(){
    }
    public func Execute() {
        let api = VideoAPI();
        api.delegate = self;
        if(query != nil){
            api.Query(query!);
        }
    }
    
    public func Cancel() {
        
    }
    
    public func QueryResponse(data: NSData) {
        
        let htmlContent = String.init(data: data, encoding: NSUTF8StringEncoding);
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
                let titleRange = entry.rangeOfString(Constants.REGEX_TITLE, options: .RegularExpressionSearch);
                if(titleRange != nil){
                    let title = entry.substringWithRange(titleRange!);
                    viewItem.title = title;
                }
                let pathRange = entry.rangeOfString(Constants.REGEX_PATH, options: .RegularExpressionSearch);
                if(pathRange != nil){
                    let path = entry.substringWithRange(pathRange!);
                    viewItem.detail = path;
                    let videoPath = VideoURLPath.init(string: Definitions.Commands.VIDEO + path);
                    viewItem.command = videoPath.normalized();
                    
                }
                listView.append(viewItem);
            }
            
            //FILES
            let file_entries = htmlContent!.componentsMatchingRegex(Constants.REGEX_FILE_ENTRY);
            for entry in file_entries{
                let fileInfoRng = entry.rangeOfString(Constants.REGEX_FILE_INFO, options: .RegularExpressionSearch);
                if(fileInfoRng != nil){
                    let fileInfo = entry.substringWithRange(fileInfoRng!);
                    
                    let viewItem = TableViewItem();
                    let titleRange = fileInfo.rangeOfString(Constants.REGEX_FILE_INFO_TITLE, options: .RegularExpressionSearch);
                    if(titleRange != nil){
                        let title = fileInfo.substringWithRange(titleRange!);
                        viewItem.title = "File: " + title;
                    }
                    let pathRange = fileInfo.rangeOfString(Constants.REGEX_FILE_INFO_PATH, options: .RegularExpressionSearch);
                    if(pathRange != nil){
                        let path = fileInfo.substringWithRange(pathRange!);
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

    public class Constants{
//        public static let DELIMITER_PATH_START = "</code></td><td style=\"padding-left: 1em\"><a href=\"";
//        public static let DELIMITER_PATH_END = "\">";
        public static let REGEX_DIRECTORY_ENTRY = "<\\/code><\\/td><td style=\"text-align: right; padding-left: 1em\"><code><\\/code>.+<\\/a><\\/td><\\/tr>";
        public static let REGEX_TITLE = "(?<=\\/\">).+(?=<\\/a><\\/td><\\/tr>)";
//        public static let REGEX_TITLE = "(?<=\\/\\\\\">).+(?=<\\/a><\\/td><\\/tr>)";
        public static let REGEX_PATH = "(?<=<\\/code><\\/td><td style=\"padding-left: 1em\"><a href=\").+(?=\\/\">)";
        public static let REGEX_FILE_ENTRY = "<\\/code><\\/td><td style=\"text-align: right; padding-left: 1em\"><code>[^<]+.+<\\/a><\\/td><\\/tr>"
        public static let REGEX_FILE_INFO = "<a href=\\\".+<\\/a><\\/td><\\/tr>";
        public static let REGEX_FILE_INFO_TITLE = "(?<=\">).+(?=<\\/a><\\/td><\\/tr>)";
        public static let REGEX_FILE_INFO_PATH = "(?<=<a href=\").+(?=\">)";
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
//
//  URLParser.swift
//  Consolidate
//
//  Created by Conrad Koh on 9/4/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
open class URLParser{
    open static func Normalize(_ url_string:String) -> String{
        var checked_url = self.lowerCases(url_string);
        checked_url = self.removeWhiteSpaces(checked_url);
        checked_url = self.checkHttpRequest(checked_url);
        return checked_url;
    }
    
    open static func FileExtensionFromURL(_ url_string:String) -> String?{
        let fileExtensionRange = url_string.range(of: Constants.REGEX_FILE_EXTENSION, options: .regularExpression);
        if(fileExtensionRange != nil){
            let fileExtension = url_string.substring(with: fileExtensionRange!);
            return fileExtension;
        }
        return nil;
    }
    
    fileprivate static func lowerCases(_ url_string:String)->String{
        let checked_url = url_string.lowercased();
        return checked_url;
    }
    fileprivate static func removeWhiteSpaces(_ url_string:String)->String{
        var checked_url = url_string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
        let tokens = checked_url.components(separatedBy: CharacterSet.whitespacesAndNewlines);
        checked_url = tokens[0];
        return checked_url;
    }
    
    fileprivate static func checkHttpRequest(_ url_string:String)->String{
        let httpRng = url_string.range(of: Constants.HTTP);
        let httpsRng = url_string.range(of: Constants.HTTPS);
        var checked_url = url_string;
        if(httpRng == nil && httpsRng == nil){
            checked_url = Constants.HTTP + checked_url;
        }
        return checked_url;
    }
    
    open class Constants{
        open static let HTTP = "http://";
        open static let HTTPS = "https://"
        open static let REGEX_FILE_EXTENSION = ".\\w+\\z"
    }
}

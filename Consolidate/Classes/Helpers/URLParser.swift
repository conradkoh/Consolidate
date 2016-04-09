//
//  URLParser.swift
//  Consolidate
//
//  Created by Conrad Koh on 9/4/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
public class URLParser{
    public static func Normalize(url_string:String) -> String{
        var checked_url = self.lowerCases(url_string);
        checked_url = self.removeWhiteSpaces(checked_url);
        checked_url = self.checkHttpRequest(checked_url);
        return checked_url;
    }
    
    private static func lowerCases(url_string:String)->String{
        let checked_url = url_string.lowercaseString;
        return checked_url;
    }
    private static func removeWhiteSpaces(url_string:String)->String{
        var checked_url = url_string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
        let tokens = checked_url.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
        checked_url = tokens[0];
        return checked_url;
    }
    
    private static func checkHttpRequest(url_string:String)->String{
        let httpRng = url_string.rangeOfString(Constants.HTTP);
        let httpsRng = url_string.rangeOfString(Constants.HTTPS);
        var checked_url = url_string;
        if(httpRng == nil && httpsRng == nil){
            checked_url = Constants.HTTP + checked_url;
        }
        return checked_url;
    }
    
    public class Constants{
        public static let HTTP = "http://";
        public static let HTTPS = "https://"
    }
}
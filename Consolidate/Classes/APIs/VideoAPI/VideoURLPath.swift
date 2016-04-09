//
//  VideoURLPath.swift
//  Consolidate
//
//  Created by Conrad Koh on 8/4/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
public class VideoURLPath{
    private var _value:String;
    public init(string:String){
        _value = string;
    }
    
    public func normalized() -> String?{
        return Normalize(_value);
    }
    
    private func Normalize(input:String) -> String?{
        let input_checked = input.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
        let tokens = input_checked.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
        if(tokens.count > 0){
            let url_seed = tokens[0];
            let zeroPathRng = url_seed.rangeOfString(Constants.REGEX_ZERO_PATH, options: .RegularExpressionSearch);
            if(zeroPathRng == nil){
                return url_seed;
            }
            else{
                let prefix = url_seed.substringToIndex(zeroPathRng!.startIndex);
                let suffix = url_seed.substringFromIndex(zeroPathRng!.endIndex);
                let result = prefix + suffix;
                return Normalize(result);
            }
        }
        return nil;
    }
    
    public class Constants{
        public static let REGEX_ZERO_PATH = "(?<=\\/)[^\\/]+\\/\\.\\.\\/";
    }
}
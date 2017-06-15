//
//  VideoURLPath.swift
//  Consolidate
//
//  Created by Conrad Koh on 8/4/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
open class VideoURLPath{
    fileprivate var _value:String;
    public init(string:String){
        _value = string;
    }
    
    open func normalized() -> String?{
        return Normalize(_value);
    }
    
    fileprivate func Normalize(_ input:String) -> String?{
        let input_checked = input.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
        let tokens = input_checked.components(separatedBy: CharacterSet.whitespacesAndNewlines);
        if(tokens.count > 0){
            let url_seed = tokens[0];
            let zeroPathRng = url_seed.range(of: Constants.REGEX_ZERO_PATH, options: .regularExpression);
            if(zeroPathRng == nil){
                return url_seed;
            }
            else{
                let prefix = url_seed.substring(to: zeroPathRng!.lowerBound);
                let suffix = url_seed.substring(from: zeroPathRng!.upperBound);
                let result = prefix + suffix;
                return Normalize(result);
            }
        }
        return nil;
    }
    
    open class Constants{
        open static let REGEX_ZERO_PATH = "(?<=\\/)[^\\/]+\\/\\.\\.\\/";
    }
}

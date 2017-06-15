//
//  String.swift
//  Consolidate
//
//  Created by Conrad Koh on 24/3/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
extension String{
    
    public func componentsSeparatedByAnyOf(_ delimiters:[String]) -> [String]{
        let array_size = delimiters.count;
        var result = [String]();
        if(array_size == 1){
            let curDelimiter = delimiters[0];
            let tokens = self.components(separatedBy: curDelimiter);
            return tokens;
        }
        else if(array_size > 1){
            let curDelimiter = delimiters[0];
            let curTokens = self.components(separatedBy: curDelimiter);
            
            let remainingDelimiters = Array(delimiters[1..<array_size]);
            for curToken in curTokens{
                let nxtTokens = curToken.componentsSeparatedByAnyOf(remainingDelimiters);
                result.append(contentsOf: nxtTokens);
            }
            return result;
        }
        else{
            return [String]();
        }
    }
    
    public func componentsMatchingRegex(_ regularExpressionPattern:String) -> [String]{
        
        var result = [String]();
        
        do{
            let regex = try NSRegularExpression.init(pattern: regularExpressionPattern, options: []);
            let matches = regex.matches(in: self, options: [], range: NSMakeRange(0, self.characters.count));
            for match in matches{
                let nsstr = NSString.init(string: self);
                let match_string = nsstr.substring(with: match.range);
                result.append(match_string);
            };
        }
        catch{
            
        }
        return result;
    }
    
    fileprivate func separate(_ input:[String], delimiters:[String]) -> [String]{
        var output = [String]();
        for input_str in input{
            for delimiter in delimiters{
                let tokens = input_str.components(separatedBy: delimiter);
                output.append(contentsOf: tokens);
            }
        }
        return output;
    }
    fileprivate struct Constants{
        
    }
}

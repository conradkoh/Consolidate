//
//  String.swift
//  Consolidate
//
//  Created by Conrad Koh on 24/3/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
extension String{
//    public func action() -> Actionable{
//        let value:String = self;
//        let tokens = value.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
//        let cmd = tokens[0];
//        if(cmd == "/search"){
//        }
//        
//        return Command();
//    }
//    public func getType() -> Parser.ACTIONTYPE{
//        let value:String = self;
//        let tokens = value.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
//        return Parser.ACTIONTYPE.COMMAND;
//    }
    public func componentsSeparatedByAnyOf(delimiters:[String]) -> [String]{
        let array_size = delimiters.count;
        var result = [String]();
        if(array_size == 1){
            let curDelimiter = delimiters[0];
            let tokens = self.componentsSeparatedByString(curDelimiter);
            return tokens;
        }
        else if(array_size > 1){
            let curDelimiter = delimiters[0];
            let curTokens = self.componentsSeparatedByString(curDelimiter);
            
            let remainingDelimiters = Array(delimiters[1..<array_size]);
            for curToken in curTokens{
                let nxtTokens = curToken.componentsSeparatedByAnyOf(remainingDelimiters);
                result.appendContentsOf(nxtTokens);
            }
            return result;
        }
        else{
            return [String]();
        }
    }
    
    public func componentsMatchingRegex(regularExpressionPattern:String) -> [String]{
        
        var result = [String]();
        
        do{
            let regex = try NSRegularExpression.init(pattern: regularExpressionPattern, options: []);
            let matches = regex.matchesInString(self, options: [], range: NSMakeRange(0, self.characters.count));
            for match in matches{
                let nsstr = NSString.init(string: self);
                let match_string = nsstr.substringWithRange(match.range);
                result.append(match_string);
            };
        }
        catch{
            
        }
        return result;
    }
    
    private func separate(input:[String], delimiters:[String]) -> [String]{
        var output = [String]();
        for input_str in input{
            for delimiter in delimiters{
                let tokens = input_str.componentsSeparatedByString(delimiter);
                output.appendContentsOf(tokens);
            }
        }
        return output;
    }
    private struct Constants{
        
    }
}
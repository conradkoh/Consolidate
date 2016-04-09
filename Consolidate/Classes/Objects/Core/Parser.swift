//
//  Parser.swift
//  Consolidate
//
//  Created by Conrad Koh on 19/2/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
public class Parser{
    //==============================================
    //Static Variables
    //==============================================
    public static let singleton:Parser = Parser();;
    
    //==============================================
    //Constructors
    //==============================================
    private init(){
        
    }
    
    //==============================================
    //Static Functions
    //==============================================
    public static func Normalize(query:String) -> String{
        let checkedQuery = query.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
        let tokens = checkedQuery.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
        if(tokens.count > 0){
            let result = tokens[0];
            return result;
        }
        return "";
        
    }
    public static func actionFromQuery(query:String) -> Actionable{
        let checkedQuery = query.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
        let actionType = self.RetrieveActionType(checkedQuery);
        var action:Actionable = BusSearch.singleton;
        switch(actionType){
        case Definitions.ACTIONTYPE.BUS:
            let search = BusSearch.singleton;
            search.query = checkedQuery;
            action = search;
            break;
        case Definitions.ACTIONTYPE.VIDEO:
            let videoSearch = VideoSearch.singleton;
            let cmdRange = checkedQuery.rangeOfString(Definitions.Commands.VIDEO);
            let args = checkedQuery.substringFromIndex((cmdRange?.endIndex)!);
            videoSearch.query = args;
            action = videoSearch;
            break;
        case Definitions.ACTIONTYPE.OPEN:
            let open = Open.singleton;
            let cmdRange = checkedQuery.rangeOfString(Definitions.Commands.OPEN);
            let args = checkedQuery.substringFromIndex((cmdRange?.endIndex)!);
            open.path = args;
            action = open;
            break;
            
        case Definitions.ACTIONTYPE.HOME:
            let home = Home();
            action = home;
            break;
            
        default:
            break;
            
        }
        
        return action;
    }
    
    
    public static func actionFromCommand(command:String) -> Actionable{
        let checkedQuery = command.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
        let actionType = self.RetrieveActionType(checkedQuery);
        var action:Actionable = BusSearch.singleton;
        switch(actionType){
//        case Definitions.ACTIONTYPE.BUS:
//            let search = BusSearch.singleton;
//            search.query = checkedQuery;
//            action = search;
//            break;
        case Definitions.ACTIONTYPE.VIDEO:
            let videoSearch = VideoSearch.singleton;
            let cmdRange = checkedQuery.rangeOfString(Definitions.Commands.VIDEO);
            let args = checkedQuery.substringFromIndex((cmdRange?.endIndex)!);
            videoSearch.query = args;
            action = videoSearch;
            break;
        case Definitions.ACTIONTYPE.OPEN:
            let open = Open.singleton;
            let cmdRange = checkedQuery.rangeOfString(Definitions.Commands.OPEN);
            let args = checkedQuery.substringFromIndex((cmdRange?.endIndex)!);
            open.path = args;
            action = open;
            break;
            
        case Definitions.ACTIONTYPE.PING:
            let ping = Ping();
            let cmdRange = checkedQuery.rangeOfString(Definitions.Commands.PING);
            let args = checkedQuery.substringFromIndex((cmdRange?.endIndex)!);
            ping.ip = args;
            action = ping;
            break;
            
        case Definitions.ACTIONTYPE.HOME:
            let home = Home();
            action = home;
            break;
            
        default:
            break;
            
        }
        
        return action;
    }
    
    public static func RetrieveActionType(input:String) ->Definitions.ACTIONTYPE{
        let busRng = input.rangeOfString(Constants.REGEX_BUS, options: .RegularExpressionSearch);
        if(busRng?.startIndex == input.startIndex){
            return Definitions.ACTIONTYPE.BUS;
        }
        let videoRng = input.rangeOfString(Definitions.Commands.VIDEO);
        if(videoRng?.startIndex == input.startIndex){
            return Definitions.ACTIONTYPE.VIDEO;
        }
        
        let openRng = input.rangeOfString(Definitions.Commands.OPEN);
        if(openRng?.startIndex == input.startIndex){
            return Definitions.ACTIONTYPE.OPEN;
        }
        
        let pingRng = input.rangeOfString(Definitions.Commands.PING);
        if(pingRng?.startIndex == input.startIndex){
            return Definitions.ACTIONTYPE.PING;
        }
        
        let homeRng = input.rangeOfString(Definitions.Commands.HOME);
        if(homeRng?.startIndex == input.startIndex){
            return Definitions.ACTIONTYPE.HOME;
        }
        return Definitions.ACTIONTYPE.BUS;
    }
    
    //==============================================
    //Public Functions
    //==============================================
    
    
    
    
    
    //==============================================
    //Private Functions
    //==============================================
    
    
    
    public class Constants{
        public static let REGEX_BUS = "[0-9][0-9][0-9][0-9][0-9]";
    }
}
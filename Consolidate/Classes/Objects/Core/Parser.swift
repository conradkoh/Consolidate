//
//  Parser.swift
//  Consolidate
//
//  Created by Conrad Koh on 19/2/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
open class Parser{
    //==============================================
    //Static Variables
    //==============================================
    open static let singleton:Parser = Parser();
    
    //==============================================
    //Constructors
    //==============================================
    fileprivate init(){
        
    }
    
    //==============================================
    //Static Functions
    //==============================================
    
    open static func actionFromQuery(_ query:String) -> Actionable{
        let checkedQuery = query.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
        let queryType = self.RetrieveQueryType(checkedQuery);
        var action:Actionable = BusSearch.singleton;
        switch(queryType){
        case Definitions.QUERYTYPE.bus:
            let search = BusSearch.singleton;
            search.query = checkedQuery;
            action = search;
            break;
        case Definitions.QUERYTYPE.video:
            let videoSearch = VideoSearch.singleton;
            let cmdRange = checkedQuery.range(of: Definitions.Commands.VIDEO);
            let args = checkedQuery.substring(from: (cmdRange?.upperBound)!);
            videoSearch.query = args;
            action = videoSearch;
            break;
            
        case Definitions.QUERYTYPE.home:
            let home = Home();
            action = home;
            break;
            
        case Definitions.QUERYTYPE.jira:
            let jira = JiraSearch()
            action = jira;
            break;
            
        default:
            break;
            
        }
        
        return action;
    }
    
    open static func actionFromCommand(_ command:String, index:Int) -> Actionable{
        let checkedCommand = command.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines);
        let commandType = self.RetrieveCommandType(checkedCommand);
        var action:Actionable = BusSearch.singleton;
        switch(commandType){
//        case Definitions.ACTIONTYPE.BUS:
//            let search = BusSearch.singleton;
//            search.query = checkedQuery;
//            action = search;
//            break;
        case Definitions.COMMANDTYPE.video:
            let videoSearch = VideoSearch.singleton;
            let cmdRange = checkedCommand.range(of: Definitions.Commands.VIDEO);
            let args = checkedCommand.substring(from: (cmdRange?.upperBound)!);
            videoSearch.query = args;
            action = videoSearch;
            break;
        case Definitions.COMMANDTYPE.open:
            let open = Open.singleton;
            let cmdRange = checkedCommand.range(of: Definitions.Commands.OPEN);
            let args = checkedCommand.substring(from: (cmdRange?.upperBound)!);
            open.path = args;
            action = open;
            break;
            
        case Definitions.COMMANDTYPE.ping:
            let ping = Ping();
            let cmdRange = checkedCommand.range(of: Definitions.Commands.PING);
            let args = checkedCommand.substring(from: (cmdRange?.upperBound)!);
            ping.ip = args;
            action = ping;
            break;
            
        case Definitions.COMMANDTYPE.home:
            let home = Home();
            action = home;
            break;
            
        case Definitions.COMMANDTYPE.summarize:
            let summarize = Summarize();
            summarize.tableViewItemIndex = index;
            action = summarize;
            break;
        default:
            break;
            
        }
        
        return action;
    }
    
    open static func RetrieveQueryType(_ input:String) ->Definitions.QUERYTYPE{
        let busRng = input.range(of: Constants.REGEX_BUS, options: .regularExpression);
        if(busRng?.lowerBound == input.startIndex){
            return Definitions.QUERYTYPE.bus;
        }
        
        let jiraRng = input.range(of: Constants.REGEX_JIRA, options: .regularExpression);
        if(jiraRng?.lowerBound == input.startIndex){
            return Definitions.QUERYTYPE.jira;
        }
        
        let videoRng = input.range(of: Definitions.Commands.VIDEO);
        if(videoRng?.lowerBound == input.startIndex){
            return Definitions.QUERYTYPE.video;
        }
                
        let homeRng = input.range(of: Definitions.Commands.HOME);
        if(homeRng?.lowerBound == input.startIndex){
            return Definitions.QUERYTYPE.home;
        }
        return Definitions.QUERYTYPE.bus;
    }
    
    
    open static func RetrieveCommandType(_ input:String) ->Definitions.COMMANDTYPE{
        let busRng = input.range(of: Constants.REGEX_BUS, options: .regularExpression);
        if(busRng?.lowerBound == input.startIndex){
            return Definitions.COMMANDTYPE.bus;
        }
        let videoRng = input.range(of: Definitions.Commands.VIDEO);
        if(videoRng?.lowerBound == input.startIndex){
            return Definitions.COMMANDTYPE.video;
        }
        
        let openRng = input.range(of: Definitions.Commands.OPEN);
        if(openRng?.lowerBound == input.startIndex){
            return Definitions.COMMANDTYPE.open;
        }
        
        let pingRng = input.range(of: Definitions.Commands.PING);
        if(pingRng?.lowerBound == input.startIndex){
            return Definitions.COMMANDTYPE.ping;
        }
        
        let homeRng = input.range(of: Definitions.Commands.HOME);
        if(homeRng?.lowerBound == input.startIndex){
            return Definitions.COMMANDTYPE.home;
        }
        
        let summarizeRng = input.range(of: Definitions.Commands.SUMMARIZE);
        if(summarizeRng?.lowerBound == input.startIndex){
            return Definitions.COMMANDTYPE.summarize;
        }
        return Definitions.COMMANDTYPE.bus;
    }

    //==============================================
    //Public Functions
    //==============================================
    
    
    
    
    
    //==============================================
    //Private Functions
    //==============================================
    
    
    
    open class Constants{
        open static let REGEX_BUS = "[0-9][0-9][0-9][0-9][0-9]";
        open static let REGEX_JIRA = "jira:";
    }
}

//
//  ViewTypes.swift
//  Consolidate
//
//  Created by Conrad Koh on 7/4/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
open class Definitions{
    open static let AVPLAYER_FILE_FORMATS = [".mp4",".mp3",".avi"];
    
    open class Commands{
        open static let VIDEO = "$video:";
        open static let OPEN = "$open:";
        open static let HOME = "$home:";
        open static let PING = "$ping:";
        open static let JIRA = "$jira:";
        open static let SUMMARIZE = "$summarize";
    }
    
    
    
    public enum ACTIONTYPE{
        case command;
        case query;
    }
    public enum COMMANDTYPE{
        case video;
        case bus;
        case open;
        case home;
        case ping;
        case summarize;
        case invalid;
    };
    
    public enum QUERYTYPE{
        case video;
        case bus;
        case home;
        case invalid;
        case jira;
    };
}

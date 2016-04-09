//
//  ViewTypes.swift
//  Consolidate
//
//  Created by Conrad Koh on 7/4/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
public class Definitions{
//    public class ViewTypes{
//        //View types determines the expected type of action for selecting a specific item in the view
//        public static let ACTION = "action";
//        public static let SUMMARY = "summary";
//    }
    
    public class Commands{
        public static let VIDEO = "$video:";
        public static let OPEN = "$open:";
        public static let HOME = "$home:";
        public static let PING = "$ping:";
    }
    
    public enum ACTIONTYPE{
        case VIDEO;
        case BUS;
        case OPEN;
        case HOME;
        case PING;
        case INVALID;
    };
}
//
//  Explore.swift
//  Consolidate
//
//  Created by Conrad Koh on 29/3/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
public protocol Explorable{
    var title:String?{get set};
    var detail:String?{get set};
    var summary:String?{get set};
    var command:String?{get set};
}
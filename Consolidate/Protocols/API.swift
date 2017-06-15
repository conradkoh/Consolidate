//
//  API.swift
//  Consolidate
//
//  Created by Conrad Koh on 24/3/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
public protocol APIDelegate{
    func QueryResponse(_ data:Data);
}
public protocol API{
    var delegate:APIDelegate?{get set};
    func Query(_ query:String);
}

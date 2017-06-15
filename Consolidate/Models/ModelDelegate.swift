//
//  ModelDelegate.swift
//  Consolidate
//
//  Created by Conrad Koh on 9/4/16.
//  Copyright © 2016 ConradKoh. All rights reserved.
//

import Foundation
public protocol ModelDelegate{
    func PresentSafariViewController(_ url:URL);
    func PresentSummaryViewController(_ tableViewItem:TableViewItem?);
    
    //Opening specific file extensions
    func OpenMP4(_ url:URL);
}

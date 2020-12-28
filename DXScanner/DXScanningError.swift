//
//  DXScanningError.swift
//  DXScanner
//
//  Created by Deepak Singh on 09/10/20.
//

import Foundation

public enum DXScanningErrors : Error{
    case camera_permission(code : String, reason : String)
    case scanningSupport(code : String, reason: String)
}


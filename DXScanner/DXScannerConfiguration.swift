//
//  DXScannerConfiguration.swift
//  DXScanner
//
//  Created by Deepak Singh on 28/12/20.
//

import Foundation

enum DXScanningType {
    case Single
    case Multiple
}


enum DXScannerTypes {
    case BarCode
    case QRCode
}

struct DXScannerConfig {
    var scanningType : DXScanningType = .Single
    var scannerTypes : [DXScannerTypes] = [.QRCode, .BarCode]
    
    mutating func setSacnningType( type: DXScanningType){
        self.scanningType = type
    }
    
    mutating func setScannerTypes( types: [DXScannerTypes]){
        self.scannerTypes = types
    }
    
    
}

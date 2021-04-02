//
//  ScannerView.swift
//  DXscannerDemo (iOS)
//
//  Created by Vivek Singh on 02/04/21.
//

import Foundation
import SwiftUI
import DXScanner

struct ScannerView : UIViewRepresentable{
    var rect = CGRect(x: 10, y: 10, width: 200 , height: 300)
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func startScan()
    {
        
    }
    
    func makeUIView(context: Context) -> some UIView {
        return DXScannerView(frame: rect)
    }
}

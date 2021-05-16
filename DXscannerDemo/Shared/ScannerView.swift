//
//  ScannerView.swift
//  DXscannerDemo (iOS)
//
//  Created by Vivek Singh on 02/04/21.
//

import Foundation
import SwiftUI
import DXScanner

struct ScannerView: UIViewRepresentable {

    var rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 400, height: 400))
    func updateUIView(_ uiView: UIViewType, context: Context) {}

    func startScan() {}

    func makeUIView(context: Context) -> some UIView {
        return DXScannerView(frame: rect)
    }
}

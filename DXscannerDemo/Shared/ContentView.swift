//
//  ContentView.swift
//  Shared
//
//  Created by Vivek Singh on 02/04/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader{ metric in
            ScannerView(rect: CGRect(x: 0, y: 0, width: metric.size.width , height: metric.size.height))
        }
    }
}

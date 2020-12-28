//
//  DXScannerView.swift
//  DXScanner
//
//  Created by Deepak Singh on 09/10/20.
//

import UIKit

class DXScannerView : UIView {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup(){
        //setup the Camera / AVCapturePreiew layer
    }
    
    
}

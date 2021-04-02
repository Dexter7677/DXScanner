//
//  DXScannerView.swift
//  DXScanner
//
//  Created by Deepak Singh on 09/10/20.
//

import UIKit
import AVFoundation

public class DXScannerView : UIView {
    
    var captureSession = AVCaptureSession()
    
    
    public override class var layerClass: AnyClass{
        return AVCaptureVideoPreviewLayer.self
    }
    
    var previewLayer : AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup(){
        /*
         1. Setup Session
         2. Setup input device
         3. Setup output
         */
        checkForAuth()
        
        
        
    }
    
    private func setupCaptureSession(){
        captureSession.beginConfiguration()
        //configuring Input for session
        let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .unspecified)
        guard let input = try? AVCaptureDeviceInput(device: device!), captureSession.canAddInput(input) else{
            return
        }
        captureSession.addInput(input)
        
        //configuring Output
        let outPut = AVCaptureVideoDataOutput()
        guard captureSession.canAddOutput(outPut) else {
            return
        }
        captureSession.addOutput(outPut)
        captureSession.commitConfiguration()
        
        self.previewLayer.session = captureSession
        self.startScanner()
    }
    
    private func checkForAuth(){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .authorized:
            self.setupCaptureSession()
        case .denied:
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                if status{
                    self.setupCaptureSession()
                }else{
                    print("User did not gave access")
                }
            }
        case .restricted:
            return
        @unknown default:
            return
        }
    }
    
    func startScanner(){
        self.captureSession.startRunning()
    }
    
    func stopScanning(){
        self.captureSession.stopRunning()
    }
    
    
    
    
    
    
    
    
}

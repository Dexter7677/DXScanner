//
//  DXScannerView.swift
//  DXScanner
//
//  Created by Deepak Singh on 09/10/20.
//

import UIKit
import AVFoundation
import Vision

public class DXScannerView : UIView {
    
    var captureSession = AVCaptureSession()
    lazy var visionRequest = VNDetectBarcodesRequest { request , error in
        guard error == nil else{
            self.showAlert(title: "BarCode error", message: error.debugDescription)
            return
        }
        self.processClassification(request)
        
    }
    
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
    
    private func showAlert(title: String, message: String){
        print("Found barcode")
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
        outPut.videoSettings =
            [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
        outPut.setSampleBufferDelegate(
            self,
            queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default))
        
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
    
    func processClassification(_ request : VNRequest){
        guard let barcodes = request.results else { return }
        DispatchQueue.main.async { [self] in
            if captureSession.isRunning {
                self.layer.sublayers?.removeSubrange(1...)
                
                // 2
                for barcode in barcodes {
                    guard
                        let potentialQRCode = barcode as? VNBarcodeObservation
                    else { return }
                    self.showAlert(title: potentialQRCode.symbology.rawValue, message: potentialQRCode.payloadStringValue ?? "")
                }
            }
        }
        
    }
}

extension DXScannerView : AVCaptureVideoDataOutputSampleBufferDelegate{
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        let imageRequestHandler = VNImageRequestHandler(
            cvPixelBuffer: pixelBuffer,
            orientation: .right)
        do {
            try imageRequestHandler.perform([visionRequest])
        } catch {
            print(error)
        }
    }
}

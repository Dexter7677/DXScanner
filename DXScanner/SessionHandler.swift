//
//  SessionHandler.swift
//  DXScanner
//
//  Created by Deepak on 14/05/21.
//

import Foundation
import AVFoundation

class SessionHanlder: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    var captureSession = AVCaptureSession()
    var visionService = VisionService()
    override init() {
        super.init()
    }

    private func deviceDiscovery(){
        
    }
    
   internal func setupCaptureSession(sessionConfiguration: CaptureSessinConfiguration) -> AVCaptureSession? {
        captureSession.beginConfiguration()
//         configuring Input for session
        let device = AVCaptureDevice.default(sessionConfiguration.deviceType,
                                             for: sessionConfiguration.mediaType,
                                             position: sessionConfiguration.position)
        guard let input = try? AVCaptureDeviceInput(device: device!), captureSession.canAddInput(input) else {
            return nil
        }
        captureSession.addInput(input)

//         configuring Output
        let outPut = AVCaptureVideoDataOutput()
        guard captureSession.canAddOutput(outPut) else {
            return nil
        }
        outPut.videoSettings =
            [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
        outPut.setSampleBufferDelegate(
            self,
            queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default))

        captureSession.addOutput(outPut)
        captureSession.commitConfiguration()
        return self.captureSession
    }

    public func captureOutput(_ output: AVCaptureOutput,
                              didOutput sampleBuffer: CMSampleBuffer,
                              from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        visionService.processRequest(pixelBuffer: pixelBuffer, orientation: .right)
    }
}

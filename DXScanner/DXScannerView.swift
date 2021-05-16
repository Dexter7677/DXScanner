//
//  DXScannerView.swift
//  DXScanner
//
//  Created by Deepak Singh on 09/10/20.
//

import UIKit
import AVFoundation

public class DXScannerView: UIView {

    var captureSession = AVCaptureSession()
    var sessionManager = SessionHanlder()

    public override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self

    }
    var previewLayer: AVCaptureVideoPreviewLayer?
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {

        //        Prepare Preview Layer
        guard let newlayer = self.layer as? AVCaptureVideoPreviewLayer else {
            return
        }
        previewLayer = newlayer
        previewLayer?.videoGravity = .resizeAspect
        previewLayer?.frame = self.bounds
        self.frame = bounds
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        //      Check for permission
        let permissionManager = PermissionManager()
        permissionManager.checkForAuth { status in
            if status {
                // setup session
                let sessionConfig = CaptureSessinConfiguration(deviceType: .builtInWideAngleCamera,
                                                               mediaType: .video,
                                                               position: .unspecified)
                guard let session = self.sessionManager.setupCaptureSession(sessionConfiguration: sessionConfig) else {
                    return
                }
                self.captureSession = session
                self.previewLayer?.session = self.captureSession
            }
        }
    }

    public func startScanner() {
        self.captureSession.startRunning()
    }

    public func stopScanning() {
        self.captureSession.stopRunning()
    }
}

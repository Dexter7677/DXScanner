//
//  CaptureSessionConfiguration.swift
//  DXScanner
//
//  Created by Deepak on 15/05/21.
//

import Foundation
import AVFoundation

struct CaptureSessinConfiguration {
    let deviceType: AVCaptureDevice.DeviceType
    let mediaType: AVMediaType
    let position: AVCaptureDevice.Position
}

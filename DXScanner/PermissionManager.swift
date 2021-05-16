//
//  PermissionManager.swift
//  DXScanner
//
//  Created by Deepak on 14/05/21.
//

import Foundation
import AVFoundation

//TODO: Handle dynamic permission change
struct PermissionManager {
    
    func checkForAuth( handler : @escaping(Bool) -> Void) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            debugPrint("PermissionManager : Authorized")
            handler(true)
        case .denied:
            debugPrint("PermissionManager : denied")
            handler(false)
        case .notDetermined:
            requestAccess(handler: handler)
        case .restricted:
            debugPrint("PermissionManager : restricted" )
            handler(false)
        @unknown default:
            debugPrint("PermissionManager : declined default")
            handler(false)
        }
    }
}

    private func requestAccess(handler :@escaping(Bool) -> Void) {
    AVCaptureDevice.requestAccess(for: .video) { (status) in
        if status {
            debugPrint("PermissionManager : Authorized after alert")
            handler(true)
        } else {
            // user declined
            debugPrint("PermissionManager : denied after alert")
            handler(false)
        }
    }
}

// MARK: To be implemented
    private func requestSettingsUpdate(handler :@escaping(Bool) -> Void) {

    }

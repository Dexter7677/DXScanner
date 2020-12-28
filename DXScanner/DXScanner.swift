//
//  DXScanner.swift
//  DXScanner
//
//  Created by Deepak Singh on 02/10/20.
//

import Foundation
import AVFoundation

public class DXScanner{
    
    
    public func startScan(){
        //open camera for scanning
        print("Sacanning Called")
        isAuthorised { (status) in
            //startScan
            print("status: \(status)")
        }
    }
    
    public func stopScan(){
        
    }
    
    private func isAuthorised( completion:@escaping (Bool) -> Void){
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (granted) in
                if granted{
                    completion(true)
                }else{
                    completion(false)
                }
            }
            break
        case .restricted:
            completion(false)
            break
        case .denied:
            completion(false)
            break
        case .authorized:
            completion(true)
            break
        @unknown default:
            completion(true)
            break
        }
    }
    
    public init(){
        
    }
}


//
//  VisionHandler.swift
//  DXScanner
//
//  Created by Deepak on 15/05/21.
//

import Foundation
import Vision

class VisionService {

    lazy var visionRequest = VNDetectBarcodesRequest { request, error in
        guard error == nil else {
//            invalid QR/bar code
            debugPrint("Invalid barcode")
            return
        }
        self.processClassification(request)
    }

    internal func processRequest(pixelBuffer: CVPixelBuffer, orientation: CGImagePropertyOrientation){
        let requestHandler = VNImageRequestHandler(
            cvPixelBuffer: pixelBuffer)
        do {
            try requestHandler.perform([visionRequest])
        } catch {
            print(error)
        }
    }

   private func processClassification(_ request: VNRequest) {
        guard let barcodes = request.results else { return }
        for barcode in barcodes {
            guard
                let potentialQRCode = barcode as? VNBarcodeObservation,
                potentialQRCode.confidence > 0.9
            else { return }

            let symbology = potentialQRCode.symbology.rawValue
            let value = potentialQRCode.payloadStringValue ?? ""
            debugPrint("Got value \(symbology) v : \(value)")
        }
    }

}

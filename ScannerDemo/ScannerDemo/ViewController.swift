//
//  ViewController.swift
//  ScannerDemo
//
//  Created by Deepak on 15/05/21.
//

import UIKit
import DXScanner
class ViewController: UIViewController {

    @IBOutlet weak var scannerView: DXScannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func startScanning(_ sender: Any) {
        scannerView.startScanner()
    }
    
    @IBAction func stopScanning(_ sender: Any) {
        scannerView.stopScanning()
    }
    
}


//
//  QRCodeReaderViewController.swift
//  nkoodi
//
//  Created by Shimaa Magdi on 8/1/18.
//  Copyright © 2018 Hajj Hackathon. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeReaderViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var viewPreview: UIView!
    var captureSession: AVCaptureSession?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var isReading: Bool = false
    var qrReadingCompletion: ((String)->())?
    
    public static func create() -> QRCodeReaderViewController {
        return UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: String(describing: self)) as! QRCodeReaderViewController
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewPreview.layer.cornerRadius = 5;
        captureSession = nil;
//        lblString.text = "Barcode description...";
        start()
    }
    
    func start(){
        if !isReading {
            if (self.startReading()) {
//                lblString.text = "Scanning for QR Code..."
            }
        }
        else {
            stopReading()
        }
        isReading = !isReading
    }
    
    // MARK: - Custom Method
    func startReading() -> Bool {
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            // Do the rest of your work...
        } catch let error as NSError {
            // Handle any errors
            print(error)
            return false
        }
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer.frame = viewPreview.layer.bounds
        viewPreview.layer.addSublayer(videoPreviewLayer)
        
        /* Check for metadata */
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        captureMetadataOutput.metadataObjectTypes = captureMetadataOutput.availableMetadataObjectTypes
        print(captureMetadataOutput.availableMetadataObjectTypes)
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureSession?.startRunning()
        
        return true
    }
    func stopReading() {
        captureSession?.stopRunning()
        captureSession = nil
        videoPreviewLayer.removeFromSuperlayer()
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        for data in metadataObjects {
            let metaData = data as! AVMetadataObject
            print(metaData.description)
            let transformed = videoPreviewLayer?.transformedMetadataObject(for: metaData) as? AVMetadataMachineReadableCodeObject
            if let unwraped = transformed {
                self.performSelector(onMainThread: #selector(stopReading), with: nil, waitUntilDone: false)
                isReading = false;
                self.dismiss(animated: true, completion: {
                    self.qrReadingCompletion?(unwraped.stringValue)
                })
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}






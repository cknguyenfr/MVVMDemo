//
//  ViewController.swift
//  facedetectDemov1
//
//  Created by Can Khac Nguyen on 8/13/18.
//  Copyright © 2018 Can Khac Nguyen. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {

    @IBOutlet weak var imvDisplay: UIImageView!
    private var requests = [VNRequest]()
    var imagePicker =  UIImagePickerController()
    var faceDetectionRequest: VNRequest!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        faceDetectionRequest = VNDetectFaceRectanglesRequest(completionHandler: handleFaces)
        let newImage = fixOrientation()
    }
    
    func handleFaces(request: VNRequest, error: Error?) {
        DispatchQueue.main.async {
            //perform all the UI updates on the main queue
            guard let results = request.results as? [VNFaceObservation] else { return }
            print("face count = \(results.count) ")
            self.previewView.removeMask()
            
            for face in results {
                self.previewView.drawFaceboundingBox(face: face)
            }
        }
    }

    @IBAction func btnCameraClicked(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnLibraryClicked(_ sender: UIButton) {
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imvDisplay.image = pickedImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Cancel")
    }
}

extension UIButton {
    open override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
}

//
//  ViewController.swift
//  WhatFlower
//
//  Created by Suhyoung Eo on 2021/10/23.
//

import UIKit
import CoreML
import Vision
import SDWebImage

class WhatFlowerViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var extractLabel: UILabel!
    
    let imagePicker = UIImagePickerController()
    var flowerDataViewModel: FlowerDataViewModel?
    var flowerName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .camera
    }
    
    func fetchFlowerData(flowerName: String) {
        let url = "\(K.wikipediaURL)&titles=\(flowerName)"
        if let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            FlowerDataManager.shared.performRequest(with: urlString) { result in
                guard let result = result else {
                    DispatchQueue.main.async {
                        AlertService.shared.alert(viewController: self, alertTitle: "정보가 없습니다", message: nil, actionTitle: "확인")
                    }
                    return
                }
                
                self.flowerDataViewModel = FlowerDataViewModel(result)
                
                DispatchQueue.main.async { [self] in
                    navigationItem.title = flowerName
                    extractLabel.text = flowerDataViewModel?.extract
                    imageView.sd_setImage(with: flowerDataViewModel?.thumbnailLink, completed: nil)
                }
            }
        }
    }
}

//MARK: - UIImagePickerControllerDelegate

extension WhatFlowerViewController: UIImagePickerControllerDelegate {
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickerImage = info[.editedImage] as? UIImage {
            guard let ciImage = CIImage(image: userPickerImage) else {
                DispatchQueue.main.async {
                    AlertService.shared.alert(viewController: self, alertTitle: "Could not convert to CIImage", message: nil, actionTitle: "확인")
                }
                return
            }
            
            detect(image: ciImage)
            
            if let name = flowerName {
                fetchFlowerData(flowerName: name)
            }
            
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func detect(image: CIImage) {
        
        // 해당 부분에서 *.mlmodel을 load함 - 사용 모델: FlowerClassifier.mlmodel
        guard let model = try? VNCoreMLModel(for: MLModel(contentsOf: FlowerClassifier.urlOfModelInThisBundle)) else {
            DispatchQueue.main.async {
                AlertService.shared.alert(viewController: self, alertTitle: "Loading CoreML Model Faile", message: nil, actionTitle: "확인")
            }
            return
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            if let results = request.results?.first as? VNClassificationObservation {
                self.flowerName = results.identifier.capitalized
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        } catch {
            DispatchQueue.main.async {
                AlertService.shared.alert(viewController: self, alertTitle: "Somethin wrong handler.perform", message: error.localizedDescription, actionTitle: "확인")
            }
        }
    }
}

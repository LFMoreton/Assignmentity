//
//  OCRViewController.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 08/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import Vision
import VisionKit

class OCRViewController: UIViewController {
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        
        return stackView
    }()
    
    lazy var scanButton: UIButton = {
        let button = UIButton(frame: .zero)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Scan", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 7.0
        button.backgroundColor = .systemIndigo
        
        return button
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(frame: .zero)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 7.0
        button.backgroundColor = .systemGray
        button.isEnabled = false
        
        return button
    }()
    
    lazy var scanImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 7.0
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.systemIndigo.cgColor
        imageView.backgroundColor = .secondarySystemBackground
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var ocrTextView: UITextView = {
        let textView = UITextView(frame: .zero, textContainer: nil)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.cornerRadius = 7.0
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.systemIndigo.cgColor
        textView.textColor = .label
        textView.font = .systemFont(ofSize: 16.0)
        textView.isUserInteractionEnabled = false
        
        return textView
    }()
    
    let manager = CatalogManager()
    var ocrRequest = VNRecognizeTextRequest()
    var itemJson: [String: AnyObject] = [:]
    
    override func loadView() {
        super.loadView()
        
        let view = UIView()
        view.backgroundColor = .systemBackground
        self.view = view
        
        setupView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureOCR()
    }
    
    private func configureOCR() {
        ocrRequest = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            var ocrText = ""
            var confidenceSum: Float = 0
            
            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else { return }
                
                confidenceSum += topCandidate.confidence
                ocrText += topCandidate.string + "\n"
            }
            
            let resizedImage = UIImage.resize(image: self.scanImageView.image, to: 512)
            
            self.itemJson["img"] = resizedImage?.toBase64String() as AnyObject?
            self.itemJson["text"] = ocrText as AnyObject
            self.itemJson["confidence"] = confidenceSum / Float(observations.count) as AnyObject
            
            DispatchQueue.main.async {
                self.ocrTextView.text = ocrText
                self.scanButton.isEnabled = true
                self.saveButton.isEnabled = true
                self.scanButton.backgroundColor = .systemIndigo
                self.saveButton.backgroundColor = .systemIndigo
            }
        }
        
        ocrRequest.recognitionLevel = .accurate
        ocrRequest.recognitionLanguages = [ "en-US", "en-GB" ]
    }
    
    private func processImage(_ image: UIImage) {
        guard let cgImage = image.cgImage else { return }
        
        ocrTextView.text = ""
        scanButton.isEnabled = false
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        do {
            try requestHandler.perform([self.ocrRequest])
        } catch let error {
            presentError(withTitle: "Oops! 😵", message: error.localizedDescription)
        }
    }
    
    @objc private func scanDocument() {
        let scanViewController = VNDocumentCameraViewController()
        scanViewController.delegate = self
        present(scanViewController, animated: true)
    }
    
    @objc private func saveNewItem() {
        manager.addItem(json: self.itemJson) { (item, error) in
            do {
                if let error = error {
                    self.presentError(withTitle: "Oops! 😵", message: error.localizedDescription)
                }
                
                if let newItem = item {
                    UserDefaultsManager.setFirstTime(false)
                    try RealmProvider.save(item: newItem)
                    
                    self.dismiss(animated: true)
                }
            } catch {
                self.presentError(withTitle: "Oops! 😵", message: error.localizedDescription)
            }
        }
    }
}

extension OCRViewController: ViewCodable {
    func buildViewHierarchy() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(scanButton)
        stackView.addArrangedSubview(saveButton)
        
        view.addSubview(scanImageView)
        view.addSubview(ocrTextView)
    }
    
    func setupConstraints() {
        let padding: CGFloat = 16
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            scanButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            
            ocrTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            ocrTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            ocrTextView.bottomAnchor.constraint(equalTo: scanButton.topAnchor, constant: -padding),
            ocrTextView.heightAnchor.constraint(equalToConstant: 200),
            
            scanImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            scanImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            scanImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            scanImageView.bottomAnchor.constraint(equalTo: ocrTextView.topAnchor, constant: -padding)
        ])
        
        scanButton.addTarget(self, action: #selector(scanDocument), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveNewItem), for: .touchUpInside)
    }
    
    func additionalSetup() {
        
    }
}

extension OCRViewController: VNDocumentCameraViewControllerDelegate {
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        guard scan.pageCount >= 1 else {
            controller.dismiss(animated: true)
            return
        }
        
        let image = scan.imageOfPage(at: 0)
        
        scanImageView.image = image
        processImage(image)
        
        controller.dismiss(animated: true)
    }
    
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
        presentError(withTitle: "Oops! 😵", message: error.localizedDescription)
        
        controller.dismiss(animated: true)
    }
    
    func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
        controller.dismiss(animated: true)
    }
}

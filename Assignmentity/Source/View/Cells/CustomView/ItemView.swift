//
//  ItemView.swift
//  Assignmentity
//
//  Created by Lucas Moreton on 07/04/20.
//  Copyright © 2020 Lucas Moreton. All rights reserved.
//

import UIKit

class ItemView: UIView {

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.alignment = .top
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var confidenceLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 4
        image.layer.borderColor = UIColor.systemGray.cgColor
        image.layer.borderWidth = 1.5
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        
        return image
    }()

    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ItemView: ViewCodable {
    public func buildViewHierarchy() {
        addSubview(imageView)
        addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(idLabel)
        mainStackView.addArrangedSubview(confidenceLabel)
        mainStackView.addArrangedSubview(textLabel)
    }

    public func setupConstraints() {
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
        
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.42),
            
            mainStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: padding),
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }

    public func additionalSetup() {
        
    }
}

extension ItemView: Fillable {
    public func fill(data: Any) {
        if let item = data as? Item {
            let firstAttributes: [NSAttributedString.Key: Any] = [ .font : UIFont.boldSystemFont(ofSize: 17) ]
            
            imageView.image = item.imageString.toImage()
            let idAttributedText = NSMutableAttributedString(string: "ID: ", attributes: firstAttributes)
            idAttributedText.append(NSAttributedString(string: item.identifier))
            idLabel.attributedText = idAttributedText
            let confidenceAttributedText = NSMutableAttributedString(string: "Confidence: ", attributes: firstAttributes)
            confidenceAttributedText.append(NSAttributedString(string: String(format: "%.2f", item.confidence)))
            confidenceLabel.attributedText = confidenceAttributedText
            let textAttributedText = NSMutableAttributedString(string: "Text: ", attributes: firstAttributes)
            textAttributedText.append(NSAttributedString(string: item.text))
            textLabel.attributedText = textAttributedText
        }
    }
}

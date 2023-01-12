//
//  ImageLabelBarButton.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/11.
//

import UIKit

import Tabman

class ImageLabelBarButton: TMBarButton {
    // MARK: Defaults
    
    private struct Defaults {
        static let spacing: CGFloat = 4.0
        static let contentInset = UIEdgeInsets(top: 12.0, left: 0.0, bottom: 12.0, right: 0.0)
    }
    
    // MARK: Properties
    
    private let stackView = UIStackView()
    private let label = UILabel()
    private let imageView = UIImageView()
    private var imageName: String?
    
    // MARK: Lifecycle
    
    override func layout(in view: UIView) {
        super.layout(in: view)
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        stackView.spacing = Defaults.spacing
        contentInset = Defaults.contentInset
    }
    
    override func populate(for item: TMBarItemable) {
        super.populate(for: item)
        
        imageView.image = item.image
        imageView.isHidden =  item.image == nil
        
        label.text = item.title
        label.isHidden = item.title == nil
    }
    
    override func update(for selectionState: TMBarButton.SelectionState) {
        if selectionState == .selected {
            UIView.transition(with: self, duration: 0.25, options: .transitionCrossDissolve, animations: {
                self.label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
                self.label.textColor = .black
                self.imageView.setImageColor(color: .black)
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: 0.25, options: .transitionCrossDissolve, animations: {
                self.label.font = UIFont.systemFont(ofSize: 14)
                self.label.textColor = UIColor(named: "Sub2")
                self.imageView.setImageColor(color: UIColor(named: "Sub2") ?? UIColor())
            }, completion: nil)
        }
    }
}

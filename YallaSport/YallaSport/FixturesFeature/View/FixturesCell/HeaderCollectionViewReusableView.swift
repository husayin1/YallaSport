//
//  HeaderCollectionViewReusableView.swift
//  YallaSport
//
//  Created by husayn on 28/04/2024.
//

import UIKit

class HeaderCollectionViewReusableView: UICollectionReusableView {
    // Define your header view's UI components
    let collectionHeader: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Add UI components to the view and set up constraints
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionHeader)
        
        NSLayoutConstraint.activate([
            collectionHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionHeader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collectionHeader.topAnchor.constraint(equalTo: topAnchor),
            collectionHeader.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

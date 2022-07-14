//
//  CustomCell.swift
//  VKProgect
//
//  Created by Дмитрий Голубев on 14.07.2022.
//

import Foundation
import UIKit

final class CustomCell: UITableViewCell{
    lazy var image: UIImageView = {
        image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(image)
        
        return image
    }()
    
    lazy var title: UILabel = {
        title = UILabel()
        
        title.font = UIFont.systemFont(ofSize: 18)
        title.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(title)
        
        return title
    }()
    
    lazy var text: UILabel = {
        text = UILabel()
        text.numberOfLines = 0
        text.font = UIFont.systemFont(ofSize: 14)
        text.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(text)
        
        return text
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpLayout(){
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            image.widthAnchor.constraint(equalToConstant: 72),
            image.heightAnchor.constraint(equalToConstant: 72),
            
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16),
            title.topAnchor.constraint(equalTo: image.topAnchor),
            
            text.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            text.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            text.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32)
        ])
    }
}

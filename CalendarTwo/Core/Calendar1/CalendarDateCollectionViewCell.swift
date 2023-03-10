//
//  CalendarDateCollectionViewCell.swift
//  CalendarTwo
//
//  Created by Samuel Fuentes Navarrete on 05/03/23.
//

import UIKit

class CalendarDateCollectionViewCell: UICollectionViewCell {
    
    
    static let cellReuseIdentifier = String(describing: CalendarDateCollectionViewCell.self)

    
    lazy var dayOfMonth: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .label
        return label
    }()
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .white

        InitComponents()
    }

    
    
    func InitComponents(){
        AddComponets()
        SetLayout()
    }
    
    func AddComponets(){
        
        contentView.addSubview(dayOfMonth)

    }
    
    func SetLayout(){
        
        NSLayoutConstraint.activate([
            
            dayOfMonth.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            dayOfMonth.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
        
        ])
    }
}

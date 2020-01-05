//
//  BaseButton.swift
//  PointFreeFunctions
//
//  Created by 양원석 on 2020/01/06.
//  Copyright © 2020 양원석. All rights reserved.
//

import UIKit

// subclassing

class BaseButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class FilledButton: RoundedButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        tintColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class RoundedButton: BaseButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        layer.cornerRadius = 6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//compose

extension UIButton {
    
    static var base: UIButton {
        let button = UIButton()
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        return button
    }
    
    static var filled: UIButton {
        let button = Self.base
        button.backgroundColor = .black
        button.tintColor = .white
        return button
    }
    
    static var rounded: UIButton {
        let button = Self.filled
        button.clipsToBounds = true
        button.layer.cornerRadius = 6
        return button
    }
    
}

func baseButtonStyle(_ button: UIButton) {
    button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
}

//func filledButtonStyle(_ button: UIButton) {
//    button.backgroundColor = .black
//    button.tintColor = .white
//}
let filledButtonStyle = roundedButtonStyle
    <> {
        $0.backgroundColor = .black
        $0.tintColor = .white
}

//func roundedButtonStyle(_ button: UIButton) {
//    button.clipsToBounds = true
//    button.layer.cornerRadius = 6
//}
let roundedButtonStyle = baseButtonStyle
    <> roundedStyle

let roundedStyle: (UIView) -> Void = {
    $0.clipsToBounds = true
    $0.layer.cornerRadius = 6
}


/// textFields

let baseTextFieldStyle: (UITextField) -> Void = roundedStyle
    <> {
        $0.layer.borderColor = UIColor(white: 0.75, alpha: 1).cgColor
        $0.layer.borderWidth = 1
        $0.borderStyle = .roundedRect
        $0.heightAnchor.constraint(equalToConstant: 44).isActive = true
}

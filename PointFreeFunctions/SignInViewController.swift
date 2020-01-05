//
//  SignInViewController.swift
//  PointFreeFunctions
//
//  Created by 양원석 on 2020/01/06.
//  Copyright © 2020 양원석. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let gradientView = GradientView()
        gradientView |> gradientStyle
        
        let logoImageView = UIImageView(image: UIImage(named: "logo"))
        logoImageView |> implicitAspectRatioStyle
        
        UIButton.appearance() |> baseButtonStyle
        
        let gitHubButton = UIButton(type: .system)
        
        gitHubButton |> githubButtonStyle
            <> {
                $0.setTitle("Sign in with GitHub", for: .normal)
        }
        
        let orLabel = UILabel()
        orLabel |> orLabelStyle
            <> {
                $0.text = "or"
        }
        
        let emailField = UITextField()
        emailField |> emailTextFieldStyle
        
        let passwordField = UITextField()
        passwordField |> passwordTextFieldStyle
        
        let signInButton = UIButton(type: .system)
        signInButton |> borderButtonStyle
            <> {
                $0.setTitle("Sign in", for: .normal)
        }
        
        let forgotPasswordButton = UIButton(type: .system)
        forgotPasswordButton |> textButtonStyle
            <> {
                $0.setTitle("I forgot my password", for: .normal)
        }
        
        let legalLabel = UILabel()
        legalLabel |> finePrintStyle
            <> {
                $0.text = "By signing into Point-Free you agree to our latest terms of use and privacy policy."
        }
        
        let rootStackView = UIStackView(arrangedSubviews: [
            logoImageView,
            gitHubButton,
            orLabel,
            emailField,
            passwordField,
            signInButton,
            forgotPasswordButton,
            legalLabel,
        ])
        
        rootStackView |> rootStackViewStyle
        
        self.view.addSubview(gradientView)
        self.view.addSubview(rootStackView)
        
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: self.view.centerYAnchor),
            
            rootStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
    }
    
}

public final class GradientView: UIView {
    public var fromColor: UIColor = .clear {
        didSet {
            self.updateGradient()
        }
    }
    
    public var toColor: UIColor = .clear {
        didSet {
            self.updateGradient()
        }
    }
    
    private let gradientLayer = CAGradientLayer()
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        self.gradientLayer.locations = [0, 1]
        self.layer.insertSublayer(self.gradientLayer, at: 0)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateGradient() {
        self.gradientLayer.colors = [fromColor.cgColor, toColor.cgColor]
    }
    
    public override func layoutSubviews() {
        self.gradientLayer.frame = self.bounds
    }
}

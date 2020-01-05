//
//  ViewController.swift
//  PointFreeFunctions
//
//  Created by 양원석 on 2019/12/20.
//  Copyright © 2019 양원석. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        moveToSignIn("")
    }


    @IBAction func moveToSignIn(_ sender: Any) {
        navigationController?.show(SignInViewController(), sender: nil)
    }
}


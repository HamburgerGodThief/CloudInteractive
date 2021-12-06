//
//  ViewController.swift
//  CloudInteractive - MVVM
//
//  Created by Hamburger on 2021/12/5.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var requestAPIBtn: UIButton! {
        didSet {
            requestAPIBtn.setTitle("Request API", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.barTintColor = .black
    }

}


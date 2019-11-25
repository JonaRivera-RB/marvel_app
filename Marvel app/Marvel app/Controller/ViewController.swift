//
//  ViewController.swift
//  Marvel app
//
//  Created by Misael Rivera on 24/11/19.
//  Copyright © 2019 Misael Rivera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let heroeAPI = HeroeAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let showLoader = showAlertWithLoadingIndicator(toTittle: "Downloading heroes", toMessage: "wait a moment")
        heroeAPI.getHeroes { (success, error) in
            DispatchQueue.main.async {
                if success {
                    print("todo chido")
                    showLoader.dismiss(animated: true, completion: nil)
                }else {
                    print("!todo no chido")
                    showLoader.dismiss(animated: true, completion: nil)
                }
            }
            
        }
        // Do any additional setup after loading the view.
    }
    
    
}


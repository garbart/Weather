//
//  ViewController.swift
//  Weather
//
//  Created by Artem Garbart on 27.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelsLikeTempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func searchButtonPressed(_ sender: Any) {
    }
    
}


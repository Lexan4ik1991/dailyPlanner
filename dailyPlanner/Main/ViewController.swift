//
//  ViewController.swift
//  dailyPlanner
//
//  Created by 123 on 10.01.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBar")
        self.navigationController?.pushViewController(vc, animated: false)
    }



}


//
//  ViewController.swift
//  HelloRxSwift
//
//  Created by 山本響 on 2022/03/09.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = Observable.from([1, 2, 3, 4, 5])
    }


}


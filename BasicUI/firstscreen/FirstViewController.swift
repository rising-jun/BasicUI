//
//  FirstViewController.swift
//  BasicUI
//
//  Created by 김동준 on 2021/03/15.
//

import UIKit
import SnapKit
import RxSwift

class FirstViewController: BaseViewController {

    lazy var firstView = FirstView(frame: view.frame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = firstView
        // Do any additional setup after loading the view.
        
        
        
    }


}


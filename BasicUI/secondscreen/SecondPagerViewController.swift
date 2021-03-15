//
//  SecondPagerViewController.swift
//  BasicUI
//
//  Created by 김동준 on 2021/03/15.
//

import Foundation
import UIKit
import RxSwift

class SecondPagerViewController: BaseViewController{
    
    lazy var secondViewPager = SecondViewPager(frame: view.frame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = secondViewPager
        
        
        
    }
    
}

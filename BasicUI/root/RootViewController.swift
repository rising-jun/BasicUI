//
//  ViewController.swift
//  BasicUI
//
//  Created by 김동준 on 2021/03/12.
//

import UIKit
import SnapKit
import RxSwift

class RootViewController: UITabBarController {

    let firstVC = FirstViewController()
    let secondVC = SecondPagerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addChild(firstVC)
        firstVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(), tag: 0)
        
        addChild(secondVC)
        secondVC.tabBarItem = UITabBarItem(title: "뉴스화면", image: UIImage(), tag: 1)
        
    }


}


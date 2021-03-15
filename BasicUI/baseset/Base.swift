//
//  BasicClass.swift
//  BasicUI
//
//  Created by 김동준 on 2021/03/12.
//

import Foundation
import UIKit

class BaseViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindViewModel()
    }
    
    public func setup() {
        view.backgroundColor = .white
        
    }
        
    public func bindViewModel(){
    }
}

class BaseView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        backgroundColor = .white
    }
}

extension UIView{
    func addSubViews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}

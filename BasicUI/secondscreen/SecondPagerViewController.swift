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
    lazy var vcArray: [UIViewController] = [self.VCInstance(name: .news),self.VCInstance(name: .peed)]
    private var direction: Int = 0
    private let menuData = MenuCollection()
    override func viewDidLoad() {
        super.viewDidLoad()
        view = secondViewPager
        
        menuData.pager = secondViewPager.pager
        menuData.highlightView = secondViewPager.highlightView
        menuData.view = view
        secondViewPager.menuTabBar.register(MenuCell.self, forCellWithReuseIdentifier: "menuCell")
        secondViewPager.menuTabBar.dataSource = menuData
        secondViewPager.menuTabBar.delegate = menuData
        
        secondViewPager.pager.register(PagerCell.self, forCellWithReuseIdentifier: "pagerCell")
        secondViewPager.pager.delegate = self
        secondViewPager.pager.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let firstIndexPath = IndexPath(item: 0, section: 0) // delegate 호출
        secondViewPager.menuTabBar.selectItem(at: firstIndexPath, animated: false, scrollPosition: .right)
        menuData.collectionView(secondViewPager.menuTabBar, didSelectItemAt: firstIndexPath)
    }
    
    private func VCInstance(name: VcId) -> UIViewController {
        switch name {
        case .news:
            let newsVC = NewsViewController()
            //reviewDelegate = reviewViewController
            //self.reviewDelegate!.sendReviewInfo(self.infoArr)
            return newsVC
        default:
            let peedVC = PeedViewController()
            //compareDelegate = compareViewController
            return peedVC
            
        }
    }
    
}
extension SecondPagerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let frameVC = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pagerCell", for: indexPath) as! PagerCell
        var vc = vcArray[indexPath.row]
        vc.view.frame = frameVC
        cell.view = vc.view
        cell.awakeFromNib()
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(collectionView.frame.width), height: CGFloat(collectionView.frame.height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let velocity = scrollView.panGestureRecognizer.velocity(in: scrollView)
        if velocity.x < 0 { // -: 오른쪽에서 왼쪽 <<<
            direction = -1
            
        } else if velocity.x > 0 { // +: 왼쪽에서 오른쪽 >>>
            direction = 1
            
        } else { }
        UIView.animate(withDuration: 0.1) { [weak self] in
            self!.secondViewPager.highlightView.transform = CGAffineTransform(translationX: scrollView.contentOffset.x / 2, y: 0)
            self!.secondViewPager.highlightView.layoutIfNeeded()
        }
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = Int(targetContentOffset.pointee.x / secondViewPager.menuTabBar.frame.width)
        let indexPath = IndexPath(item: index, section: 0)
        
        if direction > 0 { // >>>> 스와이프하면 스크롤은 중앙으로
            secondViewPager.menuTabBar.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
        } else { // <<<< 스와이프하면 스크롤은 왼쪽으로
            secondViewPager.menuTabBar.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        }
        
        secondViewPager.menuTabBar.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
        //viewIndex.onNext(indexPath.row)

    }

}

enum VcId{
    case peed
    case news
}

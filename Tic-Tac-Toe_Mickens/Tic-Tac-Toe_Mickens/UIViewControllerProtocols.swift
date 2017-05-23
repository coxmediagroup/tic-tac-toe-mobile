//
//  UIViewControllerProtocols.swift
//  Tic-Tac-Toe_Mickens
//
//  Created by Maurice Mickens on 5/6/17.
//
//

import Foundation
import UIKit

protocol CustomCollectionVC {}

extension CustomCollectionVC where Self: ViewController{
    
    func configNavigationController(vc:UIViewController, navBarTitle:String){
        UIApplication.shared.statusBarStyle = .default
        vc.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        vc.navigationController?.navigationBar.shadowImage = UIImage()
        vc.navigationController?.navigationBar.isTranslucent = true
        vc.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        vc.navigationItem.title = navBarTitle
        vc.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blue, NSFontAttributeName: UIFont.systemFont(ofSize: 24.0, weight: UIFontWeightBlack)]
    }
    
    func configCollectionView(delegate:AnyObject?){
        guard let delegate = delegate as? UIViewController else { return }
        collectionView.dataSource = self
        collectionView.delegate = delegate as? UICollectionViewDelegate
    }
    
    @discardableResult
    func configureCollectionViewItemSize(collectionView:UICollectionView, layout:UICollectionViewFlowLayout)->UICollectionViewFlowLayout{
        var width:CGFloat = 0.0
        
        if DeviceType.iPhone6Plus{
            width = collectionView.frame.width / 4
            layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20)
        } else if DeviceType.iPhone6{
            width = collectionView.frame.width / 4
            layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20)
        } else if DeviceType.iPhone5{
            width = collectionView.frame.width / 4.5
            layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        } else if DeviceType.iPhone4OrLess{
            width = collectionView.frame.width / 4.5
            layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20)
        } else if DeviceType.iPad{
            width = collectionView.frame.width / 2
            layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20)
        } else if DeviceType.iPad_Pro{
            width = collectionView.frame.width / 2
            layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20)
        }
        
        layout.itemSize = CGSize(width: width, height: width)
        return layout
    }
}

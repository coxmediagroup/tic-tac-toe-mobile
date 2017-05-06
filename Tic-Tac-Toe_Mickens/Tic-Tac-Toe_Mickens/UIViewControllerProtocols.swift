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
    
    func configCollectionView(delegate:AnyObject?){
        guard let delegate = delegate as? UIViewController else { return }
        collectionView.dataSource = self as? UICollectionViewDataSource
        collectionView.delegate = delegate as? UICollectionViewDelegate
    }
    
    @discardableResult
    func configureCollectionViewItemSize(collectionView:UICollectionView, layout:UICollectionViewFlowLayout)->UICollectionViewFlowLayout{
        var width:CGFloat = 0.0
        
        if DeviceType.iPhone6Plus{
            
        } else if DeviceType.iPhone6{
            width = collectionView.frame.width / 4
            layout.sectionInset = UIEdgeInsetsMake(10, 20, 10, 20)
        } else if DeviceType.iPhone5{
            
        } else if DeviceType.iPhone4OrLess{
            
        } else if DeviceType.iPad{
            
        } else if DeviceType.iPad_Pro{
            
        }
        
        layout.itemSize = CGSize(width: width, height: width)
        return layout
    }
}

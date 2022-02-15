//
//  SearchCollectionViewController.swift
//  Instagram
//
//  Created by Giuseppe Lobello on 2/10/22.
//

import UIKit
import TRMosaicLayout

private let reuseIdentifier = "Cell"

class SearchCollectionViewController: UICollectionViewController, TRMosaicLayoutDelegate {
    
    var searchPosts = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addPeople()

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let mosaicLayout = TRMosaicLayout()
        self.collectionView?.collectionViewLayout = mosaicLayout
        mosaicLayout.delegate = self
        
    }
    
    func addPeople(){
        
        for i in 1...5 {
            searchPosts.append("guy\(i)")
            searchPosts.append("girl\(i)")
        }
        
        for i in 1...5 {
            searchPosts.append("guy\(i)")
            searchPosts.append("girl\(i)")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, mosaicCellSizeTypeAtIndexPath indexPath: IndexPath) -> TRMosaicCellType {
        return indexPath.item % 9 == 0 ? TRMosaicCellType.big : TRMosaicCellType.small
    }

    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout: TRMosaicLayout, insetAtSection:Int) -> UIEdgeInsets {
      return UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }

    func heightForSmallMosaicCell() -> CGFloat {
      return 150
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchPosts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: searchPosts[indexPath.row])
        imageView.frame = cell.frame
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        cell.backgroundView = imageView
    
        return cell
    }

}

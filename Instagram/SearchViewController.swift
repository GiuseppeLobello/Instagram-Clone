//
//  SearchViewController.swift
//  Instagram
//
//  Created by Giuseppe Lobello on 2/1/22.
//

import UIKit
import TRMosaicLayout

class SearchViewController: UIViewController, TRMosaicLayoutDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    @IBOutlet weak var feedCollectionView: UICollectionView!
    
    let searchTags = ["test", "test", "test", "test", "test", "test", "test", "test", "test"]
    
    var searchPosts = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
        
        let mosaicLayout = TRMosaicLayout()
        feedCollectionView.collectionViewLayout = mosaicLayout
        mosaicLayout.delegate = self
        
        addPeople()
                        
        searchBarUI()
        
        tagCollectionViewLayout()
        
    }
    
    func searchBarUI(){
                        
        searchBar.searchTextField.textColor = UIColor.white
        searchBar.searchTextField.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.00)
        searchBar.tintColor = UIColor.white
        searchBar.placeholder = "Search"
                
        navigationItem.titleView = searchBar
        
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
        
        for i in 1...5 {
            searchPosts.append("guy\(i)")
            searchPosts.append("girl\(i)")
        }
        
        for i in 1...5 {
            searchPosts.append("guy\(i)")
            searchPosts.append("girl\(i)")
        }
        
    }
    
    func tagCollectionViewLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 100, height: 40)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        tagCollectionView!.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == tagCollectionView) {
            return searchTags.count
        } else {
            return searchPosts.count
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == tagCollectionView){
            
            let cell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as! SearchTagCollectionViewCell
            
            cell.tagButton.setTitle(searchTags[indexPath.row], for: .normal)
            
            return cell
            
        } else {
            
            let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! SearchFeedCollectionViewCell
            
            let imageView = UIImageView()
            imageView.image = UIImage(named: searchPosts[indexPath.row])
            imageView.frame = cell.frame
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            
            cell.backgroundView = imageView
            
            return cell
            
        }
        
    }
    
}

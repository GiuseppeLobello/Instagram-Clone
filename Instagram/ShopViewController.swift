//
//  ShopViewController.swift
//  Instagram
//
//  Created by Giuseppe Lobello on 2/14/22.
//

import UIKit

class ShopViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {    
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    @IBOutlet weak var storeCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchTags = ["test", "test", "test", "test", "test", "test", "test", "test", "test"]
    
    var products = [String]()
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        
        storeCollectionView.delegate = self
        storeCollectionView.dataSource = self
        
        loadUI()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let productsHeight = storeCollectionView.collectionViewLayout.collectionViewContentSize.height + 100
        scrollViewHeight.constant = CGFloat(productsHeight)
        self.view.layoutIfNeeded()
        
        productsCollectionViewLayout()
        
    }
    
    func loadUI(){
        
        searchBarUI()
        
        addProducts()
        
        tagCollectionViewLayout()
        
        productsCollectionViewLayout()
                
        let usernameView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 50))
        
        let usernameLabel = UILabel(frame: CGRect(x: 10, y: -5, width: 200, height: 50))
        usernameLabel.text = "Shop"
        usernameLabel.textColor = UIColor.white
        usernameLabel.font = UIFont(name: "Helvetica Neue Bold", size: 25)
        
        usernameView.addSubview(usernameLabel)
        
        navigationItem.titleView = usernameView
        
    }
    
    func addProducts(){
        
        for i in 1...3 {
            products.append("hat\(i)")
            products.append("shirt\(i)")
            products.append("shoe\(i)")
        }
        
        for i in 1...3 {
            products.append("hat\(i)")
            products.append("shirt\(i)")
            products.append("shoe\(i)")
        }
        
    }
    
    func searchBarUI(){
                        
        searchBar.searchTextField.textColor = UIColor.white
        searchBar.searchTextField.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.00)
        searchBar.tintColor = UIColor.white
        searchBar.placeholder = "Search"
        
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
    
    func productsCollectionViewLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.bounds.width/2 - 0.5, height: self.view.bounds.width/2 - 0.5)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0.5
        layout.minimumLineSpacing = 0.5
        storeCollectionView!.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == tagCollectionView) {
            return searchTags.count
        } else {
            return products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        if (collectionView == tagCollectionView){
            
            let cell = tagCollectionView.dequeueReusableCell(withReuseIdentifier: "tagCell", for: indexPath) as! SearchTagCollectionViewCell
            cell.tagButton.setTitle(searchTags[indexPath.row], for: .normal)
            return cell
            
        } else {
            
            let cell = storeCollectionView.dequeueReusableCell(withReuseIdentifier: "shopCell", for: indexPath) as! ShopCollectionViewCell
            cell.productImage.image = UIImage(named: products[indexPath.row])
            return cell
            
        }
        
        
    }

}

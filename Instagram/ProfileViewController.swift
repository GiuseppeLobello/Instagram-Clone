//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Giuseppe Lobello on 2/8/22.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var editProfileButton: UIButton!
    
    @IBOutlet weak var followUIView: UIView!
    
    @IBOutlet weak var profileImagesCollectionView: UICollectionView!
    
    @IBOutlet weak var storyPosts: UIView!
    
    var searchPosts = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImagesCollectionView.delegate = self
        profileImagesCollectionView.dataSource = self
        
        loadUI()
        
        loadProfile()
        
        addPeople()
        
        profileCollectionViewLayout()
        
    }
    
    func loadUI() {
        
        let opacity:CGFloat = 0.2
        let borderColor = UIColor.white
        editProfileButton.layer.borderColor = borderColor.withAlphaComponent(opacity).cgColor
        followUIView.layer.borderColor = borderColor.withAlphaComponent(opacity).cgColor
        storyPosts.layer.borderColor = borderColor.withAlphaComponent(opacity).cgColor
        
        followUIView.layer.borderWidth = 1
        followUIView.layer.cornerRadius = 5
        editProfileButton.layer.borderWidth = 1
        editProfileButton.layer.cornerRadius = 5
        storyPosts.layer.borderWidth = 1
        
        storyPosts.clipsToBounds = true
        storyPosts.layer.cornerRadius = storyPosts.layer.bounds.width/2
        
        let usernameView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 50))
        
        let usernameLabel = UILabel(frame: CGRect(x: 30, y: -5, width: 200, height: 50))
        usernameLabel.text = "username"
        usernameLabel.textColor = UIColor.white
        usernameLabel.font = UIFont(name: "Helvetica Neue Bold", size: 25)
        
        let lockImage = UIImageView(frame: CGRect(x: 13, y: 15, width: 13, height: 13))
        lockImage.image = UIImage(named: "lock")
        lockImage.contentMode = .scaleAspectFit
        lockImage.tintColor = UIColor.white
        
        usernameView.addSubview(lockImage)
                
        usernameView.addSubview(usernameLabel)
                
        navigationItem.titleView = usernameView
        
    }
    
    func loadProfile() {
        
        avatar.image = UIImage(named: "guy1")
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = avatar.layer.bounds.width/2
        avatar.contentMode = .scaleAspectFill
        
    }
    
    func addPeople(){
        
        for i in 1...5 {
            searchPosts.append("guy\(i)")
        }
        
        for i in 1...5 {
            searchPosts.append("girl\(i)")
        }
        
        for i in 1...5 {
            searchPosts.append("girl\(i)")
        }
        
    }
    
    func profileCollectionViewLayout(){
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width / 3 - 1, height: self.view.frame.width / 3 - 1)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0.5
        layout.minimumLineSpacing = 0.5
        profileImagesCollectionView!.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchPosts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = profileImagesCollectionView.dequeueReusableCell(withReuseIdentifier: "profileCell", for: indexPath) as! ProfileCollectionViewCell
        
        cell.post.contentMode = .scaleAspectFill
        cell.post.clipsToBounds = true
        cell.post.image = UIImage(named: searchPosts[indexPath.row])
        
        return cell
        
    }


}

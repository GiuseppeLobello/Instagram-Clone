//
//  ReelsViewController.swift
//  Instagram
//
//  Created by Giuseppe Lobello on 2/1/22.
//

import UIKit
import AVKit
import AVFoundation
import AudioToolbox

class ReelsViewController: UIViewController, AVPlayerViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
    @IBOutlet weak var reelsCollectionview: UICollectionView!
    
    var alreadySetLayout = false
        
    let reels = ["https://media3.giphy.com/media/Mtqip7Jor0DgAvzn6U/giphy.mp4?cid=790b76112362a26a91967d4a8d69e8df40fd248e951120b9&rid=giphy.mp4&ct=g", "https://media0.giphy.com/media/ndxDSZKMwXOiNdJ4iA/giphy720p.mp4", "https://media1.giphy.com/media/CJyRX8btFziYLt3WAT/giphy480p.mp4?cid=ecf05e478e5dquogdb16z7mziwooxupxdbmwak3m667tjvqw&rid=giphy480p.mp4&ct=v", "https://media4.giphy.com/media/1hqYk0leUMddBBkAM7/giphy.mp4?cid=ecf05e472r5v1jlb5yj8d21x62srzh6iar29vmk2r477bmds&rid=giphy.mp4&ct=g"]
    
    var storyAvatars = ["guy1", "girl1", "guy2", "girl2"]
    
    var feedUsernames = ["Mike43", "sofia.hart21", "Chris_TM", "Megan_Fox"]
    
    var feedLikes = ["242k", "94k", "481k", "712k"]
    
    var feedComments = ["310", "150", "521", "831"]
            
    override func viewDidLoad() {
        super.viewDidLoad()
                       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
                
        if (alreadySetLayout == false) {
            
            self.alreadySetLayout = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                
                self.reelsCollectionview.delegate = self
                self.reelsCollectionview.dataSource = self
                
                self.reelsCollectionViewLayout()
                
                self.reelsCollectionview.scrollToItem(at:IndexPath(item: 0, section: 0), at: .right, animated: false)
                                
           }
            
        }
        
    }
        
    /*
    override func viewDidDisappear(_ animated: Bool) {
        smallVideoPlayerViewController.player?.pause()
    }
     */
    
    func reelsCollectionViewLayout(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: reelsCollectionview.frame.width, height: reelsCollectionview.frame.height)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        reelsCollectionview!.collectionViewLayout = layout
    }
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = reelsCollectionview.dequeueReusableCell(withReuseIdentifier: "reelCell", for: indexPath) as! ReelsCollectionViewCell
        
        cell.avatarImage.image = UIImage(named: storyAvatars[indexPath.row])
        cell.avatarImage.clipsToBounds = true
        cell.avatarImage.layer.cornerRadius = cell.avatarImage.layer.bounds.width/2
        
        cell.likesLabel.text = feedLikes[indexPath.row]
        cell.commentsLabel.text = feedComments[indexPath.row]
        cell.usernameLabel.text = feedUsernames[indexPath.row]
        
        cell.smallVideoPlayerViewController.showsPlaybackControls = false
        cell.smallVideoPlayerViewController.player = AVPlayer(url: URL(string: reels[indexPath.row])!)
        cell.smallVideoPlayerViewController.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cell.smallVideoPlayerViewController.view.frame = cell.reelView.bounds
        
        cell.smallVideoPlayerViewController.player?.play()
        cell.smallVideoPlayerViewController.player?.isMuted = true
                
        cell.reelView.addSubview(cell.smallVideoPlayerViewController.view)
        
        cell.reelView.sendSubviewToBack(cell.smallVideoPlayerViewController.view)
                
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            print("scrollllling")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        //let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        //let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
                               
        //let myCell = reelsCollectionview.cellForItem(at: indexPath) as? ReelsCollectionViewCell
        //myCell?.smallVideoPlayerViewController.player?.play()
        
        //if indexPath.section == 0 {
            
        //}
               
    }
            
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (smallVideoPlayerViewController.player?.rate == 0){
            smallVideoPlayerViewController.player?.play()
        } else {
            smallVideoPlayerViewController.player?.pause()
        }
    }
    */

}

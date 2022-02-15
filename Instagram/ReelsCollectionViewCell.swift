//
//  ReelsCollectionViewCell.swift
//  Instagram
//
//  Created by Giuseppe Lobello on 2/1/22.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer
import AudioToolbox

class ReelsCollectionViewCell: UICollectionViewCell {    
    
    @IBOutlet weak var reelView: UIView!
    
    @IBOutlet weak var heartImage: UIImageView!
    
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var commentsImage: UIImageView!
    
    @IBOutlet weak var commentsLabel: UILabel!
    
    @IBOutlet weak var sendButton: UIImageView!
    
    @IBOutlet weak var menuImage: UIImageView!
        
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    let smallVideoPlayerViewController = AVPlayerViewController()
    
}

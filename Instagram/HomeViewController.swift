//
//  HomeViewController.swift
//  Instagram
//
//  Created by Giuseppe Lobello on 1/29/22.
//

import UIKit
import Spring

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var storyCollectionView: UICollectionView!
    
    @IBOutlet weak var feedCollectionView: UICollectionView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var scrollViewContentView: UIView!
    
    var storyAvatars = [String]()
    
    var storyUsernames = ["Mike43", "sofia.hart21", "Chris_TM", "Megan_Fox", "Bob.yerrrt", "AlexisPicc", "Nicooo17", "Verronica.S", "_Swaggy32", "Mikayyla__"]
    
    var feedLikes = [521, 931, 3821, 204, 7391, 832, 2,293, 910, 262, 1031]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storyCollectionView.delegate = self
        storyCollectionView.dataSource = self
        
        feedCollectionView.delegate = self
        feedCollectionView.dataSource = self
        
        addPeople()
        
        loadUI()
        
        setUpDoubleTap()
        
    }
    
    func loadUI(){
        
        storyCollectionViewLayout()
        
        FeedCollectionViewLayout()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 50))
        imageView.contentMode = .scaleAspectFit
        
        let imageView2 = UIImageView(frame: CGRect(x: 0, y: -5, width: 130, height: 50))
        imageView2.image = UIImage(named: "Instagram Title")
        imageView2.contentMode = .scaleAspectFit
        
        imageView.addSubview(imageView2)
        
        navigationItem.titleView = imageView
        
    }
    
    func addPeople(){
        
        for i in 1...5 {
            storyAvatars.append("guy\(i)")
            storyAvatars.append("girl\(i)")
        }
        
    }
    
    func storyCollectionViewLayout(){
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 3)
        layout.itemSize = CGSize(width: 90, height: 112)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        storyCollectionView!.collectionViewLayout = layout
    }
    
    func FeedCollectionViewLayout(){
        // Do any additional setup after loading the view, typically from a nib.
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width, height: 700)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        feedCollectionView!.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storyAvatars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == storyCollectionView){
            
            let cell = storyCollectionView.dequeueReusableCell(withReuseIdentifier: "storyCell", for: indexPath) as! HomeStoriesCollectionViewCell
            
            cell.avatar.clipsToBounds = true
            cell.avatar.layer.cornerRadius = cell.avatar.layer.bounds.width/2
            cell.avatar.image = UIImage(named: storyAvatars[indexPath.row])
            
            self.addBorderGradient(to: cell.avatarBorder, startColor: UIColor(red: 1.00, green: 0.85, blue: 0.46, alpha: 1.00), endColor: UIColor(red: 0.84, green: 0.16, blue: 0.46, alpha: 1.00), lineWidth: 5, startPoint: CGPoint.bottomLeft, endPoint: CGPoint.topRight)
            
            cell.username.text = storyUsernames[indexPath.row]
            
            return cell
            
        } else {
            
            let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath) as! HomeFeedCollectionViewCell
            
            cell.feedAvatar.clipsToBounds = true
            cell.feedAvatar.layer.cornerRadius = cell.feedAvatar.layer.bounds.width/2
            cell.feedAvatar.image = UIImage(named: storyAvatars[indexPath.row])
            
            cell.avatar2.clipsToBounds = true
            cell.avatar2.layer.cornerRadius = cell.avatar2.layer.bounds.width/2
            cell.avatar2.image = UIImage(named: storyAvatars[indexPath.row])
            
            cell.feedPost.image = UIImage(named: storyAvatars[indexPath.row])
            
            cell.feedUsername.text = storyUsernames[indexPath.row]
            cell.feedUsernameLabel.text = storyUsernames[indexPath.row]
                        
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let formattedNumber = numberFormatter.string(from: NSNumber(value: feedLikes[indexPath.row]))!
            cell.feedLikesLabel.text = "\(formattedNumber) likes"
            
            cell.feedCaption.text = "This is a caption..."
            
            return cell
            
        }
        
    }
    
    private var doubleTapGesture: UITapGestureRecognizer!
    func setUpDoubleTap() {
        doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapCollectionView))
        doubleTapGesture.numberOfTapsRequired = 2
        feedCollectionView.addGestureRecognizer(doubleTapGesture)
        doubleTapGesture.delaysTouchesBegan = true
    }
    
    @objc func didDoubleTapCollectionView() {
        
        let pointInCollectionView = doubleTapGesture.location(in: feedCollectionView)
        
        if let selectedIndexPath = feedCollectionView.indexPathForItem(at: pointInCollectionView) {
            
            let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: selectedIndexPath) as! HomeFeedCollectionViewCell
            
            if let aCell = feedCollectionView.cellForItem(at: selectedIndexPath) as? HomeFeedCollectionViewCell {
                
                aCell.feedHeartLogo.image = UIImage(named: "heartFilled")
                aCell.feedHeartLogo.tintColor = UIColor(red: 0.91, green: 0.30, blue: 0.24, alpha: 1.00)
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let formattedNumber = numberFormatter.string(from: NSNumber(value: feedLikes[selectedIndexPath.row] + 1))!
                
                aCell.feedLikesLabel.text = "\(formattedNumber) likes"
                
            }
            
            let myRect = cell.frame
            let originInRootView = self.feedCollectionView.convert(myRect.origin, to: scrollViewContentView)
                                    
            let likedPhoto = SpringView(frame: CGRect(x: scrollViewContentView.bounds.width / 2 - 50, y: originInRootView.y + 150, width: 100, height: 100))
            likedPhoto.isHidden = false
            
            let heartLogo = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
            heartLogo.image = UIImage(named: "heartFilled")
            heartLogo.tintColor = UIColor.white
            
            likedPhoto.addSubview(heartLogo)
            
            likedPhoto.animation = "pop"
            likedPhoto.curve = "easeInOut"
            likedPhoto.duration = 0.5
            likedPhoto.damping = 1.0
            likedPhoto.velocity = 0.0
            likedPhoto.animate()
            
            feedCollectionView.addSubview(likedPhoto)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                likedPhoto.isHidden = true
            }
            
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func addBottomBorder() {
        let thickness: CGFloat = 0.5
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x:0, y: self.storyCollectionView.frame.size.height - thickness, width: self.storyCollectionView.contentSize.width + 50, height:thickness)
        bottomBorder.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        storyCollectionView.layer.addSublayer(bottomBorder)
    }
    
    func addBorderGradient(to view: UIView, startColor:UIColor, endColor: UIColor, lineWidth: CGFloat, startPoint: CGPoint, endPoint: CGPoint) {
        //This will make view border circular
        view.layer.cornerRadius = view.bounds.size.height / 2.0
        //This will hide the part outside of border, so that it would look like circle
        view.clipsToBounds = true
        //Create object of CAGradientLayer
        let gradient = CAGradientLayer()
        //Assign origin and size of gradient so that it will fit exactly over circular view
        gradient.frame = view.bounds
        //Pass the gredient colors list to gradient object
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        //Point from where gradient should start
        gradient.startPoint = startPoint
        //Point where gradient should end
        gradient.endPoint = endPoint
        //Now we have to create a circular shape so that it can be added to view’s layer
        let shape = CAShapeLayer()
        //Width of circular line
        shape.lineWidth = lineWidth
        //Create circle with center same as of center of view, with radius equal to half height of view, startAngle is the angle from where circle should start, endAngle is the angle where circular path should end
        shape.path = UIBezierPath(
            arcCenter: CGPoint(x: view.bounds.height/2,
                               y: view.bounds.height/2),
            radius: view.bounds.height/2,
            startAngle: CGFloat(0),
            endAngle:CGFloat(CGFloat.pi * 2),
            clockwise: true).cgPath
        //the color to fill the path’s stroked outline
        shape.strokeColor = UIColor.black.cgColor
        //The color to fill the path
        shape.fillColor = UIColor.clear.cgColor
        //Apply shape to gradient layer, this will create gradient with circular border
        gradient.mask = shape
        //Finally add the gradient layer to out View
        view.layer.addSublayer(gradient)
    }
    
}

extension CGPoint {
    static let topLeft = CGPoint(x: 0, y: 0)
    static let topCenter = CGPoint(x: 0.5, y: 0)
    static let topRight = CGPoint(x: 1, y: 0)
    static let centerLeft = CGPoint(x: 0, y: 0.5)
    static let center = CGPoint(x: 0.5, y: 0.5)
    static let centerRight = CGPoint(x: 1, y: 0.5)
    static let bottomLeft = CGPoint(x: 0, y: 1.0)
    static let bottomCenter = CGPoint(x: 0.5, y: 1.0)
    static let bottomRight = CGPoint(x: 1, y: 1)
}

extension UIImage {
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
}

extension CALayer {
    func innerBorder(borderOffset: CGFloat = 24.0, borderColor: UIColor = UIColor.blue, borderWidth: CGFloat = 2) {
        let innerBorder = CALayer()
        print(frame.size.width)
        //innerBorder.frame = CGRect(x: borderOffset, y: borderOffset, width: frame.size.width - 2 * borderOffset, height: frame.size.height - 2 * borderOffset)
        innerBorder.frame = CGRect(x: 25, y: 25, width: 75, height: 75)
        innerBorder.borderColor = UIColor.white.cgColor
        innerBorder.borderWidth = 2
        innerBorder.name = "innerBorder"
        insertSublayer(innerBorder, at: 0)
    }
}

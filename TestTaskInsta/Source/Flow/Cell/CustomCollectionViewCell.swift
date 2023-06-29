//
//  CustomCollectionViewCell.swift
//  InstaFromAPI
//
//  Created by Анна Яцун on 27.06.2023.
//

import UIKit
import SDWebImage
 
struct Constants {
    static let star = "star"
    static let starFill = "star.fill"
    static let heart = "suit.heart"
    static let heartFill = "suit.heart.fill"
}

enum CollectionViewCellEvent {
    case moreButton
    case comment
    case share
}


class CustomCollectionViewCell: UICollectionViewCell {
    var eventHandel: ((CollectionViewCellEvent) -> ())?
    let spiner = Spinner()
    @IBOutlet weak var countLikes: UILabel!
    @IBOutlet weak var profileImage: UIImageView?
    @IBOutlet weak var profileInfo: UILabel?
    @IBOutlet weak var commentView: UIView?
    @IBOutlet weak var moreBitton: UIButton?
    @IBOutlet weak var postImageView: UIImageView?
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var commentPersonImage: UIImageView!
    @IBOutlet weak var haeartImageView: UIImageView!
    var isLiked = false
    var isAddedToFavorite = false
 
    //MARK: LifeStyle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createGestureTap()
        configureLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImage?.image = nil
        profileInfo?.text = nil
        postImageView?.image = nil
    }
    

    // MARK: Publick
    
    func fill(model: Photo) {
        profileImage?.sd_setImage(with: getUL(model).0)
        profileInfo?.text = model.user?.username
        postImageView?.sd_setImage(with: getUL(model).1) {[weak self]_,_,_,_ in
            self?.spiner.stopAnimating()
        }
        countLikes.text = "\(model.likes)"
        commentPersonImage.sd_setImage(with: getUL(model).0)
    }
    
    @IBAction func addToFavoriteAction(_ sender: Any) {
        favoriteButton.checkSelectedState(
            ifSelected: self.isAddedToFavorite,
            setImageNameToNotSelected: Constants.star,
            setImageNameToSelected: Constants.starFill,
            notSelectedColer: .label,
            selectedColor: .gray)
        self.isAddedToFavorite = !isAddedToFavorite
    }
    
    @IBAction func shareAction(_ sender: Any) {
        eventHandel?(.share)
    }
    
    @IBAction func addCommentAction(_ sender: Any) {
        eventHandel?(.comment)
    }
    
    @IBAction func openMoreButton(_ sender: Any) {
        eventHandel?(.moreButton)
    }
    
    @IBAction func addLike(_ sender: Any) {
        likeButton.checkSelectedState(
            ifSelected: self.isLiked,
            setImageNameToNotSelected: Constants.heart,
            setImageNameToSelected: Constants.heartFill,
            notSelectedColer: .label,
            selectedColor: .red)
        self.isLiked = !isLiked
        
    }
    
    @objc func didDoubleTapToLike() {
        likeButton.checkSelectedState(
            ifSelected: false,
            setImageNameToNotSelected: Constants.heart,
            setImageNameToSelected: Constants.heartFill,
            notSelectedColer: .label,
            selectedColor: .red)
        UIView.animate(withDuration: 0.4) {
            self.haeartImageView.alpha = 1
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.4) {
                    self.haeartImageView.alpha = 0
                } completion: { done in
                    
                }
            }
        }
    }
        
    // MARK: Private
    
    private func configureLayout() {
        addSubview(spiner)
        profileImage?.layer.cornerRadius = 25
        commentPersonImage.layer.cornerRadius = 15
        spiner.Style = .Dark
        spiner.startAnimating()

        spiner.frame = .init(
            x: 150,
            y: 150,
            width: 30,
            height: 30)
    }
    
    private func createGestureTap() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(didDoubleTapToLike))
        tap.numberOfTapsRequired = 1
        postImageView?.isUserInteractionEnabled = true
        postImageView?.addGestureRecognizer(tap)
    }
    
    private func getUL(_ model: Photo) -> (URL?, URL?) {
        let postImageURL = model.user.flatMap() {
            URL(string: $0.profileImage.small)
        }
        let profileImageURL = model.urls.flatMap() {
            URL(string: $0.full)
        }

        return (postImageURL, profileImageURL)
    }
}


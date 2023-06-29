//
//  CommentTableViewCell.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 28.06.2023.
//

import UIKit
import SDWebImage

class CommentTableViewCell: BaseCell<Photo, EmptyModel> {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var likeCommentButton: UIButton!
    var isLiked = false
    
    //MARK: LifeStyle
 
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImage.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func addToFavoriteCommentAction(_ sender: Any) {
        likeCommentButton.checkSelectedState(
            ifSelected: self.isLiked,
            setImageNameToNotSelected: Constants.star,
            setImageNameToSelected: Constants.starFill,
            notSelectedColer: .label,
            selectedColor: .red)
        self.isLiked = !isLiked
    }
    
    override func fill(with model: Photo) {
        guard let aaa = model.user?.profileImage.small else { return }
        guard let url = URL(string: aaa) else {return}
        avatarImage?.sd_setImage(with: url)
        userNameLabel.text = model.user?.username
    }
    
    
}

//
//  QiitaTableViewCell.swift
//  QiitaApi
//
//  Created by 永井涼 on 2020/11/29.
//

import UIKit

class QiitaTableViewCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var bodyTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
       var qiita: Qiita? {
           didSet {
               bodyTextLabel.text = qiita?.title
               let url = URL(string: qiita?.user.profileImageUrl ?? "")
               do {
                   let data = try Data(contentsOf: url!)
                   let image = UIImage(data: data)
                   userImage.image = image
               }catch let err {
                   print("Error : \(err.localizedDescription)")
               }
           }
       }
  
}

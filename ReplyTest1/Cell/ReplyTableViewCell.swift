//
//  ReplyTableViewCell.swift
//  ReplyTest1
//
//  Created by PTK on 2023/05/22.
//

import Foundation
import UIKit

class ReplyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with comment: Comment) {
        label.text = comment.commentText
        self.backgroundColor = .lightGray
    }
}

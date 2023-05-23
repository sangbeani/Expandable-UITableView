//
//  ReplyReplyTableViewCell.swift
//  ReplyTest1
//
//  Created by PTK on 2023/05/22.
//

import Foundation
import UIKit

class ReplyReplyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with reply: Reply) {
        label.text = reply.replyText
    }
}

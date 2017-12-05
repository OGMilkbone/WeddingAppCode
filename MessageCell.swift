//
//  MessageCell.swift
//  FarceBookTheApp
//
//  Created by jwilson on 11/14/17.
//  Copyright © 2017 jwilson. All rights reserved.
//
import UIKit

class MessageCell: UITableViewCell {
    
    var message: Message? {
        didSet(newValue) {
            self.messageLabel.text = self.message?.text
            self.dateLabel.text = self.message?.date.description
            self.userLabel.text = self.message?.user
            if ((self.message?.imgURL) != nil) {
                ImageService.shared.imageForURL(url: URL(string: (self.message?.imgURL!)!)){(image, url) in
                    self.ImageView.image = image
                }
                
            }
            
        }
    }
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    
    
}


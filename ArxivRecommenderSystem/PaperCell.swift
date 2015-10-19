//
//  PaperCell.swift
//  ArxivRecommenderSystem
//
//  Created by zhangjun on 15/10/18.
//  Copyright © 2015年 zhangjun. All rights reserved.
//

import UIKit

class PaperCell: UITableViewCell {

    @IBOutlet weak var PaperShotImage: UIImageView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Author: UILabel!
    @IBOutlet weak var Time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(paper : PaperModel){
        
        self.Title.text = paper.title
        
        self.Author.text = paper.author
        
        self.Time.text = paper.time
        
    }
    
}

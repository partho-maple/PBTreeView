//
//  FamilyTreeTableViewCell.swift
//  FamilyTree
//
//  Created by Partho Biswas on 3/14/17.
//  Copyright © 2017 Partho Biswas. All rights reserved.
//

import UIKit

class FamilyTreeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var treeButton: UIButton!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var subTitleLable: UILabel!
    var treeNode: TreeViewNode!
    
    
    //MARK:  Draw Rectangle for Image
    
    override func draw(_ rect: CGRect) {
        var titleFrame: CGRect = self.titleLable.frame
        var subTitleFrame = self.subTitleLable.frame
        var buttonFrame: CGRect = self.treeButton.frame
        let indentation: Int = self.treeNode.nodeLevel! * 25
        titleFrame.origin.x = buttonFrame.size.width + CGFloat(indentation) + 5
        subTitleFrame.origin.x = titleFrame.origin.x
        buttonFrame.origin.x = 2 + CGFloat(indentation)
        self.titleLable.frame = titleFrame
        self.subTitleLable.frame = subTitleFrame
        self.treeButton.frame = buttonFrame
    }
    
    //MARK:  Set Background image
    
    func setTheButtonBackgroundImage(_ backgroundImage: UIImage) {
        self.treeButton.setBackgroundImage(backgroundImage, for: UIControlState())
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @IBAction func treeButtonCLicked(_ sender: Any) {
        
        if (self.treeNode != nil) {
            if self.treeNode.nodeChildren != nil {
                if self.treeNode.isExpanded == true {
                    self.treeNode.isExpanded = false
                } else {
                    self.treeNode.isExpanded = true
                }
            } else {
                self.treeNode.isExpanded = false
            }
            
            self.isSelected = false
            NotificationCenter.default.post(name: Notification.Name(rawValue: "TreeNodeButtonClicked"), object: self)
        }
    }
    
    
    @IBAction func detailsButtonClicked(_ sender: Any) {

    }

}

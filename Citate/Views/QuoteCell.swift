//
//  QuoteCell.swift
//  Citate
//
//  Created by Ungurean Valentina on 02.01.2022.
//

import UIKit

class QuoteCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        stackView.backgroundColor = UIColor(white: 1, alpha: 0.8)
        stackView.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

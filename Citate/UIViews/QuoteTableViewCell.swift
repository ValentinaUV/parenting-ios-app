//
//  QuoteTableViewCell.swift
//  Citate
//
//  Created by Ungurean Valentina on 07.01.2022.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(favoriteImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(authorLabel)
        self.contentView.addSubview(containerView)
        
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            favoriteImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
            favoriteImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10),
            favoriteImageView.widthAnchor.constraint(equalToConstant:30),
            favoriteImageView.heightAnchor.constraint(equalToConstant:30),
            containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo:self.favoriteImageView.trailingAnchor, constant:10),
            containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10),
            containerView.topAnchor.constraint(equalTo:self.contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor),
            containerView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor, constant: 40),
            titleLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor),
            authorLabel.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor, constant:5)
        ])
    }
    
    let favoriteImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.image = UIImage(systemName: "heart.fill")
        img.tintColor = UIColor.systemTeal
        return img
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let authorLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.systemTeal
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    var quote:Quote? {
        didSet {
            guard let item = quote else {return}
            titleLabel.text = "\"\(item.title) \""
            authorLabel.text = item.author
        }
    }
}

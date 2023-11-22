//
//  MessagesTableViewCell.swift
//  WA8_Final_Project_1
//
//  Created by Tiffany Zhang on 11/17/23.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {
    var labelTime: UILabel!
    var wrapperCellView: UIView!
    var labelMessage: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLabelTime()
        setupWrapperCellView()
        setupLabelMessage()
        
        initConstraints()
    }
    
    func setupLabelTime() {
        labelTime = UILabel()
        labelTime.textColor = UIColor.lightGray
        labelTime.font = UIFont.systemFont(ofSize: 13)
        labelTime.numberOfLines = 0
        labelTime.lineBreakMode = .byWordWrapping
        labelTime.sizeToFit()
        
        labelTime.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(labelTime)
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UITableViewCell()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 4.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 1.0
        wrapperCellView.layer.shadowOpacity = 0.7
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelMessage() {
        labelMessage = UILabel()
        labelMessage.font = UIFont.boldSystemFont(ofSize: 16)
        labelMessage.numberOfLines = 0
        labelMessage.lineBreakMode = .byWordWrapping
        labelMessage.sizeToFit()
        
        labelMessage.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelMessage)
    }
    
    func initConstraints() {
        
        contentView.removeConstraints(contentView.constraints)
        
        NSLayoutConstraint.activate([
            labelTime.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            
            wrapperCellView.topAnchor.constraint(equalTo: labelTime.bottomAnchor, constant: 2),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),

            labelMessage.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 10),
            labelMessage.bottomAnchor.constraint(equalTo: wrapperCellView.bottomAnchor, constant: -10),
            labelMessage.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            labelMessage.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -10),
            labelMessage.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, constant: -100),
        ])
    }
    
    func setSelfConstraint() {
        wrapperCellView.backgroundColor = UIColor(red: 0.29, green: 0.80, blue: 0.47, alpha: 1.0)
    }
    
    func setOppoConstraint() {
        wrapperCellView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

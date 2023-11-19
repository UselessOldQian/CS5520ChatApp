//
//  MessagesTableViewCell.swift
//  WA8_Final_Project_1
//
//  Created by Tiffany Zhang on 11/17/23.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {
    var wrapperCellView: UIView!
    var labelMessage: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelMessage()
        
        initConstraints()
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UITableViewCell()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 4.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 2.0
        wrapperCellView.layer.shadowOpacity = 0.7
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelMessage() {
        labelMessage = UILabel()
        labelMessage.font = UIFont.boldSystemFont(ofSize: 16)
        labelMessage.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelMessage)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            wrapperCellView.heightAnchor.constraint(equalToConstant: 36),
            
            labelMessage.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
//            labelMessage.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
        ])
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  ChatsTableViewCell.swift
//  WA8_Final_Project_1
//
//  Created by GG Q on 2023/11/18.
//

import UIKit

class ChatsTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var labelName: UILabel!
    var labelTime: UILabel!
    var labelText: UILabel!
    var senderName: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelName()
        setupLabelTime()
        setupLabelText()
        setupSenderName()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabelName(){
        labelName = UILabel()
        labelName.text = "Tester"
        labelName.font = UIFont.boldSystemFont(ofSize: 16)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelName)
    }
    
    func setupLabelTime(){
        labelTime = UILabel()
        labelTime.text = "2023/10/11 12:20"
        labelTime.font = UIFont.boldSystemFont(ofSize: 16)
        labelTime.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelTime)
    }
    
    func setupLabelText(){
        labelText = UILabel()
        labelText.text = "Hi how are you"
        labelText.font = UIFont.systemFont(ofSize: 14)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelText)
    }
    
    func setupSenderName() {
        senderName = UILabel()
        labelText.font = UIFont.systemFont(ofSize: 14)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelText)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            labelName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            
            labelTime.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelTime.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -10),
//            labelTime.leadingAnchor.constraint(equalTo: labelName.trailingAnchor, constant: 20),
            
            labelName.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor, multiplier: 0.5),
            
            // labelText Constraints
            labelText.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 8),
            labelText.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            labelText.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            
            senderName.topAnchor.constraint(equalTo: labelText.bottomAnchor, constant: 8),
            senderName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 16),
            senderName.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -16),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 72)
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

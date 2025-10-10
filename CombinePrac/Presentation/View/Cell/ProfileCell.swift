//
//  ProfileCell.swift
//  CombinePrac
//
//  Created by 송규섭 on 10/9/25.
//

import UIKit

class ProfileCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "ProfileCell"
    
    // MARK: - UI Components
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    @available(*, unavailable, message: "storyboard is not supported.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    // MARK: - Public Methods
    func update(with profile: Profile) {
        nameLabel.text = profile.name
        usernameLabel.text = profile.username
    }
}

private extension ProfileCell {
    func configure() {
        setHierarchy()
        setStyles()
        setConstraints()
    }
    
    func setHierarchy() {
        [nameLabel, usernameLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setStyles() {
        contentView.backgroundColor = .white
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            usernameLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            usernameLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])
    }
}

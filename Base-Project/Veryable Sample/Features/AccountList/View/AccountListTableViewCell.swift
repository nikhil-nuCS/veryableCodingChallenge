//
//  AccountListTableViewCell.swift
//  Veryable Sample
//
//  Created by Nikhil Khandelwal on 11/16/22.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import UIKit
import SnapKit

class AccountListTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    lazy var acctNameLabel: UILabel = {
        let label = UILabel()
        label.font = .vryAvenirNextDemiBold(14)
        label.textColor = VGrey.dark.color
        return label
    }()
    
    lazy var acctDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .vryAvenirNextRegular(12)
        label.textColor = VGrey.dark.color
        return label
    }()
    
    lazy var acctTransactionTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .vryAvenirNextRegular(12)
        label.textColor = VGrey.normal.color
        return label
    }()
    
    lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(acctNameLabel)
        stackView.addArrangedSubview(acctDescriptionLabel)
        stackView.addArrangedSubview(acctTransactionTypeLabel)
        return stackView
    }()
    
    lazy var cellIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = VBlue.normal.color
        return imageView
    }()
    
    
    func setup() {
        contentView.addSubview(cellIcon)
        contentView.addSubview(detailsStackView)
        applyConstraints()
    }
    
    func configureCell(acctModel: AccountInfoViewModel) {
        acctNameLabel.text = acctModel.name
        acctDescriptionLabel.text = acctModel.description
        acctTransactionTypeLabel.text = acctModel.transactionType
        cellIcon.image = acctModel.uiIcon
    }
    
    private func applyConstraints() {
        cellIcon.snp.makeConstraints {
            $0.height.width.equalTo(25)
            $0.top.leading.equalToSuperview().inset(15)
        }
        detailsStackView.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview().inset(15)
            $0.leading.equalTo(cellIcon.snp.trailing).offset(15)
        }
    }
}

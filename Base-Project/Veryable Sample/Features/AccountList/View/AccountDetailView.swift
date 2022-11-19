//
//  AccountDetailView.swift
//  Veryable Sample
//
//  Created by Nikhil Khandelwal on 11/17/22.
//  Copyright © 2022 Veryable Inc. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol AccountDetailDelegate: AnyObject {
    func doneButtonClicked()
}

class AccountDetailView: UIView {
    
    //MARK: Private members
    private weak var del: AccountDetailDelegate?
    
    //MARK: Inits
    init(delegate: AccountDetailDelegate, viewModel: AccountInfoViewModel) {
        super.init(frame: .zero)
        self.del = delegate
        setup()
        configureUI(withInfomodel: viewModel)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    //MARK: Lazy Loads
    private lazy var typeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = VBlue.normal.color
        addSubview(imageView)
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .vryAvenirNextDemiBold(16)
        label.textColor = VGrey.dark.color
        addSubview(label)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .vryAvenirNextRegular(14)
        label.textColor = VGrey.normal.color
        addSubview(label)
        return label
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "Done".uppercased()
        button.setTitle("Done".uppercased(), for: .normal)
        button.titleLabel?.font = .vryAvenirNextBold(16)
        button.titleLabel?.textColor = ViewColor.surface.color
        button.backgroundColor = VBlue.normal.color
        button.layer.cornerRadius = 2
        button.layer.masksToBounds = false
        button.layer.shadowRadius = 12;
        button.layer.shadowColor = VGrey.dark.color.cgColor
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        addSubview(button)
        return button
    }()


    private func setup() {
        backgroundColor = ViewColor.background.color
        applyConstraints()
    }
        
    private func configureUI(withInfomodel: AccountInfoViewModel) {
        nameLabel.text = withInfomodel.name
        descriptionLabel.text = withInfomodel.description
        typeIcon.image = withInfomodel.uiIcon
    }
    
    private func applyConstraints() {
        typeIcon.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.centerX.equalTo(self)
            $0.top.equalToSuperview().offset(125)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(typeIcon.snp.bottom).offset(15)
        }

        descriptionLabel.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        
        doneButton.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.height.equalTo(60)
            $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide).inset(25)
        }
    }
    
    //MARK: Public API
    @objc func buttonAction(sender: UIButton) {
        del?.doneButtonClicked()
    }
}

//
//  AccountListView.swift
//  Veryable Sample
//
//  Created by Isaac Sheets on 5/27/21.
//  Copyright © 2021 Veryable Inc. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Combine

protocol AccountListDelegate: AnyObject {
    func rowSelectedModel(model: AccountInfoViewModel)
    func failedToReceiveAccountInfo()
}

struct TableSectionDataModel {
    var type: AccountType
    var data: [AccountInfoViewModel]
    
    var heading: String {
        switch type {
        case .bank: return "Bank Accounts"
        case .card: return "Cards"
        }
    }
}

class AccountListView: UIView {
    
    //MARK: Public API
    var accountService: AccountService = AccountService()
    
    //MARK: Private members
    private weak var del: AccountListDelegate?
    private var cancellable : AnyCancellable?

    //MARK: Lazy Loads
    lazy var tableSectionModel: [TableSectionDataModel] = []
    let tableView = UITableView()


    //MARK: Inits
    init(delegate: AccountListDelegate) {
        self.del = delegate
        super.init(frame: .zero)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        backgroundColor = ViewColor.background.color
        setupTableView()
        applyConstraints()
        fetchAccounts()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        } else {
            tableView.contentInset = .zero
            tableView.automaticallyAdjustsScrollIndicatorInsets = false
        }
        tableView.register(AccountListTableViewCell.self, forCellReuseIdentifier: "AccountListTableViewCell")
        addRefreshAccountControl()
        addSubview(tableView)
    }
    
    private func addRefreshAccountControl() {
        let refershControl = UIRefreshControl()
        tableView.refreshControl = refershControl
        refershControl.addTarget(self, action: #selector(fetchAccounts), for: .valueChanged)
    }
    
    private func applyConstraints() {
        tableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(safeAreaInsets)
        }
    }
    
    @objc private func fetchAccounts() {
        cancellable = accountService.fetchAccountsInformation()
            .sink(receiveCompletion: { status in
                switch status {
                case .finished:
                    DispatchQueue.main.async {
                        self.tableView.refreshControl?.endRefreshing()
                    }
                case .failure( _):
                    self.del?.failedToReceiveAccountInfo()
                }
            }, receiveValue: { receivedAccounts in
                self.updateWithAccountData(withData: receivedAccounts)
            })
    }
    
    func updateWithAccountData(withData: [AccountInfoViewModel]) {
        accountService.accounts = withData
        let groupedData = Dictionary(grouping: withData, by: { $0.type.rawValue })
        for accountType in AccountType.allCases {
            tableSectionModel.append(
                TableSectionDataModel(
                    type: accountType,
                    data: groupedData[accountType.rawValue] ?? []
                )
            )
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension AccountListView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableSectionModel[section].data.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableSectionModel.count
    }
        
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = UIView()
        sectionView.backgroundColor = VGrey.disabled.color
        
        let sectionTitle = UILabel()
        sectionTitle.text = tableSectionModel[section].heading
        sectionTitle.font = .vryAvenirNextBold(16)
        sectionTitle.textColor = VGrey.dark.color
        
        sectionView.addSubview(sectionTitle)
        
        sectionTitle.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview()
        }
        
        return sectionView
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AccountListTableViewCell") as? AccountListTableViewCell else {
            return UITableViewCell()
        }
        let model = tableSectionModel[indexPath.section].data[indexPath.row]
        cell.configureCell(acctModel: model)
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = tableSectionModel[indexPath.section].data[indexPath.row]
        del?.rowSelectedModel(model: model)
    }
}

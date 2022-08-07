//
//  FAQListViewController.swift
//  MaxiDigital-Case
//
//  Created by Yasin Akbas on 7.08.2022.
//  Copyright © 2022 com.yasinkbas.MaxiDigital-Case. All rights reserved.
//

import UIKit
import UILab
import CommonKit

protocol FAQListViewInterface: AnyObject {
    func prepareUI()
    func reloadData()
    func reloadItems(at indexes: [Int])
}

extension FAQListViewController {
    enum CellType: Int {
        case headerCell = 0
        case faqCell
    }
    
    enum Configs {
        enum TableView {
            static let estimatedRowHeight: CGFloat = 100
            static let rowHeight: CGFloat = UITableView.automaticDimension
            
            static let contentInset: UIEdgeInsets = .init(top: -50, left: 0, bottom: 50, right: 0)
        }
        
        enum Gradient {
            static let colors: [Any] = [Colors.lightBlue.cgColor, Colors.darkBlue.cgColor]
            static let startPoint: CGPoint = CGPoint(x: 0, y: 0)
            static let endPoint: CGPoint = CGPoint(x: 0, y: 1)
        }
    }
}

class FAQListViewController: UIViewController {
    var presenter: FAQListPresenterInterface!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = Configs.TableView.estimatedRowHeight
        tableView.rowHeight = Configs.TableView.rowHeight
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = Configs.TableView.contentInset
        
        tableView.register(FAQListCell.self, forCellReuseIdentifier: "FAQListCell")
        tableView.register(FAQListHeaderCell.self, forCellReuseIdentifier: "FAQListHeaderCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - FAQListViewInterface
extension FAQListViewController: FAQListViewInterface { 
    func prepareUI() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = Configs.Gradient.colors
        gradientLayer.startPoint = Configs.Gradient.startPoint
        gradientLayer.endPoint = Configs.Gradient.endPoint
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.addSubview(tableView)
        tableView.set(.leadingOf(view), .topOf(view), .trailingOf(view), .bottomOf(view))
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func reloadItems(at indices: [Int]) {
        let indexPaths = indices.map { IndexPath(row: $0, section: 1) }
        tableView.reloadRows(at: indexPaths, with: .automatic)
    }
}

// MARK: - UITableViewDelegate
extension FAQListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension FAQListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case CellType.headerCell.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FAQListHeaderCell", for: indexPath) as? FAQListHeaderCell else { return UITableViewCell() }
            cell.presenter = FAQListHeaderCellPresenter(view: cell)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FAQListCell") as? FAQListCell else {
                return UITableViewCell()
            }
            cell.presenter = FAQListCellPresenter(view: cell, arguments: presenter.faqListCellArguments(for: indexPath.row))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRows(for: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter.numberOfSections
    }
}

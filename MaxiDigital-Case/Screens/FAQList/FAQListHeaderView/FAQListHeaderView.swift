//
//  FAQListHeaderCellViewController.swift
//  MaxiDigital-Case
//
//  Created by Yasin Akbas on 7.08.2022.
//  Copyright © 2022 com.yasinkbas.MaxiDigital-Case. All rights reserved.
//

import UIKit

protocol FAQListHeaderCellInterface: AnyObject {
    func prepareUI()
}

extension FAQListHeaderCell {
    enum Configs {
        enum TitleLabel {
            static let text: String = "FAQ"
            
            static let top: CGFloat = 10
            static let bottom: CGFloat = 50
        }
    }
}

class FAQListHeaderCell: UITableViewCell {
    var presenter: FAQListHeaderCellPresenterInterface! {
        didSet {
            presenter.load()
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Configs.TitleLabel.text
        label.font = .systemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()
}

// MARK: - FAQListHeaderCellInterface
extension FAQListHeaderCell: FAQListHeaderCellInterface {
    func prepareUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        addSubview(titleLabel)
        titleLabel.set(
            .centerXOf(self),
            .topOf(self, Configs.TitleLabel.top),
            .bottomOf(self, Configs.TitleLabel.bottom)
        )
    }
}

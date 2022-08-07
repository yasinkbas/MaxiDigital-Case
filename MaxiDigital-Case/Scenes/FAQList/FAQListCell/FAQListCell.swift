//
//  FAQListCellViewController.swift
//  MaxiDigital-Case
//
//  Created by Yasin Akbas on 7.08.2022.
//  Copyright © 2022 com.yasinkbas.MaxiDigital-Case. All rights reserved.
//

import UIKit

protocol FAQListCellInterface: AnyObject {
    func prepareUI()
    func setQuestionLabel(text: String)
    func setAnswerLabel(text: String)
    func setAnswerLabelVisibility(isHidden: Bool)
    func setExpandedStatusButtonStyle(isExpanded: Bool)
}

extension FAQListCell {
    enum Configs {
        enum ContainerView {
            static let leading: CGFloat = 20
            static let top: CGFloat = 8
            static let trailing: CGFloat = 20
            static let bottom: CGFloat = 8
        }
        enum ContainerStackView {
            static let padding: CGFloat = 16
            static let spacing: CGFloat = 16
        }
        
        enum ExpandedStatusButton {
            static let plusImage = UIImage(named: "plus")
            static let minusImage = UIImage(named: "minus")
            static let width: CGFloat = 20
            static let height: CGFloat = 20
            static let trailing: CGFloat = 8
        }
        
        enum QuestionLabel {
            static let leading: CGFloat = 8
            static let trailing: CGFloat = 8
        }
    }
}

class FAQListCell: UITableViewCell {
    var presenter: FAQListCellPresenterInterface! {
        didSet {
            presenter.load()
        }
    }
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .white
        stackView.spacing = Configs.ContainerStackView.spacing
        return stackView
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var questionView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var expandedStatusButton: UIButton = {
        let button = UIButton()
        return button
    }()
}

// MARK: - FAQListCellInterface
extension FAQListCell: FAQListCellInterface { 
    func prepareUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        addSubview(containerView)
        containerView.set(
            .leadingOf(self, Configs.ContainerView.leading),
            .topOf(self, Configs.ContainerView.top),
            .trailingOf(self, Configs.ContainerView.trailing),
            .bottomOf(self, Configs.ContainerView.bottom)
        )
        
        addSubview(containerStackView)
        containerStackView.set(
            .leadingOf(containerView, Configs.ContainerStackView.padding),
            .topOf(containerView, Configs.ContainerStackView.padding),
            .trailingOf(containerView, Configs.ContainerStackView.padding),
            .bottomOf(containerView, Configs.ContainerStackView.padding)
        )
        
        questionView.addSubview(expandedStatusButton)
        expandedStatusButton.set(
            .trailingOf(questionView, Configs.ExpandedStatusButton.trailing),
            .centerYOf(questionView),
            .width(Configs.ExpandedStatusButton.width),
            .height(Configs.ExpandedStatusButton.height)
        )
        
        questionView.addSubview(questionLabel)
        questionLabel.set(
            .leadingOf(questionView, Configs.QuestionLabel.leading),
            .topOf(questionView),
            .bottomOf(questionView),
            .trailing(expandedStatusButton.leading, Configs.QuestionLabel.trailing)
        )
        
        containerStackView.addArrangedSubview(questionView)
        containerStackView.addArrangedSubview(answerLabel)
    }
    
    func setQuestionLabel(text: String) {
        questionLabel.text = text
    }
    
    func setAnswerLabel(text: String) {
        answerLabel.text = text
    }
    
    func setAnswerLabelVisibility(isHidden: Bool) {
        answerLabel.isHidden = isHidden
    }
    
    func setExpandedStatusButtonStyle(isExpanded: Bool) {
        expandedStatusButton.setImage(
            isExpanded
            ? Configs.ExpandedStatusButton.minusImage
            : Configs.ExpandedStatusButton.plusImage,
            for: .normal
        )
    }
}

//
//  FAQListCellPresenter.swift
//  MaxiDigital-Case
//
//  Created by Yasin Akbas on 7.08.2022.
//  Copyright © 2022 com.yasinkbas.MaxiDigital-Case. All rights reserved.
//

import Foundation

protocol FAQListCellPresenterInterface: AnyObject {
    func load()
}

struct FAQListCellPresenterArguments {
    let faq: FAQ
    let isSelected: Bool
}

class FAQListCellPresenter {
    private weak var view: FAQListCellInterface?
    private let arguments: FAQListCellPresenterArguments

    init(view: FAQListCellInterface, arguments: FAQListCellPresenterArguments) {
        self.view = view
        self.arguments = arguments
    }
}

// MARK: - FAQListCellPresenterInterface
extension FAQListCellPresenter: FAQListCellPresenterInterface {
    func load() {
        view?.prepareUI()
        view?.setQuestionLabel(text: arguments.faq.question)
        view?.setAnswerLabel(text: arguments.faq.answer)
        view?.setAnswerLabelVisibility(isHidden: !arguments.isSelected)
        view?.setExpandedStatusButtonStyle(isExpanded: arguments.isSelected)
    }
}

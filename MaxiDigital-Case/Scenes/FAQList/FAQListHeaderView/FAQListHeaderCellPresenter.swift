//
//  FAQListHeaderCellPresenter.swift
//  MaxiDigital-Case
//
//  Created by Yasin Akbas on 7.08.2022.
//  Copyright © 2022 com.yasinkbas.MaxiDigital-Case. All rights reserved.
//

import Foundation

protocol FAQListHeaderCellPresenterInterface: AnyObject {
    func load()
}

class FAQListHeaderCellPresenter {
    private weak var view: FAQListHeaderCellInterface?

    init(view: FAQListHeaderCellInterface) {
        self.view = view
    }
}

// MARK: - FAQListHeaderCellPresenterInterface
extension FAQListHeaderCellPresenter: FAQListHeaderCellPresenterInterface {
    func load() {
        view?.prepareUI()
    }
}

//
//  FAQListPresenter.swift
//  MaxiDigital-Case
//
//  Created by Yasin Akbas on 7.08.2022.
//  Copyright © 2022 com.yasinkbas.MaxiDigital-Case. All rights reserved.
//

import Foundation

protocol FAQListPresenterInterface: AnyObject {
    var numberOfSections: Int { get }
    
    func viewDidLoad()
    func faqListCellArguments(for index: Int) -> FAQListCellPresenterArguments
    func numberOfRows(for section: Int) -> Int
    func didSelectRowAt(index: IndexPath)
}

extension FAQListPresenter {
    enum Configs {
        static let numberOfSections: Int = 2
        static let headerCellCount: Int = 1
    }
}

class FAQListPresenter {
    private weak var view: FAQListViewInterface?
    private let router: FAQListRouterInterface
    private let interactor: FAQListInteractorInterface
    
    private var faqs: [FAQ] = []
    private var expandedFaqIndex: Int?

    init(
        view: FAQListViewInterface,
        router: FAQListRouterInterface,
        interactor: FAQListInteractorInterface
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - FAQListPresenterInterface
extension FAQListPresenter: FAQListPresenterInterface {
    var numberOfSections: Int { Configs.numberOfSections }
    
    func viewDidLoad() {
        view?.prepareUI()
        faqs = interactor.fetchQuestionsAndAswers()
        view?.reloadData()
    }
    
    func faqListCellArguments(for index: Int) -> FAQListCellPresenterArguments {
        .init(faq: faqs[index], isSelected: index == expandedFaqIndex)
    }
    
    func didSelectRowAt(index: IndexPath) {
        guard index.section != 0 else { return }
        guard index.row != expandedFaqIndex else {
            expandedFaqIndex = nil
            view?.reloadItems(at: [index.row])
            return
        }
        
        var reloadIndexes = [index.row]
        if let oldExpandedFaqIndex = expandedFaqIndex {
            reloadIndexes.append(oldExpandedFaqIndex)
        }
        expandedFaqIndex = index.row
        view?.reloadItems(at: reloadIndexes)
    }
    
    func numberOfRows(for section: Int) -> Int {
        switch section {
        case FAQListViewController.CellType.headerCell.rawValue:
            return Configs.headerCellCount
        case FAQListViewController.CellType.faqCell.rawValue:
            return faqs.count
        default:
            return .zero
        }
    }
}

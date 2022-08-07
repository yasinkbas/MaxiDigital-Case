//
//  FAQListPresenterTests.swift
//  MaxiDigital-Case
//
//  Created by Yasin Akbas on 7.08.2022.
//  Copyright © 2022 com.yasinkbas.MaxiDigital-Case. All rights reserved.
//

@testable import MaxiDigital_Case
import XCTest

extension FAQListPresenterTests {
    enum Dummies {
        static let faqData: [FAQ] = [
            .init(question: "q1", answer: "a1"),
            .init(question: "q2", answer: "a2")
        ]
    }
    
    enum CellIndex: Int {
        case headerCell = 0
        case faqCell
    }
}

final class FAQListPresenterTests: XCTestCase {
    var view: MockFAQListViewController!
    var router: MockFAQListRouter!
    var interactor: MockFAQListInteractor!
    var presenter: FAQListPresenter!
    
    override func setUp() {
        super.setUp()
        view = .init()
        router = .init()
        interactor = .init()
        presenter = .init(view: view, router: router, interactor: interactor)
    }
    
    func test_viewDidLoad_InvokesRequiredMethods() {
        interactor.stubbedFetchQuestionsAndAswersResult = Dummies.faqData
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.invokedPrepareUI)
        XCTAssertTrue(interactor.invokedFetchQuestionsAndAswers)
        XCTAssertEqual(interactor.fetchQuestionsAndAswers().first?.question, "q1")
        XCTAssertEqual(interactor.fetchQuestionsAndAswers().first?.answer, "a1")
        XCTAssertTrue(view.invokedReloadData)
    }
    
    func test_faqListCellArguments_ReturnsCorrectValue() {
        interactor.stubbedFetchQuestionsAndAswersResult = Dummies.faqData
        presenter.viewDidLoad()
        
        XCTAssertEqual(presenter.faqListCellArguments(for: 1).faq.question, "q2")
        XCTAssertEqual(presenter.faqListCellArguments(for: 1).faq.answer, "a2")
        XCTAssertEqual(presenter.faqListCellArguments(for: 1).isSelected, false)
    }
    
    func test_didSelectRowAt_SectionIsZero_DoesNotInvokeReloadItemsMethod() {
        presenter.didSelectRowAt(index: .init(row: 0, section: 0))
        
        XCTAssertFalse(view.invokedReloadItems)
    }
    
    func test_didSelectRowAt_SectionIsNotZero_ExpandedIndexIsNil_InvokesReloadItemsMethod() {
        presenter.didSelectRowAt(index: .init(row: 0, section: 1))
        
        XCTAssertTrue(view.invokedReloadItems)
        XCTAssertEqual(view.invokedReloadItemsParameters?.indexes, [0])
    }
    
    func test_didSelectRowAt_SectionIsNotZero_ExpandedIndexIsNotNil_InvokesReloadItemsMethod() {
        presenter.didSelectRowAt(index: .init(row: 0, section: 1))
        presenter.didSelectRowAt(index: .init(row: 1, section: 1))
        
        XCTAssertTrue(view.invokedReloadItems)
        XCTAssertEqual(view.invokedReloadItemsParameters?.indexes, [1,0])
    }
    
    func test_didSelectRowAt_SectionIsNotZero_ExpandedIndexIsNotNil_CalledMultipleTimes_InvokesReloadItemsMethod() {
        presenter.didSelectRowAt(index: .init(row: 0, section: 1))
        presenter.didSelectRowAt(index: .init(row: 1, section: 1))
        presenter.didSelectRowAt(index: .init(row: 2, section: 1))
        presenter.didSelectRowAt(index: .init(row: 3, section: 1))
        
        XCTAssertTrue(view.invokedReloadItems)
        XCTAssertEqual(view.invokedReloadItemsParameters?.indexes, [3,2])
    }
    
    func test_numberOfRows_SectionIsHeaderCell_ReturnsCorrectValue() {
        XCTAssertEqual(presenter.numberOfRows(for: CellIndex.headerCell.rawValue), 1)
    }
    
    func test_numberOfRows_SectionIsFAQCell_EmptyFaqData_ReturnsZero() {
        XCTAssertEqual(presenter.numberOfRows(for: CellIndex.faqCell.rawValue), 0)
    }
    
    func test_numberOfRows_SectionIsFAQCell_FilledFAQData_ReturnsCorrectValue() {
        interactor.stubbedFetchQuestionsAndAswersResult = Dummies.faqData
        presenter.viewDidLoad()
        
        XCTAssertEqual(presenter.numberOfRows(for: CellIndex.faqCell.rawValue), 2)
    }
}

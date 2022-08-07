//
//  MockFAQListView.swift
//  MaxiDigital-Case
//
//  Created by Yasin Akbas on 7.08.2022.
//  Copyright © 2022 com.yasinkbas.MaxiDigital-Case. All rights reserved.
//

@testable import MaxiDigital_Case

final class MockFAQListViewController: FAQListViewInterface {

    var invokedPrepareUI = false
    var invokedPrepareUICount = 0

    func prepareUI() {
        invokedPrepareUI = true
        invokedPrepareUICount += 1
    }

    var invokedReloadData = false
    var invokedReloadDataCount = 0

    func reloadData() {
        invokedReloadData = true
        invokedReloadDataCount += 1
    }

    var invokedReloadItems = false
    var invokedReloadItemsCount = 0
    var invokedReloadItemsParameters: (indexes: [Int], Void)?
    var invokedReloadItemsParametersList = [(indexes: [Int], Void)]()

    func reloadItems(at indexes: [Int]) {
        invokedReloadItems = true
        invokedReloadItemsCount += 1
        invokedReloadItemsParameters = (indexes, ())
        invokedReloadItemsParametersList.append((indexes, ()))
    }
}

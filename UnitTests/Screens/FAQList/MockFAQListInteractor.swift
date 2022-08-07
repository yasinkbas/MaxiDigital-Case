//
//  MockFAQListInteractor.swift
//  MaxiDigital-Case
//
//  Created by Yasin Akbas on 7.08.2022.
//  Copyright © 2022 com.yasinkbas.MaxiDigital-Case. All rights reserved.
//

@testable import MaxiDigital_Case

final class MockFAQListInteractor: FAQListInteractorInterface {

    var invokedFetchQuestionsAndAswers = false
    var invokedFetchQuestionsAndAswersCount = 0
    var stubbedFetchQuestionsAndAswersResult: [FAQ]! = []

    func fetchQuestionsAndAswers() -> [FAQ] {
        invokedFetchQuestionsAndAswers = true
        invokedFetchQuestionsAndAswersCount += 1
        return stubbedFetchQuestionsAndAswersResult
    }
}

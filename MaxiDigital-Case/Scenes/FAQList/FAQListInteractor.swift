//
//  FAQListInteractor.swift
//  MaxiDigital-Case
//
//  Created by Yasin Akbas on 7.08.2022.
//  Copyright © 2022 com.yasinkbas.MaxiDigital-Case. All rights reserved.
//

import Foundation

protocol FAQListInteractorInterface: AnyObject {
    func fetchQuestionsAndAswers() -> [FAQ]
}

final class FAQListInteractor { }

// MARK: - FAQListInteractorInterface
extension FAQListInteractor: FAQListInteractorInterface { 
    func fetchQuestionsAndAswers() -> [FAQ] {
        FAQ.data
    }
}

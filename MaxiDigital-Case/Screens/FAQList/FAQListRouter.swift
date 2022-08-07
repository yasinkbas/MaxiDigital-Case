//
//  FAQListRouter.swift
//  MaxiDigital-Case
//
//  Created by Yasin Akbas on 7.08.2022.
//  Copyright © 2022 com.yasinkbas.MaxiDigital-Case. All rights reserved.
//

import UIKit

protocol FAQListRouterInterface: AnyObject {
    
}

final class FAQListRouter {
    static func createModule() -> FAQListViewController {
        let view = FAQListViewController()
        let interactor = FAQListInteractor()
        let router = FAQListRouter()
        let presenter = FAQListPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        return view
    }
}

// MARK: - FAQListRouterInterface
extension FAQListRouter: FAQListRouterInterface {
    
}


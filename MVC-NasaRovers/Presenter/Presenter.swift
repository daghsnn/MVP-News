//
//  Presenter.swift
//  MVC-NasaRovers
//
//  Created by Hasan Dag on 24.03.2022.
//

import UIKit
import Combine

protocol PresenterDelegate {
    func getNews(keyword:String?, page:Int?)

}

final class Presenter : PresenterDelegate {
    
    weak var viewDelegate : ViewControllerProtocol?

    init(view : ViewControllerProtocol) {
        self.viewDelegate = view
    }
    
    func getNews(keyword:String?, page:Int?) {
        print("get roveri tetikledi vc")
        NetworkClient.shared.getNewswithAllEndPoints(.popular, page: page, keyword: keyword) {(model) in
            self.viewDelegate?.getNewsModel(model: model)
        }
    }
    
    
}

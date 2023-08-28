//
//  MainPresenter.swift
//  TestTask
//
//  Created by Daniil Chemaev on 26.08.2023.
//

import Foundation

protocol AdvertisementsViewProtocol: AnyObject {
    func refresh()
}

protocol AdvertisementsPresenterProtocol {
    var view: AdvertisementsViewProtocol? { get set }
    var coordinator: CoordinatorProtocol? { get set }

    var numberOfAdvertisements: Int { get }

    init(view: AdvertisementsViewProtocol?, coordinator: CoordinatorProtocol?)

    func viewDidLoadEvent()
    func configure()
}

class AdvertisementsPresenter: AdvertisementsPresenterProtocol {
    var view: AdvertisementsViewProtocol?
    var coordinator: CoordinatorProtocol?

    private var advertisements: [Advertisement] = []

    var numberOfAdvertisements: Int {
        return advertisements.count
    }

    required init(view: AdvertisementsViewProtocol?,
                  coordinator: CoordinatorProtocol?) {
        self.view = view
        self.coordinator = coordinator
    }

    func viewDidLoadEvent() {
        advertisements = [
            Advertisement(id: "1", title: "1", price: "2", location: "2", imageURL: "123", createdDate: "123"),
            Advertisement(id: "1", title: "1", price: "2", location: "2", imageURL: "123", createdDate: "123"),
            Advertisement(id: "1", title: "1", price: "2", location: "2", imageURL: "123", createdDate: "123"),
            Advertisement(id: "1", title: "1", price: "2", location: "2", imageURL: "123", createdDate: "123"),
            Advertisement(id: "1", title: "1", price: "2", location: "2", imageURL: "123", createdDate: "123"),
            Advertisement(id: "1", title: "1", price: "2", location: "2", imageURL: "123", createdDate: "123"),
            Advertisement(id: "1", title: "1", price: "2", location: "2", imageURL: "123", createdDate: "123"),
            Advertisement(id: "1", title: "1", price: "2", location: "2", imageURL: "123", createdDate: "123"),
            Advertisement(id: "1", title: "1", price: "2", location: "2", imageURL: "123", createdDate: "123"),
            Advertisement(id: "1", title: "1", price: "2", location: "2", imageURL: "123", createdDate: "123")
        ]
    }

    func configure() {
        view?.refresh()
    }
}

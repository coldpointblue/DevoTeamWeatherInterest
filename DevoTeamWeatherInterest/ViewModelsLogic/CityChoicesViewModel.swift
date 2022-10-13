//  ----------------------------------------------------
//
//  CityChoicesViewModel.swift
//  Version 1.0
//
//  Unique ID:  69FBA141-60FC-4233-9E66-B6F99E362DB4
//
//  part of the DevoTeamWeatherInterest™ product.
//
//  Written in Swift 5.0 on macOS 12.6
//
//  https://github.com/coldpointblue
//  Created by Hugo Diaz on 12/10/22.
//
//  ----------------------------------------------------

//  ----------------------------------------------------
/*  Goal explanation:  Business Logic. Use data.   */
//  ----------------------------------------------------

import SwiftUI
import Combine

class CityChoicesViewModel: ObservableObject {
    @Published var jsonDataTruthInstance: AnyCityFetched =
        AnyCityFetched()  // = try!

    // Vars used in UI…
    @Published var statusFlash: String = ""
    @Published var totalShown: String = ""

    // Init…
    private let webSourceCitiesWeather: CitiesProtocolType
    private var cancellables = Set<AnyCancellable>()

    init(cityInfoType: CitiesProtocolType = CityInfoService()) {
        self.webSourceCitiesWeather = cityInfoType
    }

    // Messages as specific Input & Output triggers…
    enum SpecificInput {
        case viewDidAppear
        case refreshButtonTapped
    }
    let inputUpdateMessage: PassthroughSubject<CityChoicesViewModel.SpecificInput, Never> = .init()

    enum SpecificOutput {
        case downloadFailed(error: Error)
        case downloadCityForecastsSuccess(entireCitiesList: AnyCityFetched)
    }
    private let outputUpdateMessage: PassthroughSubject<SpecificOutput, Never> = .init()

    // Moving data through…
    func transform(inputTrigger: AnyPublisher<SpecificInput, Never>) -> AnyPublisher<SpecificOutput, Never> {
        inputTrigger.sink { [weak self] event in
            switch event {
            case .viewDidAppear, .refreshButtonTapped:
                self?.nowGetCityForecastsJSON()
            }
        }.store(in: &cancellables)
        return outputUpdateMessage.eraseToAnyPublisher()
    }

    fileprivate func nowGetCityForecastsJSON() {
        webSourceCitiesWeather.downloadCityInfoList()
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.outputUpdateMessage.send(.downloadFailed(error: error))
                }
            } receiveValue: { [weak self] everyCurrentCityForecast in
                self?.outputUpdateMessage
                    .send(.downloadCityForecastsSuccess(entireCitiesList: everyCurrentCityForecast))
            }.store(in: &cancellables)
    }

    func bindJSONData() {
        let output = self.transform(inputTrigger: inputUpdateMessage.eraseToAnyPublisher())
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                switch event {
                case .downloadCityForecastsSuccess(let everyCityForecastInList):
                    self?.jsonDataTruthInstance = everyCityForecastInList
                case .downloadFailed(let error):
                    self?.statusFlash = error.localizedDescription
                }
            }
            .store(in: &cancellables)
    }
}

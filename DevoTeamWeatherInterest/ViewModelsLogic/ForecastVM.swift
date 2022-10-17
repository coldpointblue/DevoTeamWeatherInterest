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

final class ForecastVM: ObservableObject {
    @Published var liveDataTruth = AnyForecastFetched()

    // Vars used in UI…
    @Published var statusFlash: String = ""
    @Published var totalShown: String = ""

    private var cancellables = Set<AnyCancellable>()

    // Init…
    private let updatedWeather: AnyCityWeather

    init(liveCityChoicesVM: AnyCityWeather = CityWeather()) {
        self.updatedWeather = liveCityChoicesVM
    }

    // Messages as specific Input & Output triggers…
    enum SpecificInput {
        case viewDidAppear
    }
    let inputUpdateMessage: PassthroughSubject<ForecastVM.SpecificInput, Never> = .init()

    enum SpecificOutput {

        case downloadFailed(error: Error)

        case downloadCityForecastSuccess(currentForecast: AnyForecastFetched)
    }

    private let outputUpdateMessage: PassthroughSubject<SpecificOutput, Never> = .init()

    // Moving data through…
    func transform(inputTrigger: AnyPublisher<SpecificInput, Never>) -> AnyPublisher<SpecificOutput, Never> {

        inputTrigger.sink { [weak self] event in
            switch event {

            case .viewDidAppear:
                self?.fetchCityForecastsJSON()
            }
        }

        .store(in: &cancellables)

        return outputUpdateMessage.eraseToAnyPublisher()
    }

    fileprivate func fetchCityForecastsJSON() {
        updatedWeather.downloadCityWeather()
            .sink { [weak self] completion in

                if case .failure(let error) = completion {
                    self?.outputUpdateMessage.send(.downloadFailed(error: error))
                }
            }

            receiveValue: { [weak self] liveCityForecast in

                self?.outputUpdateMessage.send(
                    .downloadCityForecastSuccess(currentForecast: liveCityForecast)
                )
            }

            .store(in: &cancellables)
    }

    func bindJSONData() {
        let output = self.transform(inputTrigger: inputUpdateMessage.eraseToAnyPublisher())
        output
            .receive(on: DispatchQueue.main)
            .sink { [weak self] event in
                switch event {

                case .downloadCityForecastSuccess(let forecastProcessed):
                    self?.liveDataTruth = forecastProcessed

                case .downloadFailed(let error):
                    self?.statusFlash = error.localizedDescription

                }
            }

            .store(in: &cancellables)
    }
}

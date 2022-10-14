//  ----------------------------------------------------
//
//  DetailView.swift
//  Version 1.0
//
//  Unique ID:  985D2F44-0BD7-4087-B898-F4175847F602
//
//  part of the DevoTeamWeatherInterest™ product.
//
//  Written in Swift 5.0 on macOS 12.6
//
//  https://github.com/coldpointblue
//  Created by Hugo Diaz on 13/10/22.
//
//  ----------------------------------------------------

//  ----------------------------------------------------
/*  Goal explanation:  See one weather forecast in detail.   */
//  ----------------------------------------------------

import SwiftUI
import Combine

struct DetailView: View {
    @EnvironmentObject var cityForecastVM: ForecastVM
    var currentData: AnyForecastFetched { cityForecastVM
        .liveDataTruth }

    var uniqueCityID: String {
        String() // Identify a particular city by unique id for favouriteSymbolsSet.
    }
    static var favouriteSymbolsSet: Set<String> = []
    @State private var isFavourite = false

    var body: some View {

        VStack {
            VStack {
                Text("Weather Details")
                    .font(.title.bold())
                    .padding()
                    .font(.system(.callout, design: .monospaced))
                    .padding(.horizontal)
            }

            ZStack {
                Color.blue.ignoresSafeArea().opacity(0.3)

                VStack {
                    Spacer()
                    Group {
                        Text("Today's Weather")
                            .font(.system(.callout, design: .rounded))
                            .padding(.bottom)

                        temperatureSection()
                            .font(.system(.callout, design: .serif))
                    }.multilineTextAlignment(.center)

                    VStack {
                        Image(systemName: "cloud.snow")
                            .font(.largeTitle)

                        Text("Looks cold today! =P")
                    }
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .shadow(radius: 3)
                }

            }
            HStack {
                toggleFavouriteButton()
                Text("Favorite City?")
                Spacer()
            }
            Spacer()
            Image(uiImage: UIImage(named: World.photoDetail)!)
                .resizable().aspectRatio(4/3, contentMode: ContentMode.fill)

        }
        .onAppear {
            isFavourite = DetailView.favouriteSymbolsSet.contains(uniqueCityID)
        }
    }
}

extension DetailView {

    fileprivate func temperatureSection() -> some View {
        return VStack {
            VStack {
                Text(currentData.city?.name ?? "")
                    .font(.subheadline.bold())
                Text("Temperature Feels Like\n\(String(currentData .weatherList?[0].forecast?.feelsLike ?? 0.00))")
                Text("˚ Celsius")
                    .padding(.bottom, 3)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

extension DetailView {
    fileprivate func toggleFavouriteButton() -> some View {
        return Button {
            isFavourite.toggle()
            if isFavourite {
                DetailView.favouriteSymbolsSet.insert(uniqueCityID)
            } else {
                DetailView.favouriteSymbolsSet.remove(uniqueCityID)
            }
        } label: {
            Image(systemName: (isFavourite ? "heart.fill" : "heart"))
                .foregroundColor(isFavourite ? .red : .blue)
        }
        .padding(.leading)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
            .environmentObject(ForecastVM())
    }
}

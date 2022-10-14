//  ----------------------------------------------------
//
//  ContentView.swift
//  Version 1.0
//
//  Unique ID:  B3F2A833-98FF-44B6-8EAE-4500D84ED93D
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
/*  Goal explanation:  To display a list of cities and choose one
 to see that city's current weather report details.
 Use a search field to filter the listed choices of cities.
 Display a details weather report view popup with chosen city's info.
 */
//  ----------------------------------------------------

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var everyForecastVM: ForecastVM

    @State var isWeatherDetailShown = false

    let allCityNames = ["Östermalm <live>", "Uppsala <not live>", "Enköping <not live>", "Stockholm <not live>"]

    let debugging = World.DebugHelpers()

    var body: some View {
        let liveDataToo = everyForecastVM
            .liveDataTruth

        VStack {
            Image(uiImage: UIImage(named: World.photoWelcome)!)
                .resizable().aspectRatio(4/3, contentMode: ContentMode.fill)
            Group {
                showWelcome()
                Text(everyForecastVM.statusFlash)
                    .font(.system(.callout, design: .monospaced))

                Group(content: {
                    localCity(liveDataToo)
                    Text("\(allCityNames.count) other cities below\r")
                })
                .font(Font.headline.weight(.light))
                .multilineTextAlignment(.center)
            }

            VStack.init(alignment: SwiftUI.HorizontalAlignment.center) {
                listEveryCity()

            }
            .listStyle(.inset)
            Text(World.encouragement)
                .padding(.bottom)
                .font(.system(.footnote, design: .rounded))

            Spacer()
            #if PRODUCTION
            #else
            Text("network OK — UI unfinished")
            #endif
        }
        .onAppear(perform: {
            // Use the Combine robust automatic way to load JSON.
            everyForecastVM.bindJSONData()
            everyForecastVM.inputUpdateMessage.send(.viewDidAppear)
            print(liveDataToo)
        }
        )
        .sheet(isPresented: $isWeatherDetailShown) {
            DetailView()
        }
    }
}

// MARK: - Content list with cities and their weather forecasts.
extension ContentView {
    fileprivate func localCity(_ currentData: AnyForecastFetched) -> some View {
        return Text("""
                     \(currentData.city?.name
                        ?? World.noLocalCityName)
                     \(currentData.city?
                        .country ?? "")
                     """)
    }

    fileprivate  func listEveryCity() -> some View {
        return List {
            VStack {
                ForEach(allCityNames, id: \.self) { oneName in
                    Text(oneName)
                        .padding()
                        .onTapGesture {
                            isWeatherDetailShown.toggle()
                            print("Tapped \(oneName)") }
                }

            }
        }
        .listStyle(SidebarListStyle())
    }

    fileprivate func showWelcome() -> some View {
        return Text(World.welcome)
            .font(Font.title.weight(.bold))
            .multilineTextAlignment(.center)
            .font(.title)
            .padding()
            .foregroundStyle( LinearGradient(
                colors: rainbow(),
                startPoint: .leading,
                endPoint: .trailing
            ))
    }
}
// Colors for LinearGradient.
func rainbow() -> [Color] {
    return [.red, .orange, .yellow, .green, .blue, .indigo,
            Color(red: 0.929, green: 0.507, blue: 0.929, opacity: 1.0)]
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ForecastVM())
    }
}

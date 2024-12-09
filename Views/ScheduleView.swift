//
//  ScheduleView.swift
//  Scheduler
//
//  Created by Vikas Joshi on 08/12/24.
//

import SwiftUI

struct ScheduleView: View {
    @State private var contentHeight: CGFloat = 0 // Tracks content height dynamically
    @State private var offsetY: CGFloat = 0
    @StateObject var myViewModel = ScheduleViewModel()
    @State private var currentTeamName: String = "JULY 2023"

    var viewModel: ScheduleViewModel

    var body: some View {
        GeometryReader { geometry in
            content(in: geometry)
        }
        .coordinateSpace(name: "SCROLL")
        .onAppear(
            perform: {
                initialMethod()
            }
        )
    }

    func content(in geometry: GeometryProxy) -> some View {
        Group {
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(viewModel.appTeamSchedules) { team in
                        GameCard(game: team)
                            .background(
                                GeometryReader { cardGeo in
                                    let frame = cardGeo.frame(in: .global)

                                    if frame.minY <= geometry.safeAreaInsets.top + 300 &&
                                        frame.maxY >= geometry.safeAreaInsets.top + 300
                                    {
                                        DispatchQueue.main.async {
                                            self.currentTeamName = "\(team.gameYear)"
                                        }
                                    }

                                    return Color.clear
                                }
                            )
                    }
                }
            }
            .padding(.top, 60)
            .overlay(
                // Sticky Header
                VStack {
                    Button(action: {
                        //
                    }) {
                        HStack {
                            Image(systemName: "chevron.up")
                            Text(currentTeamName)
                            Image(systemName: "chevron.down")
                        }
                        .foregroundColor(.white)
                    }
                    .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .frame(height: 30)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hex: "#14181B"))
                    .offset(y: -offsetY)
                    .zIndex(1)
                }
                .edgesIgnoringSafeArea(.top),
                alignment: .top
            )
        }
    }

    private func initialMethod() {
        if myViewModel.appTeamSchedules.isEmpty {
            myViewModel.fetchSchedules()
        }

        if let firstTeam = viewModel.appTeamSchedules.first {
            currentTeamName = firstTeam.gameDate
        }
    }
}

#Preview {
    HomeView()
}

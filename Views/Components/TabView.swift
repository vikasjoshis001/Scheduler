//
//  TabView.swift
//  Scheduler
//
//  Created by Vikas Joshi on 08/12/24.
//

import SwiftUI

struct TabView: View {
    var viewModel: ScheduleViewModel
    @State private var selectedTab = 0

    var body: some View {
        HStack {
            Button(action: {
                selectedTab = 0
            }) {
                Text("Schedules")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
            .frame(maxWidth: .infinity)
            .overlay(
                selectedTab == 0 ? Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.yellow)
                    .padding(.top, 50)
                    : nil
            )

            Spacer()

            Button(action: {
                selectedTab = 1
            }) {
                Text("Games")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
            .frame(maxWidth: .infinity)
            .overlay(
                selectedTab == 1 ? Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.yellow)
                    .padding(.top, 50)
                    : nil
            )
        }
        .padding()

        // Content Views
        if selectedTab == 0 {
            ScheduleView(viewModel: viewModel)
        } else {
            GamesView()
        }
    }
}

#Preview {
    HomeView()
}

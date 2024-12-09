//
//  HomeView.swift
//  Scheduler
//
//  Created by Vikas Joshi on 08/12/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = ScheduleViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            let safeAreaTop = geometry.safeAreaInsets.top
            VStack(spacing: 0) {
                Text(viewModel.appTeamName)
                    .italic()
                    .font(.system(size: 20, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, safeAreaTop + 50)
                    .foregroundColor(.white)

                TabView(viewModel: viewModel)
            }
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.top)
        .onAppear(
            perform: viewModel.fetchSchedules
        )
    }
}

#Preview {
    HomeView()
}

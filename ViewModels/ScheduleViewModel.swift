//
//  ScheduleViewModel.swift
//  Scheduler
//
//  Created by Vikas Joshi on 08/12/24.
//

import Foundation

class ScheduleViewModel: ObservableObject {
    @Published var schedules: [ScheduleModel] = []
    @Published var appTeamSchedules: [MatchDetail] = []
    @Published var isLoading = false
    @Published var appTeamName: String = ""
    @Published var error: Error?

    func fetchSchedules() {
        isLoading = true

        // Simulate network call
        let result: Result<ScheduleResponse, Error> = NetworkManager.decodeData(
            from: "Schedule",
            type: ScheduleResponse.self
        )

        DispatchQueue.main.async {
            defer { self.isLoading = false } // Ensure loading stops after execution

            switch result {
            case .success(let response):
                self.handleSuccess(response: response)
            case .failure(let error):
                self.handleError(error)
            }
        }
    }

    private func handleSuccess(response: ScheduleResponse) {
        schedules = response.data.schedules

        let tids = Set(schedules.flatMap { [$0.homeTeam.tid, $0.visitorTeam.tid] })
        guard let randomTid = tids.randomElement() else { return }
        let appTeamId = randomTid
//        let appTeamId = "1610612738"

        let filteredSchedules = schedules.filter {
            $0.homeTeam.tid == appTeamId || $0.visitorTeam.tid == appTeamId
        }
        
        guard let homeTeam = filteredSchedules.first?.homeTeam.teamName else {
            return
        }
        self.appTeamName = homeTeam
        debugPrint(self.appTeamName)

        
        // Create the final format {schedules: [{}, {}]}
        filteredSchedules.map { match in
            self.generateMatchDetails(for: match)
        }
        
        debugPrint(self.appTeamSchedules)
    }

    private func handleError(_ error: Error) {
        self.error = error
        debugPrint("Error fetching schedules: \(error.localizedDescription)")
    }

    // Generate match details as a dictionary
    func generateMatchDetails(for match: ScheduleModel) {
        let dateTime = formatDateTime(from: match.gametime)
        
        let matchDetails = MatchDetail(
            id: match.uid,
            venueType: (match.arenaCity == match.homeTeam.teamCity) ? "home" : "away",
            status: getStatus(for: match.st),
            gameDate: dateTime?.date ?? "",
            gameTime: dateTime?.time ?? "",
            gameType: match.stt,
            homeTeamName: match.homeTeam.teamAbbreviation,
            visitorTeamName: match.visitorTeam.teamAbbreviation,
            homeTeamScore: match.homeTeam.score ?? "",
            visitorTeamScore: match.visitorTeam.score ?? "",
            matchSymbol: (match.arenaCity == match.homeTeam.teamCity) ? "vs" : "@", 
            currentTime: match.cl,
            gameYear: dateTime?.year ?? "",
            buyTicketUrl: match.buyTicketURL ?? ""
        )

        self.appTeamSchedules.append(matchDetails)
    }

    private func getStatus(for state: Int) -> String {
        switch state {
        case 1: return "future"
        case 2: return "live"
        default: return "past"
        }
    }
}

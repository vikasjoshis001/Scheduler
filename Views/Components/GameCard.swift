//
//  GameCard.swift
//  Scheduler
//
//  Created by Vikas Joshi on 08/12/24.
//

import SwiftUI

// MARK: - GameCard

struct GameCard: View {
    @State var game: MatchDetail

    var body: some View {
        VStack(spacing: 10) {
            if game.status == "live" {
                LiveMatchHeaderView(game: game)
            } else {
                PastMatchHeaderView(game: game)
            }

            HStack(alignment: .center, spacing: 30) {
                if game.venueType == "away" {
                    AwayMatch(game: game)
                } else {
                    HomeMatch(game: game)
                }
            }
            .padding(.vertical, 10)

            if game.status == "future"
                && game.venueType == "home"
            {
                Button(action: {
                    if let url = URL(string: game.buyTicketUrl) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    HStack {
                        Text("Buy tickets on".uppercased())
                        Text("ticketmaster").italic()
                    }
                    .font(.system(size: 18, weight: .semibold))
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/,
                           alignment: .center)
                    .padding(8)
                    .foregroundColor(.black)
                    .background(Color.white)
                    .cornerRadius(9999)
                }
            }
        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(Color(hex: "#272D33"))
        .cornerRadius(16)
        .padding(15)
    }
}

// MARK: - PastMatchHeaderView

struct PastMatchHeaderView: View {
    var game: MatchDetail

    var body: some View {
        HStack {
            Text(game.venueType.uppercased())
                .font(.system(size: 15, weight: .regular))
            DividerView()
            Text(game.gameDate.uppercased())
                .font(.system(size: 15, weight: .regular))
            DividerView()
            Text(game.gameType.uppercased())
                .font(.system(size: 15, weight: .regular))
        }
        .foregroundColor(.white)
    }
}

// MARK: - LiveMatchHeaderView

struct LiveMatchHeaderView: View {
    var game: MatchDetail

    var body: some View {
        HStack {
            Text(game.gameType)
                .font(.system(size: 15, weight: .regular))
            DividerView()
            Text(game.gameTime.uppercased())
                .font(.system(size: 15, weight: .regular))
        }
        .foregroundColor(.white)
    }
}

// MARK: - DividerView

struct DividerView: View {
    var body: some View {
        Text("")
            .overlay(
                Rectangle()
                    .frame(width: 1, height: 18)
                    .foregroundColor(.white)
            )
    }
}

// MARK: - TeamInfoView

struct TeamInfoView: View {
    let imageName: String
    let teamName: String
    let status: String

    var body: some View {
        VStack(spacing: 5) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
            if status != "future" {
                Text(teamName)
                    .italic()
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
            }
        }
    }
}

// MARK: - ScoreView

struct ScoreView: View {
    let team1Score: String
    let team2Score: String
    let team1Name: String
    let team2Name: String
    let matchSymbol: String
    let status: String

    var body: some View {
        VStack(spacing: 10) {
            if status == "live" {
                Text("LIVE")
                    .font(.system(size: 15, weight: .medium))
                    .padding(8)
                    .background(Color(hex: "#191B1D"))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .padding(.top, -15)
            }
            if status == "future" {
                FutureGameScoreView(matchSymbol: matchSymbol,
                                    team1Name: team1Name,
                                    team2Name: team2Name)
            } else {
                PastGameScoreView(team1Score: team1Score,
                                  team2Score: team2Score,
                                  matchSymbol: matchSymbol)
            }
        }
    }
}

// MARK: - PastGameScoreView

struct PastGameScoreView: View {
    let team1Score: String
    let team2Score: String
    let matchSymbol: String

    var body: some View {
        HStack {
            Text(team1Score)
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(.white)
            Text(matchSymbol)
                .font(.system(size: 25, weight: .light))
                .foregroundColor(.white)
            Text(team2Score)
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(.white)
        }
    }
}

// MARK: - FutureGameScoreView

struct FutureGameScoreView: View {
    let matchSymbol: String
    let team1Name: String
    let team2Name: String

    var body: some View {
        HStack {
            Text(team1Name)
                .italic()
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(.white)
            Text(matchSymbol)
                .font(.system(size: 25, weight: .light))
                .foregroundColor(.white)
            Text(team2Name)
                .italic()
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(.white)
        }
    }
}

// MARK: - AwayMatch

struct AwayMatch: View {
    var game: MatchDetail

    var body: some View {
        TeamInfoView(imageName: "csk",
                     teamName: game.homeTeamName,
                     status: game.status)
        ScoreView(team1Score: game.homeTeamScore,
                  team2Score: game.visitorTeamScore,
                  team1Name: game.homeTeamName,
                  team2Name: game.visitorTeamName,
                  matchSymbol: game.matchSymbol,
                  status: game.status)
        TeamInfoView(imageName: "punjab",
                     teamName: game.visitorTeamName,
                     status: game.status)
    }
}

// MARK: - HomeMatch

struct HomeMatch: View {
    var game: MatchDetail

    var body: some View {
        TeamInfoView(imageName: "punjab",
                     teamName: game.visitorTeamName,
                     status: game.status)
        ScoreView(team1Score: game.visitorTeamScore,
                  team2Score: game.homeTeamScore,
                  team1Name: game.visitorTeamName,
                  team2Name: game.homeTeamName,
                  matchSymbol: game.matchSymbol,
                  status: game.status)
        TeamInfoView(imageName: "csk",
                     teamName: game.homeTeamName,
                     status: game.status)
    }
}

#Preview {
    HomeView()
}

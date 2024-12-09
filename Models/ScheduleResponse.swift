//
//  ScheduleResponse.swift
//  Scheduler
//
//  Created by Vikas Joshi on 08/12/24.
//

import Foundation

struct ScheduleResponse: Codable {
    let data: Schedules
}

struct Schedules: Codable {
    let schedules: [ScheduleModel]
}

struct ScheduleModel: Codable {
    let uid: String
    let year: Int
    let leagueID: String
    let seasonID: String
    let gid: String
    let gcode: String
    let seri: String
    let isGameNecessary: String
    let gametime: String
    let cl: String
    let arenaName: String
    let arenaCity: String
    let arenaState: String
    let st: Int
    let stt: String
    let ppdst: String
    let buyTicket: String?
    let buyTicketURL: String?
    let logoURL: String?
    let hide: Bool
    let gameState: String
    let gameSubtype: String?
    let homeTeam: Team
    let visitorTeam: Team
//
    enum CodingKeys: String, CodingKey {
        case uid, year, gid, gcode, seri, cl, st, stt, ppdst, hide
        case leagueID = "league_id"
        case seasonID = "season_id"
        case isGameNecessary = "is_game_necessary"
        case gametime
        case arenaName = "arena_name"
        case arenaCity = "arena_city"
        case arenaState = "arena_state"
        case buyTicket = "buy_ticket"
        case buyTicketURL = "buy_ticket_url"
        case logoURL = "logo_url"
        case gameState = "game_state"
        case gameSubtype = "game_subtype"
        case homeTeam = "h"
        case visitorTeam = "v"
    }
}

// Team Object
struct Team: Codable {
    let tid: String
    let record: String
    let teamAbbreviation: String
    let teamName: String
    let teamCity: String
    let score: String?
    let istGroup: String?

    enum CodingKeys: String, CodingKey {
        case tid
        case record = "re"
        case teamAbbreviation = "ta"
        case teamName = "tn"
        case teamCity = "tc"
        case score = "s"
        case istGroup = "ist_group"
    }
}

struct MatchDetail: Codable, Identifiable {
    var id: String
    var venueType: String
    var status: String
    var gameDate: String
    var gameTime: String
    var gameType: String
    var homeTeamName: String
    var visitorTeamName: String
    var homeTeamScore: String
    var visitorTeamScore: String
    var matchSymbol: String
    var currentTime: String
    var gameYear: String
    var buyTicketUrl: String
}

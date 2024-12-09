//
//  Helper.swift
//  Scheduler
//
//  Created by Vikas Joshi on 08/12/24.
//

import Foundation

func formatDateTime(from isoDate: String) -> (date: String, time: String, year: String)? {
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    
    guard let date = isoFormatter.date(from: isoDate) else { return nil }
    
    // Extract year in "JULY 2023" format
    let yearFormatter = DateFormatter()
    yearFormatter.dateFormat = "MMMM yyyy"
    yearFormatter.timeZone = TimeZone.current
    
    let formattedYear = yearFormatter.string(from: date).uppercased()
    
    // Create DateFormatter for the desired date format
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE MMM dd"
    dateFormatter.timeZone = TimeZone.current
    
    let formattedDate = dateFormatter.string(from: date)
    
    // Create DateFormatter for the desired time format
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "h:mm a"
    timeFormatter.timeZone = TimeZone.current
    
    let formattedTime = timeFormatter.string(from: date)
    
    return (date: formattedDate, time: formattedTime, year: formattedYear)
}



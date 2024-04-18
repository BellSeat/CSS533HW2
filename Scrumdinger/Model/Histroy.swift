//
//  Histroy.swift
//  Scrumdinger
//
//  Created by qingran shao on 4/18/24.
//

import Foundation

struct Histroy: Identifiable, Codable{
    let id: UUID
    let date: Date
    var attendees: [DailyScrum.Attendee]
    
    init(id: UUID = UUID(), date: Date = Date(), attendees: [DailyScrum.Attendee]) {
        self.id = id
        self.date = date
        self.attendees = attendees
    }
}

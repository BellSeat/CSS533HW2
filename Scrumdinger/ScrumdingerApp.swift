//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by qingran shao on 4/17/24.
//

import SwiftUI
import SwiftData

@main
struct ScrumdingerApp: App {
    var body: some Scene{
        WindowGroup{
            ScrumsView(scrums: DailyScrum.sampleData)
            
        }
    }
}

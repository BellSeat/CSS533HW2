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
    @StateObject private var store = ScrumStore()
    
    var body: some Scene{
        WindowGroup{
            ScrumsView(scrums: $store.scrums){
                Task{
                    do{
                        try await store.save(scrums: store.scrums)
                    }catch{
                        fatalError(error.localizedDescription)
                    }
                }
            }
                .task{
                    do{
                        try await store.load()
                    } catch{
                        fatalError(error.localizedDescription)
                    }
                }
            
        }
    }
}

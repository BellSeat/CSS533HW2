//
//  DetailView.swift
//  Scrumdinger
//
//  Created by qingran shao on 4/17/24.
//

import Foundation
import SwiftUI

struct DetailView: View{
    let scrum:DailyScrum
    
    var body: some View{
        List{
            Section(header: Text("Meeting Info")){
                NavigationLink(destination: MeetingView())
                    {
                        Label("Start Meeting",systemImage: "timer")
                    }
                HStack{
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
                HStack{
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
            
            Section(header: Text("Attendess")){
                ForEach(scrum.attendees){ attendee in Label(attendee.name, systemImage: "person")}
            }
        }
        .navigationTitle(scrum.title)
    }
}

struct DetailView_Previews: PreviewProvider{
    static var previews: some View{
        NavigationStack{
            DetailView(scrum: DailyScrum.sampleData[0])
        }
    }
}

//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Alex Bonder on 8/14/23.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "S"
    
    var body: some View {
        VStack {
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button("Add to Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let bug = Singer(context: moc)
                bug.firstName = "Bug"
                bug.lastName = "Hunter"
                
                let frank = Singer(context: moc)
                frank.firstName = "Frank"
                frank.lastName = "Turner"
                
                try? moc.save()
            }
            
            Button("Show H") {
                lastNameFilter = "H"
            }
            
            Button("Show T") {
                lastNameFilter = "T"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

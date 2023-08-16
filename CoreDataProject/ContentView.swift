//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Alex Bonder on 8/14/23.
//

import CoreData
import SwiftUI

enum FilterKeys: String, CaseIterable {
    case firstName, lastName
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var searchTerm = ""
    @State private var predicate = Predicates.beginsWith
    @State private var filterKey = FilterKeys.lastName
    @State private var sortKey = FilterKeys.lastName
    
    var body: some View {
        VStack {
            FilteredList(
                filterKey: filterKey.rawValue,
                filterValue: searchTerm,
                predicate: predicate,
                sortDescriptors: [SortDescriptor(sortKey == .firstName ? \Singer.firstName : \Singer.lastName)]
            ) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            
            Form {
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
                                
                TextField("Search", text: $searchTerm)
                
                Picker("Search By", selection: $filterKey) {
                    ForEach(FilterKeys.allCases, id: \.self) {
                        Text($0 == .firstName ? "First Name" : "Last Name")
                    }
                }
                
                Picker("Sort By", selection: $sortKey) {
                    ForEach(FilterKeys.allCases, id: \.self) {
                        Text($0 == .firstName ? "First Name" : "Last Name")
                    }
                }
                
                Picker("Search Method", selection: $predicate) {
                    ForEach(Predicates.allCases, id: \.self) {
                        Text($0.rawValue.uppercased())
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

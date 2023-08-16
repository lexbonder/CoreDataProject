//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Alex Bonder on 8/15/23.
//

import CoreData
import SwiftUI

enum Predicates: String, CaseIterable {
    case beginsWith, contains, endsWith, like, matches
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(filterKey: String, filterValue: String, predicate: Predicates, sortDescriptors: [SortDescriptor<T>] = [], @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K \(predicate.rawValue.uppercased())[c] %@", filterKey, filterValue))
        self.content = content
    }
}

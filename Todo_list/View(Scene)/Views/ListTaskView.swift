//
//  ListTaskView.swift
//  Todo_list
//
//  Created by Tran Lam on 16/10/2023.
//

import SwiftUI
import SwiftData

struct ListTaskView: View {
    @Query private var items: [ItemEntity]
    var body: some View {
        List {
            ForEach(items) { item in
                NavigationLink {
                    Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                } label: {
                    Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                }
            }
        }
    }
}

#Preview {
    ListTaskView()
        .modelContainer(for: ItemEntity.self, inMemory: true)
}

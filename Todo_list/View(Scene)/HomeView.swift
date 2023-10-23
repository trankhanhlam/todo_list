//
//  ContentView.swift
//  Todo_list
//
//  Created by Tran Lam on 12/10/2023.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @ObservedObject private var homeViewModel = HomeViewModel()
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [ItemEntity]
    
    @State private var showNewTask = false
    @State private var isShowSideMenu = false
    @State private var syncTask: (() -> Void) = { }

    var body: some View {
        ZStack {
            NavigationSplitView {
                NavigationStack {
                    if items.isEmpty {
                        Text("Create an item")
                    } else {
                        ListTaskView()
                    }
                }
                .navigationDestination(isPresented: $showNewTask) {
                    CreateTaskView()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: showSideMenu, label: {
                            Label("Menu", systemImage: "rectangle.split.2x1")
                        })
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            } detail: {
                CreateTaskView()
            }
            SideMenuView(isShowSideMenu: $isShowSideMenu,
                         syncTask: self.syncTaskfromSever)
        }
        .onAppear(perform: {
            Task {
                try await homeViewModel.getAllTask()
            }
        })
    }
    
    private func showSideMenu() {
        isShowSideMenu.toggle()
    }

    private func addItem() {
        showNewTask = true
    }
    
    private func syncTaskfromSever() {
        let itemsLocal = items.map { $0.covertToItem() }
        Task {
            try await homeViewModel.sync(tasks: itemsLocal)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: ItemEntity.self, inMemory: true)
}

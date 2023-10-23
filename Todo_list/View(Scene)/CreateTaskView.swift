//
//  CreateTaskView.swift
//  Todo_list
//
//  Created by Tran Lam on 12/10/2023.
//

import SwiftUI

struct CreateTaskView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    @State private var titleTask = ""
    @State private var detailTask = ""
    @State private var thisLongText = "This is some editable text..."
    var body: some View {
        NavigationStack {
            HStack {
                VStack(content: {
                    TextField("Title placeholder", text: $titleTask)
                        .padding(.bottom, 10)
                    TextField("Detail placeholder", text: $detailTask, axis: .vertical)
                        .lineLimit(1...10)
                        .padding(.bottom, 30)
                    HStack {
                        Spacer()
                        Button(action: saveTask, label: {
                            Text("Save")
                        })
                    }
                    Spacer()
                })
                .padding()
                .textFieldStyle(.roundedBorder)
            }
            .navigationTitle("Add task")
            .toolbar(content: {
                ToolbarItem {
                    Button(action: saveTask, label: {
                      Label("Save", systemImage: "square.and.arrow.down")
                    })
                }
            })
        }
    }
    
    private func saveTask() {
        let newItem = ItemEntity(timestamp: Date())
        newItem.id = Int.random(in: 0...Int.max)
        newItem.title = titleTask
        newItem.detail = detailTask
        modelContext.insert(newItem)
        self.presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    CreateTaskView()
}

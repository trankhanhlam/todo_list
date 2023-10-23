//
//  HomeViewModel.swift
//  Todo_list
//
//  Created by Tran Lam on 16/10/2023.
//

import Foundation

class HomeViewModel: ObservableObject {

    func getAllTask() async throws -> [Item] {
        return try await Network.shared.getAllListTask()
    }

    func sync(tasks: [Item]) async throws {
        try await Network.shared.sync(tasks: tasks)
    }
}

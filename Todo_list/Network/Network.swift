//
//  Network.swift
//  Todo_list
//
//  Created by Tran Lam on 16/10/2023.
//

import Foundation

class Network {
    static let shared: Network = Network()
    init() { }
    
    func getAllListTask() async throws -> [Item] {
        let request = URLRequest(url: URL(string: "http://127.0.0.1:8080/api/task")!)
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let (data, _) = try await session.data(for: request)
        let items = try JSONDecoder().decode([Item].self, from: data)
        print(items)
        return items
    }
    
    func sync(tasks: [Item]) async throws {
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/api/add_task")!)
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let bodyReq = try JSONEncoder().encode(tasks)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyReq
        let (data, _) = try await session.data(for: request)
        print(data)
    }
}

//
//  DataService.swift
//  ToDoListTest
//
//  Created by Dmitry Victorovich on 22.08.2025.
//
import Foundation

final class NetworkService {
    
    func getData( callback: @escaping ([ToDoModel]) -> Void) {
        let stringURL = "https://dummyjson.com/todos"
        guard let url = URL(string: stringURL) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                return
            }
            do {
                let dataString = String(data: data, encoding: .utf8) ?? ""
                let jsonResult  = try JSONDecoder().decode(NetworkModel.self, from: dataString.data(using: .utf8) ?? data)
                
                callback(jsonResult.todos)
                print(jsonResult)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
}

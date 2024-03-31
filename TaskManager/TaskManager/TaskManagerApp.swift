//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by Vemireddy Vijayasimha Reddy on 29/03/24.
//

import SwiftUI
import SwiftData

@main
struct TaskManagerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Task.self)
    }
}

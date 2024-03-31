//
//  Task.swift
//  TaskManager
//
//  Created by Vemireddy Vijayasimha Reddy on 29/03/24.
//

import SwiftUI
import SwiftData

@Model
class Task: Identifiable {
    
    var id: UUID
    var title: String
    var caption: String
    var date: Date 
    var isCompleted: Bool
    var tint: String
    
    init(id: UUID = .init(), title: String, caption: String, date: Date = .init(), isCompleted: Bool = false, tint: String) {
        self.id = id
        self.title = title
        self.caption = caption
        self.date = date
        self.isCompleted = isCompleted
        self.tint = tint
    }
    
    var tintColor: Color {
        switch tint {
        case "taskColor1": return .taskColor1
        case "taskColor2": return .taskColor2
        case "taskColor3": return .taskColor3
        case "taskColor4": return .taskColor4
        case "taskColor5": return .taskColor5
        case "taskColor6": return .taskColor6
        case "taskColor7": return .taskColor7
            
        default: return .black
            
        }
    }
}

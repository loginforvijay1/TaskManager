//
//  TasksView.swift
//  TaskManager
//
//  Created by Vemireddy Vijayasimha Reddy on 31/03/24.
//

import SwiftUI
import SwiftData

struct TasksView: View {
    
    @Binding var date: Date
    
    //Swift data Dynamic Query
    @Query private var tasks: [Task]
    
    init(date: Binding<Date>) {
        self._date = date
        let calender = Calendar.current
        let startDate = calender.startOfDay(for: date.wrappedValue)
        let endOfDate = calender.date(byAdding: .day, value: 1, to: startDate)!
        let predicate = #Predicate<Task> {
            return $0.date >= startDate && $0.date < endOfDate
        }
        
        //Sorting
        
        let sortDescriptor = [
            SortDescriptor(\Task.date, order: .reverse)
        ]
        
        self._tasks = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
    }
    
    var body: some View {
        VStack(alignment: .leading, content: {
            ForEach(tasks) { task in
                TaskItem(task: task)
                    .background(alignment: .leading) {
                        if tasks.last?.id != task.id {
                            Rectangle()
                                .frame(width: 1)
                                .offset(x: 24, y: 45)
                            
                        }
                        
                    }
            }
        })
        .padding(.top)
        .overlay {
            if tasks.isEmpty {
                Text("No Task's Added")
                    .font(.system(size: 20, weight: .bold))
                    .frame(width: 200)
                    .padding(.top, 50)
                    
            }
        }
    }
}

#Preview {
    ContentView()
}

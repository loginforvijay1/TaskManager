//
//  TaskItem.swift
//  TaskManager
//
//  Created by Vemireddy Vijayasimha Reddy on 29/03/24.
//

import SwiftUI
import SwiftData

struct TaskItem: View {
    
    @Bindable var task: Task
    
    var body: some View {
        HStack(alignment: .center, spacing: 15, content: {
            
            Circle()
                .fill(indicatorColor)
                .frame(width: 10, height: 10)
                .padding(4)
                .background(.white.shadow(.drop(color: .black.opacity(0.1), radius: 3)), in: .circle)
                .overlay {
                    Circle()
                        .frame(width: 50, height: 50)
                        .blendMode(.destinationOver)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                task.isCompleted.toggle()
                            }
                        }
                    
                }
            VStack (alignment: .leading, spacing: 8 ,content: {
                HStack{
                    Text(task.title)
                        .font(.system(size: 20, weight: .semibold))
                    Spacer()
                    Label("\(task.date.format("hh:mm a"))", systemImage: "clock" )
                }
                .hSpacing(.leading)
                Text(task.title)
                    .font(.callout)
            })
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(task.tint).opacity(0.2))
            .clipShape(.rect(cornerRadius: 20))
        })
        .padding(.horizontal)
    }
    
    var indicatorColor: Color {
        if task.isCompleted {
            return .green
        }
        return task.date.isSameHour ? .black : (task.date.isPast ? .blue : .black)
    }
}

#Preview {
    ContentView()
}

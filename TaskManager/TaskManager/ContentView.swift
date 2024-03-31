//
//  ContentView.swift
//  TaskManager
//
//  Created by Vemireddy Vijayasimha Reddy on 29/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentDate: Date = .init()
    
    //Week Slider
    @State var weekSlider: [[Date.WeekDay]] = []
    @State var currentWeekIndex: Int = 1
    // Animation nameSpace
    @Namespace private var animation
    
    @State private var createWeek: Bool = false
    
    //@State private var tasks: [Task] = sampleTask.sorted(by: {$1.date > $0.date })
    
    // add create layout
    @State private var createNewTask: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Calender")
                    .font(.system(size: 36, weight: .semibold))
                
                // Week slider
                TabView(selection: $currentWeekIndex,
                        content:  {
                    ForEach(weekSlider.indices, id: \.self) { index in
                        let week = weekSlider[index]
                        weekView(week)
                            .tag(index)
                    }
                })
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: 100)
                
            }
            .padding()
            .frame(maxWidth: .infinity )
            .background{
                Rectangle().fill(.gray.opacity(0.1))
                    .clipShape(.rect(bottomLeadingRadius: 30, bottomTrailingRadius: 30))
                    .ignoresSafeArea()
            }
            .onChange(of: currentWeekIndex, initial: false) { oldValue, newValue in
                if newValue == 0 || newValue == (weekSlider.count - 1) {
                    createWeek = true
                }
            }
            
            ScrollView(.vertical ) {
                VStack {
                    //tasks view
                    TasksView(date: $currentDate)
                }
                .hSpacing(.center)
                .vSpacing(.center)
            }.scrollIndicators(.hidden)
            
            
        }
        .vSpacing(.top)
        .frame(maxWidth: .infinity)
        .onAppear() {
            if weekSlider.isEmpty {
                
                let currentWeek = Date().fetchWeek()
                
                if let firstDate = currentWeek.first?.date {
                    weekSlider.append(firstDate.createPreviousWeek())
                }
                
                weekSlider.append(currentWeek)
                
                if let lastDate = currentWeek.last?.date {
                    weekSlider.append(lastDate.createNextWeek())
                }
            }
        }
        .overlay(alignment: .bottomTrailing) {
            
            //Add button to show newtask layout
            Button(action: {
                createNewTask.toggle()
            }, label: {
                Image(systemName: "plus")
                    .imageScale(.large)
                    .padding(26)
                    .background(.black)
                    .clipShape(Circle())
                    .padding([.horizontal])
                    .foregroundStyle(.white)
            })
            
            .fullScreenCover(isPresented: $createNewTask, content: {
                NewTask()
            })
        }
        
    }
    
    // Week View
    @ViewBuilder
    func weekView(_ week: [Date.WeekDay]) -> some View {
        
        HStack(spacing: 0) {
            ForEach(week) { day in
                VStack {
                    Text(day.date.format("E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                    
                    Text(day.date.format("dd"))
                        .font(.system(size: 20))
                        .textScale(.secondary)
                        .frame(width: 50, height: 55)
                        .foregroundStyle(isSameDate(day.date, currentDate) ? .white : .black)
                        .background {
                            if isSameDate(day.date, currentDate) {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(.black)
                                    .offset(y: 3)
                                    .matchedGeometryEffect(id: "TABINDICATOR", in: animation)
                            }
                            if day.date.isToday {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 5, height: 5)
                                    .vSpacing(.bottom)
                            }
                        }
                }
                .hSpacing(.center)
                .onTapGesture {
                    withAnimation(.snappy) {
                        currentDate = day.date
                    }
                }
            }
        }
        .background{
            GeometryReader {
                let minX = $0.frame(in: .global).minX
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self, perform: { value in
                        if value.rounded() == 15 && createWeek {
                            paginateWeek()
                            createWeek = false
                        }
                    })
            }
        }
        
    }
    
    func paginateWeek() {
        if weekSlider.indices.contains(currentWeekIndex) {
            if let firstDate = weekSlider[currentWeekIndex].first?.date, currentWeekIndex == 0 {
                
                weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex = 1
            }
            
            if let lastDate = weekSlider[currentWeekIndex].last?.date, currentWeekIndex == (weekSlider.count - 1) {
                
                weekSlider.append(lastDate.createNextWeek())
                weekSlider.removeFirst()
                currentWeekIndex = weekSlider.count - 2
            }
        }
    }
    
    //Checking two dates are same
    func isSameDate(_ date1: Date, _ date2: Date) -> Bool {
        return Calendar.current.isDate(date1, inSameDayAs: date2)
    }
    

}

#Preview {
    ContentView()
}

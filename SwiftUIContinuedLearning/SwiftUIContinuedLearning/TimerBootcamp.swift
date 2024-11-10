//
//  TimerBootcamp.swift
//  SwiftUIContinuedLearning
//
//  Created by Miguel Mañas Alvarez on 10/11/24.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 3.0, on: .main, in: .common)
        .autoconnect()
    
    //Current Time
    /*
    @State var currentDate: Date = Date()
    var dateFormatter: DateFormatter {
        var dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }
     */
    
    //Countdown
    /*
    @State var count: Int = 10
    @State var finishText: String? = nil
     */
    
    //Countdown today
    /*
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        
        timeRemaining = "\(hour):\(minute):\(second)"
    }
     */
    
    //Animation Counter
    @State var count: Int = 1
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [.blue, .cyan]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            .ignoresSafeArea()
            
//            Text(timeRemaining)
//                .font(.system(size: 100, weight: .semibold, design: .rounded))
//                .foregroundColor(.white)
//                .lineLimit(1)
//                .minimumScaleFactor(0.1)
            
//            HStack {
//                Circle()
//                    .offset(y: count == 1 ? 20 : 0)
//                Circle()
//                    .offset(y: count == 2 ? 20 : 0)
//                Circle()
//                    .offset(y: count == 3 ? 20 : 0)
//            }
//            .frame(width: 150)
//            .foregroundColor(.white)
            
            TabView(selection: $count,
                    content: {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.orange)
                    .tag(4)
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(5)
            })
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
            
        }
        .onReceive(timer) { value in
            withAnimation(.default) {
                count = count == 5 ? 1 : count + 1
            }
            
            
        }
    }
}

struct TimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TimerBootcamp()
    }
}

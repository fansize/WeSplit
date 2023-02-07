//
//  BetterResetView.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/6.
//

import SwiftUI
import CoreML

struct BetterResetView: View {
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var wakeUp = defaultWakeUp
    
    static var defaultWakeUp: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    @State private var alterTitle = ""
    @State private var alterMessage = ""
    @State private var showingAlter = false
    
    @State private var sleepTime = defaultSleepTime
    static var defaultSleepTime: Date {
        var components = DateComponents()
        components.hour = 22
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Edit your information") {
                    VStack(alignment: .leading) {
                        Text("When do you want to wake up?")
                            .font(.headline)
                        DatePicker("Please enter a date", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                        
                        Text("Desired amount of sleep")
                            .font(.headline)
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.5)
                        
                        // 样式1
//                        Text("Daily coffee intake")
//                            .font(.headline)
//                        Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                        
                        // 样式2
                        Picker("Daily coffee intake", selection: $coffeeAmount) {
                            ForEach(0..<20) {
                                Text($0 <= 1 ? "1 cup" : "\($0) cups")
                            }
                        }
                    }
                }
                
                Section("Suggest sleep time") {
                    Text(sleepTime, style:.time)
                        .font(.title)
                }
            }
            .navigationTitle("Better Reset")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
            .alert(alterTitle, isPresented: $showingAlter) {
                Button("OK") { }
            } message: {
                Text(alterMessage)
            }
        }
    }
    
    func calculateBedtime() {
        do {
            // 导入模型
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            // Date转为秒
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            // 启动预测
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            // 计算结果
            sleepTime = wakeUp - prediction.actualSleep
            
            // 成功提醒
            alterTitle = "Your ideal bedtime is"
            alterMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            // 错误提醒
            alterTitle = "Error"
            alterMessage = "Sorry, there was a problem calculating your bedtime."
            showingAlter = true
        }
    }
}

struct BetterResetView_Previews: PreviewProvider {
    static var previews: some View {
        BetterResetView()
    }
}

func dateTrans() -> Date {
    var components = DateComponents()
    components.hour = 8
    components.minute = 0
    let date = Calendar.current.date(from: components) ?? Date.now
    
    return date
}

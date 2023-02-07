//
//  BetterResetView.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/6.
//

import SwiftUI

struct BetterResetView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    
    var body: some View {
        VStack(alignment: .trailing) {
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
            
            DatePicker("Please enter a date", selection: $wakeUp, in: Date.now..., displayedComponents: .hourAndMinute)
                .labelsHidden()
            Text(dateTrans(), format: .dateTime.hour().minute())
        }
        .padding()
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

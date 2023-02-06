//
//  BetterResetView.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/6.
//

import SwiftUI

struct BetterResetView: View {
    @State private var sleepAmount = 8.0
    
    var body: some View {
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
            .padding()
    }
}

struct BetterResetView_Previews: PreviewProvider {
    static var previews: some View {
        BetterResetView()
    }
}

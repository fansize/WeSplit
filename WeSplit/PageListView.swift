//
//  PageListView.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/5.
//

import SwiftUI

struct PageListView: View {
    var body: some View {
        NavigationStack {
            Form {
                NavigationLink("WeSplit", destination: WeSplitView())
                NavigationLink("GuessTheFlag", destination: GuessFlagView())
                NavigationLink("BetterReset", destination: BetterResetView())
                NavigationLink("WordScramble", destination: WorldScrambleView())
            }
            .navigationTitle("HackSwift Practice")
        }
    }
}

struct PageListView_Previews: PreviewProvider {
    static var previews: some View {
        PageListView()
    }
}

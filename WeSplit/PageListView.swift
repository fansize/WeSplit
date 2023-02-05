//
//  PageListView.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/5.
//

import SwiftUI

struct PageListView: View {
    var projects = ["WeSplit", "GuessTheFlag"]
    
    var body: some View {
        NavigationStack {
            Form {
                NavigationLink("WeSplit", destination: WeSplitView())
                NavigationLink("GuessTheFlag", destination: GuessFlagView())
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

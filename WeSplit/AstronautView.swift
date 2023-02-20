//
//  AstronautView.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/20.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                Text(astronaut.description)
                    .padding()
            }
            .navigationTitle(astronaut.name)
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts["scott"]!)
    }
}

//
//  MoonShotView.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/14.
//

import SwiftUI

struct MoonShotView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        VStack {
            Text("\(astronauts.count)")
            Text("\(missions.count)")
        }
    }
}

struct MoonShotView_Previews: PreviewProvider {
    static var previews: some View {
        MoonShotView()
    }
}

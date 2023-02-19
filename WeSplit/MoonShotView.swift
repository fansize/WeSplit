//
//  MoonShotView.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/14.
//

import SwiftUI

struct MoonShotView: View {
    let astronauts = Bundle.main.decode("astronauts.json")
    
    var body: some View {
        Text("\(astronauts.count)")
    }
}

struct MoonShotView_Previews: PreviewProvider {
    static var previews: some View {
        MoonShotView()
    }
}

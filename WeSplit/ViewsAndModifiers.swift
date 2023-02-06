//
//  ViewsAndModifiers.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/6.
//

import SwiftUI

struct ViewsAndModifiers: View {
    var body: some View {
        VStack {
            Text("Gryffindor")
                .font(.largeTitle)
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
        }
        .font(.title)
    }
}

struct ViewsAndModifiers_Previews: PreviewProvider {
    static var previews: some View {
        ViewsAndModifiers()
    }
}

//
//  P9View.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/14.
//

import SwiftUI

struct P9View: View {
    var body: some View {
//        GeometryReader { geo in
//            Image("banner")
//                .resizable()
//                .scaledToFit()
//                .frame(width: geo.size.width * 0.8)
//                .frame(width: geo.size.width, height: geo.size.height)
//            .border(.red)
//        }
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(0..<100) { num in
                    CustomView(text: "Row \(num)", num: num)
                }
            }
        }
    }
}

struct P9View_Previews: PreviewProvider {
    static var previews: some View {
        P9View()
    }
}

struct CustomView: View {
    var text: String
    var num: Int
    
    var body: some View {
        Text(text)
    }
    
    init(text: String, num: Int) {
        print("Create a new text \(num)")
        self.text = text
        self.num = num
    }
}

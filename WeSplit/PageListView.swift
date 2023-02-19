//
//  PageListView.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/5.
//

import SwiftUI

struct PageListView: View {
    var body: some View {
        let layout = [
            GridItem(.adaptive(minimum: 8, maximum: 120))
        ]
        
        ScrollView(.horizontal) {
            LazyHGrid(rows: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
        
    }
    
    func decodeJson() {
        let input = """
        {
            "name": "Taylor Swift",
            "address": {
                "street": "555, Taylor Swift Avenue",
                "city": "Nashville"
            }
        }
        """
        
        struct User: Codable {
            let name: String
            let address: Address
        }
        
        struct Address: Codable {
            let street: String
            let city: String
        }
        
        let data = Data(input.utf8)
        let decode = JSONDecoder()
        if let user = try? decode.decode(User.self, from: data) {
            print(user.address.street)
        }
    }
}

struct PageListView_Previews: PreviewProvider {
    static var previews: some View {
        PageListView()
    }
}

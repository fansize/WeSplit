//
//  UserDefaultView.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/12.
//

import SwiftUI

struct UserDefaultView: View {
    @AppStorage("tapCount") private var tapCount = 0
    @State private var tom = Person(name: "tom", age: 12)
    
    var body: some View {
        VStack {
            Button("Tap Count \(tapCount)") {
                tapCount += 1
            }
            Text("I'm \(tom.name) and \(tom.age)")
            TextField("Name", text: $tom.name)
            TextField("age", value: $tom.age, formatter: NumberFormatter())
            Button("save", action: encodePerson)
        }
        .onAppear(perform: decodePerson)
    }
    
    func encodePerson() {
        let encode = JSONEncoder()
        if let data = try? encode.encode(tom) {
            UserDefaults.standard.set(data, forKey: "tom")
        }
    }
    
    func decodePerson() {
        let decode = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "tom") {
            if let person = try? decode.decode(Person.self, from: data) {
                tom = person
            }
        }
    }
}

struct Person: Codable {
    var name: String
    var age: Int
}

struct UserDefaultView_Previews: PreviewProvider {
    static var previews: some View {
        UserDefaultView()
    }
}

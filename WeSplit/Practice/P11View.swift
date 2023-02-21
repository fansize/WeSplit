//
//  P11View.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/21.
//

import SwiftUI

struct P11View: View {
    @State private var results = [Result]()
    
    @State private var username = ""
    @State private var password = ""
    
    var disableForm: Bool {
        username.count < 5 || password.count < 5
    }
    
    var body: some View {

        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Password", text: $password)
            }
            Section {
                Button("Create Account") {
                    print("creating account")
                }
            }
            .disabled(disableForm)
        }
        
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
//            image
//                .resizable()
//                .scaledToFit()
//        } placeholder: {
//            ProgressView()
//        }
//        .frame(width: 200, height: 200)

//        List(results, id: \.trackId) { item in
//            VStack(alignment: .leading) {
//                Text(item.trackName)
//                    .font(.headline)
//                Text(item.collectionName)
//            }
//        }
//        .task {
//            await loadData()
//        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodeResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodeResponse.results
            }
            
        } catch {
            print("Invalid data")
        }
    }
}

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}


struct P11View_Previews: PreviewProvider {
    static var previews: some View {
        P11View()
    }
}

class User1: ObservableObject, Codable {
    @Published var name = "Paul"
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

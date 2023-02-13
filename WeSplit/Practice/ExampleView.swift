//
//  ExampleView.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/12.
//

import SwiftUI

struct ExampleView: View {
    @State private var showingSheet = false
    @State private var user = User()
    
    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView(name: user.lastName)
        }
    }
}

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    let name: String
    
    var body: some View {
        VStack {
            Text("This is name: \(name)")
            Button("dismiss") {
                dismiss()
            }
        }
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            IExpenceView()
            ExampleView()
        }
    }
}

struct User {
    var firstName = "tang"
    var lastName = "lang"
}

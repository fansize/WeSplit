//
//  CheckOutView.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/22.
//

import SwiftUI


struct CheckOutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                
                Button("place order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
            .alert("Thank you", isPresented: $showingConfirmation) {
                Button("OK") {
                    
                }
            } message: {
                Text(confirmationMessage)
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Faild to encode order")
            return
        }
        print(String(data: encoded, encoding: .utf8)!)
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            /// upload
            let (data, response) = try await URLSession.shared.upload(for: request, from: encoded)
            
            guard let httpRespons = response as? HTTPURLResponse, (200...299).contains(httpRespons.statusCode) else {
                showingConfirmation = true
                confirmationMessage = "failed"
                return
            }

            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "You order \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes"
            showingConfirmation = true
            
        } catch {
            showingConfirmation = true
            confirmationMessage = "failed"
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(order: Order())
    }
}

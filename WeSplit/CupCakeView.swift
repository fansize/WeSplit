//
//  CupCakeView.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/21.
//

import SwiftUI

struct CupCakeView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any Sepcial Requests", isOn: $order.specialRequestEnabled.animation())
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }

                }
            }
            .navigationTitle("Cupcake Corner")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CupCakeView_Previews: PreviewProvider {
    static var previews: some View {
        CupCakeView()
    }
}

//
//  AddressView.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $order.name)
                    TextField("Street Address", text: $order.streetAddress)
                    TextField("City", text: $order.city)
                    TextField("Zip", text: $order.zip)
                }
                Section{
                    NavigationLink {
                        CheckOutView(order: order)
                    } label: {
                        Text("Check out")
                    }
                }
                .disabled(order.hasValidAddress == false)
            }
            .navigationTitle("Delivery Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}

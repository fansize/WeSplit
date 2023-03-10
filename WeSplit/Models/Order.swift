//
//  Order.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/21.
//

import SwiftUI

class Order: ObservableObject, Codable {
    /// make properties be codable
    enum CodingKeys: CodingKey {
        case type, quantity, specialRequestEnabled, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(specialRequestEnabled, forKey: .specialRequestEnabled)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        specialRequestEnabled = try container.decode(Bool.self, forKey: .specialRequestEnabled)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city = try container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    /// empty init
    init() { }
    
    /// order
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    /// address
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress: Bool {
        /// Invavid whitespaces
        let strs = [name, streetAddress, city, zip]
        let trimmedStrs = strs.map { $0.trimmingCharacters(in: .whitespaces) }
        let filteredStrs = trimmedStrs.filter { !$0.isEmpty }  // ???
        
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty || filteredStrs.count != strs.count{
            return false
        }
        return true
    }
    
    /// check out
    var cost: Double {
        var cost = Double(quantity) * 2
        cost += (Double(type) / 2)
        if extraFrosting {
            cost += Double(quantity)
        }
        if addSprinkles {
            cost += (Double(quantity) / 2)
        }
        
        return cost
    }
}

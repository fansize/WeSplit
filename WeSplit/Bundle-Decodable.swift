//
//  Bundle-Decodable.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/19.
//

import SwiftUI

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        guard let loaded = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}

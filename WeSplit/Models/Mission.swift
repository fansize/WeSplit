//
//  Mission.swift
//  WeSplit
//
//  Created by 唐浪 on 2023/2/20.
//

import SwiftUI

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchedDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}

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
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}

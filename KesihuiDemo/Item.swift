//
//  Item.swift
//  KesihuiDemo
//
//  Created by P on 2024/2/3.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

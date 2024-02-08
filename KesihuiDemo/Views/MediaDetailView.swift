//
//  MediaDetailView.swift
//  KesihuiDemo
//
//  Created by P on 2024/2/7.
//

import SwiftUI

struct MediaDetailView:View {
    var model: MediaModel

    var body: some View {
        VStack {
            Text(String(data: try! JSONEncoder().encode(model), encoding: .utf8) ?? "Hey")
        }
    }
}

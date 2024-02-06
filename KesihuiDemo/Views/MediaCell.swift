//
//  MediaCell.swift
//  KesihuiDemo
//
//  Created by P on 2024/2/5.
//

import SwiftUI

struct MediaCell:View {
    var model: MediaModel
    var body: some View {
        HStack {
            // 左边的图像
            AsyncImage(url: URL(string: model.artworkUrl100)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
            }

            // 中间的 track name 和 artist name
            VStack(alignment: .leading) {
                Text(model.trackName)
                    .font(.headline)
                Text(model.artistName)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
            .padding()

            Spacer()

            // 右下角的 price
            VStack {
                Spacer()
                Text(String(format: "$%.2f", model.trackPrice))
                    .foregroundColor(.green)
//                    .padding(.trailing)
            }
        }
        .frame(maxHeight: 80)
    }
}

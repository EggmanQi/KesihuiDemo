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
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            HStack {
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
                Spacer()
                VStack {
                    Spacer()
                    Text(String(format: "$%.2f", model.trackPrice))
                        .font(.subheadline)
                }
            }
            VStack(alignment: .leading) {
                Text(model.trackName)
                    .font(.headline)
                Text(model.artistName)
                    .lineLimit(1)
                    .font(.subheadline)
                Spacer()
            }
            .padding(.leading, 60)
            .padding(.trailing, 10)
        }
        .frame(maxWidth: .infinity, maxHeight: 80)
//        Divider().overlay(.gray)
    }
}

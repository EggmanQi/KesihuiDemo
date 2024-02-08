//
//  MediaList.swift
//  KesihuiDemo
//
//  Created by P on 2024/2/5.
//

import SwiftUI

struct MediaList: View {
    
    @ObservedObject var viewModel = ViewModel()
    @State private var isDetailSheetPresented = false
    @State private var detailViewModel: MediaModel?

    var body: some View {
        ScrollViewReader{ scrollView in
            List(viewModel.mediaData, id: \.trackId) { model in
                MediaCell(model: model)
                    .listRowSeparator(.visible, edges: .bottom)
                    .onTapGesture {
                        detailViewModel = model
                        isDetailSheetPresented.toggle()
                    }
            }
            .listStyle(.plain)
            .sheet(isPresented: $isDetailSheetPresented, content: {
                if let detailViewModel {
                    MediaDetailView(model: detailViewModel)
                }
            })
            .onChange(of: viewModel.mediaData) {
                scrollView.scrollTo(0)
            }
            .scrollDismissesKeyboard(.automatic)
        }
    }
}

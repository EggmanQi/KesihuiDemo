//
//  ContentView.swift
//  KesihuiDemo
//
//  Created by P on 2024/2/3.
//

import Combine
import SwiftUI
//import SwiftData

struct ContentView: View {
    let options = ["Off", "Sort by Price", "Sort by Artist"]
    @State private var sortBy = 0
    @State private var searchText: String = ""
    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            SearchBar(text: $searchText).padding([.horizontal, .top], 16).onChange(of: searchText) { _, newValue in
                viewModel.filterString = newValue
                viewModel.reloadData()
            }
            VStack {
                HStack {
                    Text("Sort option").font(.headline).padding(.leading)
                    Spacer()
                }
                Picker(selection: $sortBy, label: Text("排序")) {
                    Text(options[0]).tag(0)
                    Text(options[1]).tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding([.horizontal, .top], 16)
                .onChange(of: sortBy) {
                    viewModel.sortOption = sortBy
                    viewModel.reloadData()
                }
                Spacer()
                if viewModel.isLoading {
                    ProgressView("Loading").transition(.opacity)
                } else {
                    if let errorMessage = viewModel.errorMessage {
                        Text("Error: \(errorMessage)")
                    } else {
                        List(viewModel.mediaData, id: \.trackId) { model in
//                            Text(app.collectionName)
                            MediaCell(model: model)
                                .listRowSeparator(.visible)
                                .listRowInsets(.none)
                        }
                        .opacity(1)
                    }
                }
                Spacer()
            }
            .onAppear {
                withAnimation{
                    viewModel.fetchData()
                }
            }
            .navigationTitle("iTunes Music")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//#Preview {
//    ContentView()
//        .modelContainer(for: Item.self, inMemory: true)
//}

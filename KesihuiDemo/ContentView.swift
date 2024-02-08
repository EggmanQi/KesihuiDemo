//
//  ContentView.swift
//  KesihuiDemo
//
//  Created by P on 2024/2/3.
//

import Combine
import SwiftUI

struct ContentView: View {
    let options = ["Off", "Sort by Price"]

    @State private var sortBy = 0
    @State private var searchText: String = ""

    @ObservedObject var viewModel = ViewModel()

    var body: some View {
        NavigationStack {
            SearchBar(text: $searchText).padding([.horizontal, .top], 16).onChange(of: searchText) { _, newValue in
                reloadWithSearchInput(input: newValue)
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
                    reloadWhenSortOptionChanged(option: sortBy)
                }
                Spacer()
                if viewModel.isLoading {
                    ProgressView("Loading").transition(.opacity)
                } else {
                    if let errorMessage = viewModel.errorMessage {
                        Text("Error: \(errorMessage)")
                    } else {
                       MediaList(viewModel: viewModel)
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
            .ignoresSafeArea()
        }
        .onTapGesture {
            hideKeyboard()
        }
    }

    private func reloadWithSearchInput(input : String) {
        viewModel.filterString = input
        viewModel.reloadData()
    }

    private func reloadWhenSortOptionChanged(option: Int) {
        viewModel.sortOption = option
        viewModel.reloadData()
    }

    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    ContentView()
}

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
            SearchBar(text: $searchText).padding([.horizontal], 16).onChange(of: searchText) { _, newValue in
                reloadWithSearchInput(input: newValue)
            }
            ZStack {
                VStack {
                    HStack {
                        Text("Sort option").font(.subheadline).fontWeight(.light).padding(.leading)
                        Spacer()
                    }
                    Picker(selection: $sortBy, label: Text("Sort")) {
                        Text(options[0]).tag(0)
                        Text(options[1]).tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding([.horizontal], 16)
                    .onChange(of: sortBy) {
                        reloadWhenSortOptionChanged(option: sortBy)
                    }
                    Spacer()
                    if viewModel.isLoading {
                        ProgressView("Loading").transition(.opacity)
                    } else {
                        if let errorMessage = viewModel.errorMessage {
                            Text("Error: \(errorMessage)")
                            Button {
                                withAnimation{
                                    viewModel.fetchData()
                                }
                            } label: {
                                Label("Reload", image: "arrow.clockwise")
                            }
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

//                FloatingMenuButton()
            }
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

struct FloatingMenuButton: View {
    // TODO: allow user to filter data with date and price
    @State private var selectedOption: String?
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Menu {
                    Button(action: {
                        selectedOption = "Price"
                    }) {
                        Text("Price")
                    }

                    Button(action: {
                        selectedOption = "Date"
                    }) {
                        Text("Date")
                    }
                } label: {
                    Image(systemName: "line.horizontal.3")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                }
                .foregroundColor(.white)
                .padding()
            }
        }
    }
}


#Preview {
    ContentView()
}

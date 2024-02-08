//
//  VIewModel.swift
//  KesihuiDemo
//
//  Created by P on 2024/2/4.
//

import Combine
import Foundation

class ViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var mediaData: [MediaModel] = []
    @Published var errorMessage: String?
    @Published var sortOption: Int = 0
    @Published var filterString: String = ""

    private var originalMediaData: [MediaModel] = []
    private var cancellable: Set<AnyCancellable> = []
    private let appService = APIService()

    func fetchData() {
        isLoading = true

        appService.fetchAppStoreData()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { data in
                if data.isEmpty {
                    self.errorMessage = "No media data now, please retry later"
                } else {
                    self.originalMediaData = data
                    self.mediaData = self.sortData()
                }
            })
            .store(in: &cancellable)
    }

    func reloadData() {
        mediaData = sortData()
    }

    private func sortData(datas: [MediaModel]? = nil) -> [MediaModel] {
        var tempData: [MediaModel] = []
        if filterString.isEmpty {
            tempData = originalMediaData
        } else {
            tempData = filterData(input: filterString)
        }

        return tempData.sorted(by: { (model_1, model_2) -> Bool in
            if self.sortOption == 0 {
                return model_1.trackName < model_2.trackName
            } else {
                return model_1.trackPrice < model_2.trackPrice
            }
        })
    }

    private func filterData(input: String) -> [MediaModel] {
        let filteredData = originalMediaData.filter {
            input.isEmpty ? true :
            ($0.trackName.localizedCaseInsensitiveContains(input) || $0.artistName.localizedCaseInsensitiveContains(input))
        }
        return filteredData
    }
}

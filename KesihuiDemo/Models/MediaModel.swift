//
//  MusicModel.swift
//  KesihuiDemo
//
//  Created by P on 2024/2/4.
//

import Foundation

struct AppModel: Codable {
    let resultCount: Int
    let results: [MediaModel]
}

struct MediaModel: Codable {
    let artistName: String
    let artworkUrl100: String
    let artworkUrl30: String
    let artworkUrl60: String
    let collectionArtistId: Int?
    let collectionArtistViewUrl: String?
    let collectionCensoredName: String?
    let collectionExplicitness: String
    let collectionHdPrice: Double?
    let collectionId: Int?
    let collectionName: String?
    let collectionPrice: Double?
    let collectionViewUrl: String?
    let contentAdvisoryRating: String?
    let country: String
    let currency: String
    let discCount: Int?
    let discNumber: Int?
    let kind: String
    let longDescription: String?
    let previewUrl: String?
    let primaryGenreName: String
    let releaseDate: String
    let trackCensoredName: String
    let trackCount: Int?
    let trackExplicitness: String
    let trackHdPrice: Double?
    let trackHdRentalPrice: Double?
    let trackId: Int
    let trackName: String
    let trackNumber: Int?
    let trackPrice: Double
    let trackRentalPrice: Double?
    let trackTimeMillis: Int?
    let trackViewUrl: String
    let wrapperType: String
}



//{"artistName":"Chad Stahelsk","artworkUrl100":"https://is1-ssl.mzstatic.com/image/thumb/Video118/v4/21/23/95/2123955f-c48b-648b-c39c-f1a87c9407d7/pr_source.jpg/100x100bb.jpg","artworkUrl30":"https://is1-ssl.mzstatic.com/image/thumb/Video118/v4/21/23/95/2123955f-c48b-648b-c39c-f1a87c9407d7/pr_source.jpg/30x30bb.jpg","artworkUrl60":"https://is1-ssl.mzstatic.com/image/thumb/Video118/v4/21/23/95/2123955f-c48b-648b-c39c-f1a87c9407d7/pr_source.jpg/60x60bb.jpg","collectionArtistId":1478036740,"collectionArtistViewUrl":"https://itunes.apple.com/hk/artist/intercontinental-video-limited/1478036740?uo=4","collectionCensoredName":"殺神John Wick 1-3電影合集","collectionExplicitness":"notExplicit","collectionHdPrice":334,"collectionId":1478036509,"collectionName":"殺神John Wick 1-3電影合集","collectionPrice":248,"collectionViewUrl":"https://itunes.apple.com/hk/movie/%E6%AE%BA%E7%A5%9Ejohn-wick-2/id1243851742?uo=4","contentAdvisoryRating":"IIB","country":"HKG","currency":"HKD","discCount":1,"discNumber":1,"kind":"feature-movie","longDescription":"退隱江湖的「殺神」John Wick（奇洛李維斯 飾），因昔日欠下的殺手債，被威逼出山，前往羅馬再次踏上殺戮之路。但直到陷入瘋狂槍戰，他才驚覺被人設局陷害，更瞬間成為全球殺手的頭號獵物。面對潛伏在城中各個角落的敵人，殺神無法不出盡渾身解數，用子彈復仇，槍槍爆頭；實行見萬個，殺萬個！","previewUrl":"https://video-ssl.itunes.apple.com/itunes-assets/Video117/v4/58/41/a8/5841a816-3f9f-272b-0842-a3fad0d5b4ba/mzvf_1420918039513308152.640x356.h264lc.U.p.m4v","primaryGenreName":"動作歷險","releaseDate":"2017-02-09T08:00:00Z","trackCensoredName":"殺神John Wick 2","trackCount":3,"trackExplicitness":"notExplicit","trackHdPrice":98,"trackHdRentalPrice":38,"trackId":1243851742,"trackName":"殺神John Wick 2","trackNumber":2,"trackPrice":78,"trackRentalPrice":38,"trackTimeMillis":7350207,"trackViewUrl":"https://itunes.apple.com/hk/movie/%E6%AE%BA%E7%A5%9Ejohn-wick-2/id1243851742?uo=4","wrapperType":"track"}

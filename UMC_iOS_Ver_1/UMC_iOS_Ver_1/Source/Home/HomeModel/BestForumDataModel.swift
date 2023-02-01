//
//  BestForumDataModel.swift
//  project
//
//  Created by 왕정빈 on 2023/01/06.
//

import Foundation

struct BestForumDataModel {
    let bestForumImage: String
    let bestForumTitle: String
    let numOfBestForumPhotos: String
    let numOfBestForumComments: String
    let numOfBestForumLikes: String
}

extension BestForumDataModel {
    static var bestForumData = [
        BestForumDataModel(bestForumImage: "figure.soccer", bestForumTitle: "Best Forum", numOfBestForumPhotos: "1234", numOfBestForumComments: "1234", numOfBestForumLikes: "1234"),
        BestForumDataModel(bestForumImage: "figure.soccer", bestForumTitle: "Best Forum", numOfBestForumPhotos: "1234", numOfBestForumComments: "1234", numOfBestForumLikes: "1234"),
        BestForumDataModel(bestForumImage: "figure.soccer", bestForumTitle: "Best Forum", numOfBestForumPhotos: "1234", numOfBestForumComments: "1234", numOfBestForumLikes: "1234"),
        BestForumDataModel(bestForumImage: "figure.soccer", bestForumTitle: "Best Forum", numOfBestForumPhotos: "1234", numOfBestForumComments: "1234", numOfBestForumLikes: "1234"),
        BestForumDataModel(bestForumImage: "figure.soccer", bestForumTitle: "Best Forum", numOfBestForumPhotos: "1234", numOfBestForumComments: "1234", numOfBestForumLikes: "1234"),
        BestForumDataModel(bestForumImage: "figure.soccer", bestForumTitle: "Best Forum", numOfBestForumPhotos: "1234", numOfBestForumComments: "1234", numOfBestForumLikes: "1234"),
    ]
}

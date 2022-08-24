//
//  MyModel.swift
//  NasaImComb
//
//  Created by CHRISTIAN BEYNIS on 8/22/22.
//

import Foundation


//struct MyModel: Identifiable {
//    let id: UUID = UUID()
//    var NasaImgName: String
//    let description: String
//    let imageName: String
//}


import Foundation

// MARK: - MyModelElement
struct MyModelElement: Codable {
    let copyright: String?
    let date, explanation: String
    let hdurl: String?
    let mediaType: MediaType
    let serviceVersion: ServiceVersion
    let title: String
    let url: String?

    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}

enum MediaType: String, Codable {
    case image = "image"
    case video = "video"
}

enum ServiceVersion: String, Codable {
    case v1 = "v1"
}

typealias MyModel = [MyModelElement]

//
//  ColorData.swift
//  PaintShapes
//
//  Created by QueenaHuang on 7/6/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import Foundation

struct ColorData: Decodable {
    var id: Int?
    var title: String?
    var userName: String?
    var numViews: Int?
    var numVotes: Int?
    var numComments: Int?
    var numHearts: Int?
    var rank: Int?
    var dateCreated: String?
    var hex: String?
    var rgb: RGB?
    var hsv: HSV?
    var description: String?
    var url: String?
    var imageUrl: String?
    var badgeUrl: String?
    var apiUrl: String?
}

struct RGB: Decodable{
    var red: Int
    var green: Int
    var blue: Int
}

struct HSV: Decodable {
    var hue: Int
    var saturation: Int
    var value: Int
}

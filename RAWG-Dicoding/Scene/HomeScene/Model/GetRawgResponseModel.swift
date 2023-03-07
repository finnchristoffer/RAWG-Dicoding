//
//  GetRawgResponseModel.swift
//  RAWG-Dicoding
//
//  Created by Finn Christoffer Kurniawan on 07/03/23.
//

import Foundation

struct GetRawgResponseModel: Decodable {
    let results: [RawgModel]
}


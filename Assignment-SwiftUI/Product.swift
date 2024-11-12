//
//  Product.swift
//  Assignment-SwiftUI
//
//  Created by APPLE on 11/11/24.
//


import SwiftUI

struct Product: Identifiable, Codable{
    var id = UUID()
    let image: String?
    let price: Double
    let product_name: String
    let product_type: String
    let tax: Double
    
    // Define CodingKeys to exclude `id` from decoding
        enum CodingKeys: String, CodingKey {
            case image
            case price
            case product_name
            case product_type
            case tax
        }
}

@Observable
class Products{
    var listProducts = [Product]()
}

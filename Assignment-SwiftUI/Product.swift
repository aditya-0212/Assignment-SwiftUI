//
//  Product.swift
//  Assignment-SwiftUI
//
//  Created by APPLE on 11/11/24.
//


import SwiftUI

struct Product: Codable{
    let product_type: String
    let product_name: String
    let price: Double
    let tax: Double
}
struct Response: Codable{
    let message: String
    let product_details: Product
    let product_id: Int
    let Success: Bool
}

@Observable
class Products: Identifiable, Codable{
    enum CodingKeys: String, CodingKey {
        case _image = "image"
        case _price  = "price"
        case _product_name = "product_name"
        case _product_type = "product_type"
        case _tax = "tax"
    }
    var id = UUID()
    var image: String?
    var price = 0.0
    var product_name = ""
    var product_type = ""
    var tax = 0.0
}

//
//  Product.swift
//  Assignment-SwiftUI
//
//  Created by APPLE on 11/11/24.
//


import SwiftUI

struct Product: Codable{
    let product_name: String
    let product_type: String
    let price: String
    let tax: String
    let image: Data?
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
        case _product_name = "product_name"
        case _product_type = "product_type"
        case _price  = "price"
        case _tax = "tax"
        case _image = "image"
    }
    var id = UUID()
    var product_name = ""
    var product_type = "Product"
    var price = 0.0
    var tax = 0.0
    var image: String?
   
}

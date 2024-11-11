//
//  Product.swift
//  Assignment-SwiftUI
//
//  Created by APPLE on 11/11/24.
//

import Foundation

import SwiftUI

struct Product: Identifiable{
    var id = UUID()
    let image: Image?
    let price: Double
    let product_name: String
    let product_type: String
    let tax: Double
}

@Observable
class Products{
    var listProducts = [
        Product(image: Image("https://vx-erp-product-images.s3.ap-south-1.amazonaws.com/9_1731279605_0_image.jpg"), price: 1694.915, product_name: "Testing App", product_type: "Product", tax: 18.0),
        Product(image: Image("https://vx-erp-product-images.s3.ap-south-1.amazonaws.com/9_1731279605_0_image.jpg"), price: 1694.915, product_name: "Testing App", product_type: "Product", tax: 18.0),
        Product(image: Image("https://vx-erp-product-images.s3.ap-south-1.amazonaws.com/9_1731279605_0_image.jpg"), price: 1694.915, product_name: "Testing App", product_type: "Product", tax: 18.0),
        Product(image: Image("https://vx-erp-product-images.s3.ap-south-1.amazonaws.com/9_1731279605_0_image.jpg"), price: 1694.915, product_name: "Testing App", product_type: "Product", tax: 18.0),
        Product(image: Image("https://vx-erp-product-images.s3.ap-south-1.amazonaws.com/9_1731279605_0_image.jpg"), price: 1694.915, product_name: "Testing App", product_type: "Product", tax: 18.0),
        Product(image: Image("https://vx-erp-product-images.s3.ap-south-1.amazonaws.com/9_1731279605_0_image.jpg"), price: 1694.915, product_name: "Testing App", product_type: "Product", tax: 18.0),
    ]
}

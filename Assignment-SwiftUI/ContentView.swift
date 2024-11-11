//
//  ContentView.swift
//  Assignment-SwiftUI
//
//  Created by APPLE on 11/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var products = Products()
    @State private var isShowingSheet = false
    var body: some View {
        NavigationStack{
            List(products.listProducts){ product in
                Section{
                    HStack{
                        Image("product-default")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 64,height: 64)
                        VStack{
                            Text("\(product.product_name)")
                            Text("\(product.product_type)")
                            Text(product.price.formatted())
                            Text(product.tax.formatted())
                        }
                    }
                }
            }
            .navigationTitle("All Products")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                Button{
                    isShowingSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                
            }
            .sheet(isPresented: $isShowingSheet){
                AddProductView()
            }
        }
    }
}

#Preview {
    ContentView()
}

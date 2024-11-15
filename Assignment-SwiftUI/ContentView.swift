//
//  ContentView.swift
//  Assignment-SwiftUI
//
//  Created by APPLE on 11/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var products = [Products]()
    @State private var isShowingSheet = false
    var body: some View {
        NavigationStack{
            List(products){ product in
                Section{
                    HStack{
                        if let imageUrl = URL(string: product.image ?? "" ){
                            AsyncImage(url: imageUrl){ image in
                                         image
                                           .resizable()
                                           .scaledToFit()
                                           .frame(width: 100, height: 100)
                                           .clipShape(.rect(cornerRadius: 10))
                                           .shadow(radius: 10)
                            }placeholder: {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                            }
                            .padding()
                        }
                        VStack(alignment: .leading) {
                            Text(product.product_name)
                                .font(.title2.weight(.bold))
                            Text(product.product_type)
                                .font(.title3.weight(.semibold))
                                .foregroundStyle(.gray)
                            Text("₹\(product.price, specifier: "%.2f")")
                                .font(.callout.weight(.semibold))
                            Text("Tax: \((product.tax).formatted())%")
                                .font(.callout)
                              
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
            .task{
                await loadData()
            }
        }
    }
    func loadData() async {
        guard let url = URL(string: "https://app.getswipe.in/api/public/get") else {
            return
        }
//        print("123 url is \(url)")
        do {
            let (data, _) = try await URLSession.shared.data(from:url)
//            print("234 data is \(data)")
            if let decoded = try? JSONDecoder().decode([Products].self,from: data){
//                print("567 decoded is \(decoded)")
                products = decoded
//                print("7854 \(products)")
            }else {
                print("Failed to decode JSON data")
            }
           
            }
     catch{
            print("invalid url")
        }
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//            print("Data received: \(String(data: data, encoding: .utf8) ?? "No data")")
//
//            do {
//                let decodedProducts = try JSONDecoder().decode([Product].self, from: data)
//                print("Decoded products: \(decodedProducts)")
//                products.listProducts = decodedProducts
//            } catch let decodingError {
//                print("Failed to decode JSON data: \(decodingError)")
//            }
//        } catch {
//            print("Error fetching data: \(error)")
//        }
    }
}

#Preview {
    ContentView()
}

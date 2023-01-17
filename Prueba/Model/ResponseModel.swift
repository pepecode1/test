//
//  ResponseModel.swift
//  Prueba
//
//  Created by Pepe Ruiz on 17/01/23.
//

import Foundation

struct ResponseModel: Codable {
    var item: Item
}

struct Item: Codable {
    var props: Props
}

struct Props: Codable {
    var pageProps: PageProps
}

struct PageProps: Codable {
    var initialData: InitialData
}

struct InitialData: Codable {
    var searchResult: SearchResult
}

struct SearchResult: Codable {
    var itemStacks: [ItemStacks]
}

struct ItemStacks: Codable {
    var items: [Items]
}

struct Items: Codable {
    var image: String
    var name: String
    var price: Double
}



//
//{
//    "item": {
//        "props": {
//            "pageProps": {
//                "initialData": {
//                    "searchResult": {
//                        "itemStacks": [
//                            {
//                                "items": [
//                                    {
//                                        "image": "https://i5.walmartimages.com/asr/aca26495-3f62-49d2-a83a-6ca3b4abb835_1.3d7807de495512da719487def5cad6e3.jpeg?odnHeight=180&odnWidth=180&odnBg=FFFFFF",
//                                        "name": "Nike Unisex Everyday Cotton Cushioned Crew Training Socks with DRI-FIT Technology, Large Black (Pack of 6 Pairs)",
//                                        "price": 34,
//                                    },
//                                    {
//}

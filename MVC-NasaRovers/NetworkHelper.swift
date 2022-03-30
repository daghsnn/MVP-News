//
//  ApiClient.swift
//  MVC-NasaRovers
//
//  Created by Hasan Dag on 24.03.2022.
//

import Foundation

enum EndPoints : String {
    case everything = "everything?"
}

enum SortingType : String {
    case popular = "sortBy=popularity?"
    case relevancy = "sortBy=relevancy?"
}

enum NewsError:Error {
    case decodingError
    case invalidUrl
}

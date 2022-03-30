//
//  RoverModel.swift
//  MVC-NasaRovers
//
//  Created by Hasan Dag on 24.03.2022.
//

import Foundation

struct NewsModel:Decodable {
    let status:String?
    let totalResults : Int?
    let articles : [News]
}

struct News:Decodable {
    let source : Source?
    let author : String?
    let title : String?
    let description : String?
    let url:String?
    let urlToImage : String?
    let publishedAt : String?
    let content : String?
    
}

struct Source:Decodable{
    let id : String?
    let name : String?
    let description : String?
    let url : String?
    let category : String?
    let language : String?
    let country : String?
}


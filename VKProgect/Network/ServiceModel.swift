//
//  ServiceModel.swift
//  VKProgect
//
//  Created by Дмитрий Голубев on 14.07.2022.
//

import Foundation

struct Service: Decodable{
    let name: String
    let description: String
    let link: String
    let iconUrl: String
    
    enum CodingKeys: String, CodingKey{
        case name
        case description
        case link
        case iconUrl = "icon_url"
    }
}

struct Body: Decodable{
    let services: [Service]
}

struct Object: Decodable{
    let body: Body
    let status: Int
}

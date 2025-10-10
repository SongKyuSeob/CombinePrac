//
//  ProfileResponseDTO.swift
//  CombinePrac
//
//  Created by 송규섭 on 10/9/25.
//

import Foundation



struct ProfileResponseDTO: Decodable {
    let id: Int
    let name: String
    let username: String
}

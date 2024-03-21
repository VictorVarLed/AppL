//
//  ComicRequest.swift
//  AppL
//
//  Created by Víctor Varillas Ledesma on 21/3/24.
//

import Foundation

enum ComicsRequest: RequestProtocol {
    case getComics(offset: Int)
    
    var path: String{
        switch self {
            case .getComics(_):
                return "/v1/public/comics"
        }
    }
    
    var urlParams: [String: String?] {
        switch self {
        case .getComics(let offset):
            return ["offset": "\(offset)",
                    "limit": "\(APIValues.defaultLimit)"]
        }
    }
    
    var requestType: RequestType {
        .GET
    }
}

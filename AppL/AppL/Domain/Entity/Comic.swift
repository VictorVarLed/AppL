//
//  Comic.swift
//  AppL
//
//  Created by Víctor Varillas Ledesma on 21/3/24.
//

import Foundation

struct Comic: Identifiable {
    
    let id: Int?
    let title, description: String?
    let modified: String?
    let isbn, upc, diamondCode, ean: String?
    let issn, format: String?
    let thumbnailURL: URL?
    
    init(id: Int?,
         title: String?,
         description: String? = nil,
         modified: String? = nil,
         isbn: String? = nil,
         upc: String? = nil,
         diamondCode: String? = nil,
         ean: String? = nil,
         issn: String? = nil,
         format: String? = nil,
         thumbnailURL: URL? = nil) {
        self.id = id
        self.title = title
        self.description = description
        self.modified = modified
        self.isbn = isbn
        self.upc = upc
        self.diamondCode = diamondCode
        self.ean = ean
        self.issn = issn
        self.format = format
        self.thumbnailURL = thumbnailURL
    }
}

extension Comic: Equatable {
    static func == (lhs: Comic, rhs: Comic) -> Bool {
        lhs.id == rhs.id
    }
}

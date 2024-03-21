//
//  ComicModel+DomainMapper.swift
//  AppL
//
//  Created by Víctor Varillas Ledesma on 21/3/24.
//

import Foundation

extension ComicModel: DomainMapper {
    func toDomain() -> Comic {
        return Comic(
            id: id,
            title: title,
            description: description,
            modified: modified,
            isbn: isbn,
            upc: upc,
            diamondCode: diamondCode,
            ean: ean,
            issn: issn,
            format: format,
            thumbnailURL: URL(string: thumbnail?.url?.absoluteString.replacingOccurrences(of: "http", with: "https") ?? "")          
        )
    }
}

//
//  DefaultComicRepository.swift
//  AppL
//
//  Created by Víctor Varillas Ledesma on 21/3/24.
//

import Foundation

class DefaultComicsRepository: ComicsRepository {
    private let comicsDataSource: ComicsDataSource
    
    init(comicsDataSource: ComicsDataSource) {
        self.comicsDataSource = comicsDataSource
    }
    
    func getComics(from offset: Int) async -> Result<PaginatedResponse<Comic>, AppError> {
        do {
            let data = try await comicsDataSource.getComics(from: offset)
            let comics = data.toDomain(dataType: Comic.self)
            return .success(comics)
        } catch {
            return .failure(error.toAppError)
        }
    }
}

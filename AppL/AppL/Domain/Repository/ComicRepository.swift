//
//  ComicRepository.swift
//  AppL
//
//  Created by Víctor Varillas Ledesma on 21/3/24.
//

import Foundation

protocol ComicsRepository {
    func getComics(from offset: Int) async -> Result<PaginatedResponse<Comic>, AppError>
}

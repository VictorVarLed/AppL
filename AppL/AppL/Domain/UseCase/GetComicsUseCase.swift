//
//  GetComicsUseCase.swift
//  AppL
//
//  Created by Víctor Varillas Ledesma on 21/3/24.
//

import Foundation

struct GetComicsParams {
    let offset: Int
}

protocol GetComicsUC {
    func execute(with params: GetComicsParams) async -> Result<PaginatedResponse<Comic>, AppError>
}

class DefaultGetComicsUC: GetComicsUC {
    private var repository: ComicsRepository
    
    init(repository: ComicsRepository) {
        self.repository = repository
    }
    
    func execute(with params: GetComicsParams) async -> Result<PaginatedResponse<Comic>, AppError> {
        return await repository.getComics(from: params.offset)
    }
}

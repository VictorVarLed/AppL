//
//  ComicsDataSource.swift
//  AppL
//
//  Created by Víctor Varillas Ledesma on 21/3/24.
//

import Foundation

typealias ComicsResponse = BaseResponseModel<PaginatedResponseModel<ComicModel>>

protocol ComicsDataSource {
    func getComics(from offset: Int) async throws -> PaginatedResponseModel<ComicModel>
}

class DefaultComicsDataSource: ComicsDataSource {
    private let requestManager: RequestManager
    
    init(requestManager: RequestManager) {
        self.requestManager = requestManager
    }
    
    func getComics(from offset: Int) async throws -> PaginatedResponseModel<ComicModel> {
        let request = ComicsRequest.getComics(offset: offset)
        let response: ComicsResponse = try await requestManager.makeRequest(with: request)
        return response.data
    }
}

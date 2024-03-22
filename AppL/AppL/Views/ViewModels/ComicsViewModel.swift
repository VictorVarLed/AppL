//
//  ComicsViewModel.swift
//  AppL
//
//  Created by Víctor Varillas Ledesma on 21/3/24.
//

import Foundation

@MainActor
final class ComicsViewModel: ViewModel {
    private let getComicsUseCase: any GetComicsUC
    
    private var limit = APIValues.defaultLimit
    private var currentOffset = 0
    private var totalCount = 0
    
    @Published var comics: [Comic] = []
    
    init(getComicsUseCase: any GetComicsUC) {
        self.getComicsUseCase = getComicsUseCase
        super.init()
                
        Task {
          await loadComics()
        }
    }
}

// MARK: - Load Comics -
extension ComicsViewModel {
    func loadComics(from offset: Int = 0) async {
        state = .loading
        let result = await getComicsUseCase.execute(
            with: GetComicsParams(offset: offset))
        
        switch result {
            case .success(let data):
                comics.append(contentsOf: data.results ?? [])
                totalCount = data.total ?? 0
                if comics.isEmpty {
                    state = .empty
                } else {
                    state = .success
                }
            case .failure(let err):
                state = .error(err.localizedDescription)
        }
    }

    

}

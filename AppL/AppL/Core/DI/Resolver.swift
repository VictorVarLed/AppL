//
//  Resolver.swift
//  AppL
//
//  Created by Víctor Varillas Ledesma on 21/3/24.
//

import Foundation
import Swinject
import CoreData

class Resolver {
    
    static let shared = Resolver()
    
    private var container = Container()
    
    @MainActor func injectModules() {
        injectUtils()
        injectDataSources()
        injectRepositories()
        injectUseCases()
        injectViewModels()
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
}

// MARK: - Injecting Utils -

extension Resolver {
    private func injectUtils() {
        container.register(NetworkManager.self) { _ in
            DefaultNetworkManager()
        }.inObjectScope(.container)
        
        container.register(RequestManager.self) { resolver in
            DefaultRequestManager(networkManager: resolver.resolve(NetworkManager.self)!)
        }.inObjectScope(.container)
    }
}

// MARK: - Injecting DataSources -

extension Resolver {
    private func injectDataSources() {
        container.register(ComicsDataSource.self) { resolver in
            DefaultComicsDataSource(requestManager: resolver.resolve(RequestManager.self)!)
        }.inObjectScope(.container)

    }
}

// MARK: - Injecting Repositories -

extension Resolver {
    private func injectRepositories() {
        container.register(ComicsRepository.self) { resolver in
            DefaultComicsRepository(comicsDataSource: resolver.resolve(ComicsDataSource.self)!)
        }.inObjectScope(.container)

    }
}

// MARK: - Injecting Use Cases -

extension Resolver {
    private func injectUseCases() {
        container.register(GetComicsUC.self) { resolver in
            DefaultGetComicsUC(repository: resolver.resolve(ComicsRepository.self)!)
        }.inObjectScope(.container)
    }
}

// MARK: - Injecting ViewModels -
extension Resolver {
    @MainActor
    private func injectViewModels() {
        container.register(ComicsViewModel.self) { resolver in
            ComicsViewModel(getComicsUseCase: resolver.resolve(GetComicsUC.self)!)
        }
//
//        container.register(CharacterProfileViewModel.self) { resolver in
//            CharacterProfileViewModel(
//                getComicsUC: resolver.resolve(GetComicsUC.self)!,
//                checkFavoriteUC: resolver.resolve(CheckFavoriteUC.self)!,
//                toggleFavoriteUC: resolver.resolve(ToggleFavoriteUC.self)!
//            )
//        }
    }
}

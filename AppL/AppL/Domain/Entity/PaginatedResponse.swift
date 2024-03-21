//
//  PaginatedResponse.swift
//  AppL
//
//  Created by Víctor Varillas Ledesma on 21/3/24.
//
import Foundation

struct PaginatedResponse<T: Equatable>: Equatable {
    let offset, limit, total, count: Int?
    let results: [T]?
    
    static func == (lhs: PaginatedResponse<T>, rhs: PaginatedResponse<T>) -> Bool {
        lhs.offset == rhs.offset &&
            lhs.limit == rhs.limit &&
            lhs.total == rhs.total &&
            lhs.count == rhs.count &&
            lhs.results == rhs.results
    }
}

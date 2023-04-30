//
//  IdentifiableCell.swift
//  CloudMoviesIMDB
//
//  Created by Artem Bilyi on 25.04.2023.
//

import Foundation

protocol IdentifiableCell {}
// MARK: - Allow us to not write identifier for each section
extension IdentifiableCell {
    static var identifier: String {
        String(describing: Self.self)
    }
}

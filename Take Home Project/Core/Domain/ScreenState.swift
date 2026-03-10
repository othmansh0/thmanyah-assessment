//
//  ScreenState.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

enum ScreenState<T> {
    case idle
    case loading
    case loaded(T)
    case failed(Error)
}

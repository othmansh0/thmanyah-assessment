//
//  ScreenState.swift
//  Thmanyah Assignment
//

enum ScreenState<T> {
    case idle
    case loading
    case loaded(T)
    case failed(String)
}

//
//  StackedCardCarouselView.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 07/03/2026.
//

import SwiftUI

private enum CardStackMetrics {
    static let peekOffset: CGFloat = 20
    static let fadingStep: Double = 0.125
    static let swipeThreshold: CGFloat = 40
    static let swingFactor: Double = 15
    static let maxVisibleCards = 3
}

struct StackedCardCarouselView<Data, Content>: View
    where Data: RandomAccessCollection, Data.Element: Identifiable, Content: View {

    @Environment(\.layoutDirection) private var layoutDirection
    private let data: Data
    @ViewBuilder private let content: (Data.Element) -> Content
    @Binding private var currentIndex: Int

    @State private var animatedIndex = 0.0
    @State private var previousIndex = 0.0

    init(
        _ data: Data,
        currentIndex: Binding<Int> = .constant(0),
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.content = content
        _currentIndex = currentIndex
        _animatedIndex = State(initialValue: Double(currentIndex.wrappedValue))
        _previousIndex = State(initialValue: Double(currentIndex.wrappedValue))
    }

    var body: some View {
        GeometryReader { proxy in
            ZStack {
                ForEach(visibleCards, id: \.element.id) { index, element in
                    content(element)
                        .zIndex(zIndex(for: index))
                        .offset(x: xOffset(for: index))
                        .opacity(opacity(for: index))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .gesture(data.count > 1 ? swipeDrag(dragWidth: dragWidth(for: proxy.size.width)) : nil)
        }
    }

    private func swipeDrag(dragWidth: Double) -> some Gesture {
        DragGesture()
            .onChanged { value in
                withAnimation(.interactiveSpring()) {
                    let raw = (Double(value.translation.width) / dragWidth * swipeDirection) + previousIndex
                    animatedIndex = clampedIndex(raw)
                    let nextIndex = Int(round(animatedIndex))
                    if currentIndex != nextIndex {
                        currentIndex = nextIndex
                    }
                }
            }
            .onEnded { value in
                commit(predictedEnd: value.predictedEndTranslation)
                previousIndex = animatedIndex
            }
    }

    private func commit(predictedEnd: CGSize) {
        withAnimation(.spring(response: 0.38, dampingFraction: 0.82)) {
            if abs(predictedEnd.width) > CardStackMetrics.swipeThreshold {
                advance(predictedEnd.width > 0 ? Int(swipeDirection) : -Int(swipeDirection))
            } else {
                animatedIndex = round(animatedIndex)
            }
        }
    }

    private func advance(_ delta: Int) {
        let target = round(previousIndex) + Double(delta)
        animatedIndex = clampedIndex(target)
        currentIndex = Int(animatedIndex)
    }

    private func relativePosition(for index: Int) -> Double {
        animatedIndex - Double(index)
    }

    private func zIndex(for index: Int) -> Double {
        (Double(index) + 0.5) < animatedIndex
            ? -Double(data.count - index)
            : Double(data.count - index)
    }

    private func xOffset(for index: Int) -> CGFloat {
        let position = relativePosition(for: index)
        let base = CGFloat(position) * CardStackMetrics.peekOffset
        guard position > 0, position < 0.99, index < itemCount - 1 else { return base }
        return base * CGFloat(sin(.pi * position) * CardStackMetrics.swingFactor)
    }

    private func opacity(for index: Int) -> Double {
        max(0, 1.0 - CardStackMetrics.fadingStep * abs(relativePosition(for: index)))
    }

    private var visibleCards: [(offset: Int, element: Data.Element)] {
        let lowerBound = max(0, Int(floor(animatedIndex)))
        return Array(Array(data.enumerated()).dropFirst(lowerBound).prefix(CardStackMetrics.maxVisibleCards))
    }

    private var swipeDirection: Double {
        layoutDirection == .rightToLeft ? -1 : 1
    }

    private var itemCount: Int { data.count }

    private func clampedIndex(_ value: Double) -> Double {
        guard itemCount > 0 else { return 0 }
        return min(max(value, 0), Double(itemCount - 1))
    }

    private func dragWidth(for availableWidth: CGFloat) -> Double {
        Double(max(availableWidth, 1))
    }
}

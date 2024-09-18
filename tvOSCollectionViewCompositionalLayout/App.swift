//
//  tvOSCollectionViewCompositionalLayoutApp.swift
//  tvOSCollectionViewCompositionalLayout
//
//  Created by Nicholas Clooney on 21/8/2024.
//

import SwiftUI

@main
struct App: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            combiningFullscreenWithInsetGrid
//            fullScreen
//            combined
//            imageGrid
        }
    }

    var combiningFullscreenWithInsetGrid: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    fullScreen
                        .frame(height: geometry.size.height * 0.8)
                    insetGrid
                        .frame(height: geometry.size.height * 0.5)
                }
            }
        }
    }

    var fullScreen: some View {
        ViewControllerRepresentable { context in
            FullscreenCollectionViewController()
        }
    }

    var imageGrid: some View {
        ViewControllerRepresentable { context in
            GridImageCompositionalCollectionViewController()
        }
    }

    var combined: some View {
        VStack {
            HelloWorldView()
            insetGrid
            // doubleVerticallyStackedInsetGrid

        }
    }

    /// If you want to see this working with two rows of data, change the `loadData(into:)` method to only load data for one section.
    var doubleVerticallyStackedInsetGrid: some View {
        VStack {
            insetGrid
            insetGrid
        }
    }

    /// Horizontal
    var insetGrid: some View {
        ViewControllerRepresentable { context in
            InsetItemsGridViewController()
        }
    }

    var grid: some View {
        ViewControllerRepresentable { context in
            GridViewController()
        }
    }

    var helloWorld: some View {
        HelloWorldView()
    }
}

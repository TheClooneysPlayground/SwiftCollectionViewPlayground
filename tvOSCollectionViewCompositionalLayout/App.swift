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
            insetGrid
        }
    }
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

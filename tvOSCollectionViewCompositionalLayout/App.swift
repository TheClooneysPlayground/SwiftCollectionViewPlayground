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
//            HelloWorldView()
            ViewControllerRepresentable { context in
//                GridViewController()
                InsetItemsGridViewController()
            }
        }
    }
}

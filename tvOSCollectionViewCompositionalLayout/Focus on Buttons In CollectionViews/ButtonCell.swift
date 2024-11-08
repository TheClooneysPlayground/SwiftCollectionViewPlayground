//
//  ButtonCell.swift
//  tvOSCollectionViewCompositionalLayout
//
//  Created by Nicholas Clooney on 27/9/2024.
//

import UIKit

import UIKit
import TVUIKit

class ButtonCell: TVCollectionViewFullScreenCell {
//    override var canBecomeFocused: Bool { true }

//    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
//        super.didUpdateFocus(in: context, with: coordinator)
//
//        if context.nextFocusedView === self {
//            myButton.setTitleColor(.white, for: .normal)
//
//            // Add custom focus effect
//            UIView.animate(withDuration: 0.2) {
//                self.myButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1) // Scale up
//            }
//        } else if context.previouslyFocusedView === self {
//            myButton.setTitleColor(.gray, for: .normal)
//
//            // Reset focus effect
//            UIView.animate(withDuration: 0.2) {
//                self.myButton.transform = CGAffineTransform.identity // Scale back
//            }
//        }
//    }

    let myButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Press Me", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        maskedContentView.addSubview(myButton)

        // Center the button in the cell
        NSLayoutConstraint.activate([
            myButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            myButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


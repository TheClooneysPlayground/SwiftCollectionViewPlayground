/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Generic text cell
*/

import UIKit

class TextCell: UICollectionViewCell {
    let label = UIButton()
    static let reuseIdentifier = "text-cell-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
}

extension TextCell {
    func configure() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.titleLabel!.adjustsFontForContentSizeCategory = true
        contentView.addSubview(label)
        label.titleLabel!.font = UIFont.preferredFont(forTextStyle: .caption1)
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }

    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        guard let next = context.nextFocusedView else { return }

        if next === self {
            addParallaxMotionEffects()
        } else {
            self.motionEffects = []
        }
    }

    func addParallaxMotionEffects(tiltValue : CGFloat = 0.25, panValue: CGFloat = 5) {
        var xTilt = UIInterpolatingMotionEffect()
        var yTilt = UIInterpolatingMotionEffect()
        var xPan = UIInterpolatingMotionEffect()
        var yPan = UIInterpolatingMotionEffect()
        let motionGroup = UIMotionEffectGroup()

        xTilt = UIInterpolatingMotionEffect(keyPath: "layer.transform.rotation.y", type: .tiltAlongHorizontalAxis)
        xTilt.minimumRelativeValue = -tiltValue
        xTilt.maximumRelativeValue = tiltValue

        yTilt = UIInterpolatingMotionEffect(keyPath: "layer.transform.rotation.x", type: .tiltAlongVerticalAxis)
        yTilt.minimumRelativeValue = -tiltValue
        yTilt.maximumRelativeValue = tiltValue

        xPan = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xPan.minimumRelativeValue = -panValue
        xPan.maximumRelativeValue = panValue

        yPan = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yPan.minimumRelativeValue = -panValue
        yPan.maximumRelativeValue = panValue

        motionGroup.motionEffects = [xTilt, yTilt, xPan, yPan]

        self.addMotionEffect(motionGroup)
    }
}

extension TextCell {
    override func updateConfiguration(using state: UICellConfigurationState) {
        var background = defaultBackgroundConfiguration().updated(for: state)
        background.backgroundColor = UIColor.green
        background.backgroundInsets = state.isFocused ? NSDirectionalEdgeInsets(top: -5, leading: -5, bottom: -5, trailing: -5) : .zero
        background.visualEffect = UIBlurEffect(style: .light)
        background.strokeWidth = state.isFocused ? 5 : 0
        #if os(iOS)
            background.strokeColor = state.isFocused ? .black : .clear
        #else
            background.strokeColor = state.isFocused ? .white : .clear
        #endif
        background.cornerRadius = 20
        backgroundConfiguration = background
    }
}

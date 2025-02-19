import TVUIKit

class FullscreenCell: TVCollectionViewFullScreenCell {
//    class FullscreenCell: UICollectionViewCell {

    fileprivate let imageView: UIImageView = UIImageView(frame: .zero)
    fileprivate let titleLabel: UILabel = UILabel(frame: .zero)
    fileprivate let button: UIButton = UIButton(type: .plain)
    fileprivate let buttonTwo: UIButton = UIButton(type: .plain)

    // This is the action that executes when someone presses the button.
    fileprivate var buttonAction: (() -> Void)?

    // MARK: init(s)
    override init(frame: CGRect) {
        super.init(frame: frame)

        pinViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        pinViews()
    }

    // MARK: UI
    fileprivate func pinViews() {
        let contentView = maskedContentView

        // You can add an image, or other UIView, to the `maskedBackgroundView` to achive
        // the parallax effect when moving between cells.
        contentView.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.contentMode = .scaleAspectFill

        titleLabel.textAlignment = .center
        titleLabel.textColor = .white

        button.setTitle("Expand", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .primaryActionTriggered)

        buttonTwo.setTitle("Expand Two", for: .normal)
        buttonTwo.addTarget(self, action: #selector(buttonPressed(_:)), for: .primaryActionTriggered)


        // When you add views to `maskedContentView`, they "hover" above the background.
        let stackView = UIStackView(arrangedSubviews: [titleLabel, button, buttonTwo])
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([stackView.heightAnchor.constraint(equalToConstant: 250),
                                     stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 150),
                                     stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -150),
                                     stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)])
    }

    // MARK: Misc.
    func set(backgroundImage: UIImage?, title: String, buttonAction: (() -> Void)?) {
        imageView.image = backgroundImage
        titleLabel.text = title
        self.buttonAction = buttonAction
    }

    @objc
    func buttonPressed(_ button: UIButton) {
        if button.currentTitle == "Expand" {
            button.setTitle("Shrink", for: .normal)
        } else {
            button.setTitle("Expand", for: .normal)
        }

        buttonAction?()
    }
}

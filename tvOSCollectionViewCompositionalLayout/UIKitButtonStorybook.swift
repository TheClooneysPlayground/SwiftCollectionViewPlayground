//
//  UIKitButtonStorybook.swift
//  TemplateAppTvOS
//
//  Created by Mert Vurgun on 26.08.2024.
//

import UIKit

class UIKitButtonStorybook: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupContainers()
    }

    // MARK: - Setup Containers and Stack Views
    private func setupContainers() {
        setupLeftButtonStackView()
        setupRightButtonStackView()
    }

    private func setupLeftButtonStackView() {
        let leftContainer = UIView(frame: .init(x: 0, y: 0, width: 960, height: 1080))
        leftContainer.backgroundColor = .white
        view.addSubview(leftContainer)

        let buttonStackView = createLeftButtonStackView()
        leftContainer.addSubview(buttonStackView)

        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: leftContainer.centerXAnchor),
            buttonStackView.centerYAnchor.constraint(equalTo: leftContainer.centerYAnchor)
        ])
    }

    private func setupRightButtonStackView() {
        let rightContainer = UIView(frame: .init(x: 960, y: 0, width: 960, height: 1080))
        rightContainer.backgroundColor = .black
        view.addSubview(rightContainer)

        let buttonStackView = createRightButtonStackView()
        rightContainer.addSubview(buttonStackView)

        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: rightContainer.centerXAnchor),
            buttonStackView.centerYAnchor.constraint(equalTo: rightContainer.centerYAnchor)
        ])
    }

    // MARK: - Button Stack View Creation
    private func createLeftButtonStackView() -> UIStackView {
        let buttonStackView = UIStackView(arrangedSubviews: [
            createSystemButton(),
            createDetailDisclosureButton(),
            createInfoLightButton(),
            createInfoDarkButton(),
            createContactAddButton()
        ])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 36
        buttonStackView.alignment = .center
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        return buttonStackView
    }

    private func createRightButtonStackView() -> UIStackView {
        let buttonStackView = UIStackView(arrangedSubviews: [
            createPrimaryActionButton(),
            createRoleBasedButton(role: .primary, title: "Primary Button"),
            createRoleBasedButton(role: .cancel, title: "Cancel Button"),
            createRoleBasedButton(role: .destructive, title: "Destructive Button"),
            createPlainConfiguredButton(),
            createTintedConfiguredButton(),
            createCustomConfiguredButton()
        ])
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 16
        buttonStackView.alignment = .center
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        return buttonStackView
    }

    // MARK: - Button Creation with Different Initialization
    private func createSystemButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("System Button", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .primaryActionTriggered)
        return button
    }

    private func createDetailDisclosureButton() -> UIButton {
        let button = UIButton(type: .detailDisclosure)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .primaryActionTriggered)
        return button
    }

    private func createInfoLightButton() -> UIButton {
        let button = UIButton(type: .infoLight)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .primaryActionTriggered)
        return button
    }

    private func createInfoDarkButton() -> UIButton {
        let button = UIButton(type: .infoDark)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .primaryActionTriggered)
        return button
    }

    private func createContactAddButton() -> UIButton {
        let button = UIButton(type: .contactAdd)
        button.tintColor = .systemGreen
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .primaryActionTriggered)
        return button
    }

    private func createPrimaryActionButton() -> UIButton {
        let primaryAction = UIAction(title: "Primary Action") { _ in
            print("Primary Action Button Tapped")
        }
        let button = UIButton(type: .system, primaryAction: primaryAction)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.white, for: .focused)
        button.setTitleColor(.gray, for: .disabled)
        return button
    }

    private func createRoleBasedButton(role: UIButton.Role, title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.role = role
        button.setTitle(title, for: .normal)
        button.setTitleColor(role == .destructive ? .white : .systemBlue, for: .normal)
        button.setTitleColor(role == .destructive ? .systemRed : .systemGray, for: .focused)
        button.setTitleColor(.gray, for: .disabled)
        button.backgroundColor = role == .destructive ? .systemRed : .systemGray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .primaryActionTriggered)
        return button
    }

    private func createPlainConfiguredButton() -> UIButton {
        var config = UIButton.Configuration.plain()
        config.title = "Plain Configured"
        config.cornerStyle = .medium
        config.image = UIImage(systemName: "star")
        config.imagePlacement = .leading
        let button = UIButton(configuration: config)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .focused)
        return button
    }

    private func createTintedConfiguredButton() -> UIButton {
        var config = UIButton.Configuration.tinted()
        config.title = "Tinted Configured"
        config.image = UIImage(systemName: "star.fill")
        config.imagePlacement = .leading
        config.titlePadding = 10
        let button = UIButton(configuration: config)
        button.tintColor = .systemPurple
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.white, for: .focused)
        return button
    }

    private func createCustomConfiguredButton() -> UIButton {
        var config = UIButton.Configuration.filled()
        config.title = "Custom Configured"
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "star.fill")
        config.imagePlacement = .leading
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        let button = UIButton(configuration: config)
        button.layer.shadowColor = UIColor.systemBlue.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 4
        return button
    }

    // MARK: - Button Action Handling
    @objc private func buttonTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        print("\(title) tapped")
    }
}

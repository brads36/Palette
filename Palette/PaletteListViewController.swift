//
//  PaletteListViewController.swift
//  Palette
//
//  Created by Bryce Bradshaw on 5/19/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class PaletteListViewController: UIViewController {

    // MARK: - Properties
    var safeArea: UILayoutGuide { return self.view.safeAreaLayoutGuide }
    
    var photos: [UnsplashPhoto] = []
    
    var buttons: [UIButton] {
        return [featureButton, randomButton, doubleRainbowButton]
    }
    
    // MARK: - LifeCycles
    override func loadView() {
        super.loadView()
        // Add Subviews
        addAllSubviews()
        
        // Add Constraints
        setupButtonStackView()
        constrainTableView()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemRed
        configureTableView()
        activateButtons()
        UnsplashService.shared.fetchFromUnsplash(for: .featured) { (unsplashPhotos) in
            DispatchQueue.main.async {
                guard let photos = unsplashPhotos else { return }
                self.photos = photos
                self.paletteTableView.reloadData()
            }
        }
    }
    
    // MARK: - Helper Methods
    func addAllSubviews() {
        self.view.addSubview(featureButton)
        self.view.addSubview(randomButton)
        self.view.addSubview(doubleRainbowButton)
        self.view.addSubview(buttonStackView)
        self.view.addSubview(paletteTableView)
    }
    
    func setupButtonStackView() {
        buttonStackView.addArrangedSubview(featureButton)
        buttonStackView.addArrangedSubview(randomButton)
        buttonStackView.addArrangedSubview(doubleRainbowButton)
        buttonStackView.topAnchor.constraint(equalTo: self.safeArea.topAnchor, constant: 8).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 8).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
    }
    
    func configureTableView() {
        paletteTableView.delegate = self
        paletteTableView.dataSource = self
        paletteTableView.register(PaletteTableViewCell.self, forCellReuseIdentifier: "photoCell")
    }
    
    func constrainTableView() {
        paletteTableView.anchor(top: buttonStackView.bottomAnchor, bottom: safeArea.bottomAnchor, leading: safeArea.leadingAnchor, trailing: safeArea.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 0
            , paddingTrailing: 0)
    }
    
    @objc func selectButton(sender: UIButton) {
        buttons.forEach{ $0.setTitleColor(.lightGray, for: .normal)}
        sender.setTitleColor(UIColor(named: "devmountainBlue"), for: .normal)
    }
    
    func activateButtons() {
        buttons.forEach { $0.addTarget(self, action: #selector(selectButton(sender:)), for: .touchUpInside)}
    }
    
    // MARK: - Views
    let featureButton: UIButton = {
        let button = UIButton()
        button.setTitle("Featured", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("Random", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let doubleRainbowButton: UIButton = {
        let button = UIButton()
        button.setTitle("Double Rainbow", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let paletteTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
} // End Of Class


extension PaletteListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageViewSpace: CGFloat = (view.frame.width - (2 * SpacingConstants.outerHorizontalPadding))
        let outerVerticalPadding: CGFloat = (2 * SpacingConstants.outerVerticalPadding)
        let labelSpace: CGFloat = SpacingConstants.smallElementHeight
        let objectBuffer: CGFloat = (2 * SpacingConstants.verticalObjectBuffer)
        let colorPaletteViewSpace: CGFloat = SpacingConstants.mediumElementHeight
        return imageViewSpace + outerVerticalPadding + labelSpace + objectBuffer + colorPaletteViewSpace
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PaletteTableViewCell
        cell.updateViews()
        let photo = photos[indexPath.row]
        cell.photo = photo
        
        return cell
    }
    
    
}

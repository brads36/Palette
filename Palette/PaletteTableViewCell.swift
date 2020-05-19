//
//  PaletteTableViewCell.swift
//  Palette
//
//  Created by Bryce Bradshaw on 5/19/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class PaletteTableViewCell: UITableViewCell {

    var photo: UnsplashPhoto? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews( ){
        guard let photo = photo else { return }
        fetchAndSetImage(for: photo)
        fetchAndSetColorStack(for: photo)
        paletteTitleLabel.text = photo.description ?? "No description available."
    }
    
    func fetchAndSetImage(for unsplashPhoto: UnsplashPhoto) {
        UnsplashService.shared.fetchImage(for: unsplashPhoto) { (image) in
            DispatchQueue.main.async {
                self.palettImageView.image = image            }
        }
    }
    
    func fetchAndSetColorStack(for unsplashPhoto: UnsplashPhoto) {
        ImaggaService.shared.fetchColorsFor(imagePath: unsplashPhoto.urls.regular) { (colors) in
            DispatchQueue.main.async {
                guard let colors = colors else { return }
                self.colorPaletteView.colors = colors
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addAllSubviews()
        constrainImageView()
        constrainTitleLabel()
        constrainColorPaletteView()
    }
    
    // MARK: - Helpers
    func  addAllSubviews() {
        self.addSubview(palettImageView)
        self.addSubview(paletteTitleLabel)
        self.addSubview(colorPaletteView)
    }
    
    func constrainImageView() {
        let imageViewWidth = self.contentView.frame.width - (2 * SpacingConstants.outerHorizontalPadding)
        palettImageView.anchor(top: self.contentView.topAnchor, bottom: nil, leading: self.contentView.leadingAnchor, trailing: self.contentView.trailingAnchor, paddingTop: SpacingConstants.outerVerticalPadding, paddingBottom: 0, paddingLeading: SpacingConstants.outerHorizontalPadding, paddingTrailing: SpacingConstants.outerHorizontalPadding, width: imageViewWidth, height: imageViewWidth)
    }
    
    func constrainTitleLabel() {
        paletteTitleLabel.anchor(top: palettImageView.bottomAnchor, bottom: nil, leading: self.contentView.leadingAnchor, trailing: self.contentView.trailingAnchor, paddingTop: SpacingConstants.verticalObjectBuffer, paddingBottom: 0, paddingLeading: SpacingConstants.outerHorizontalPadding, paddingTrailing: SpacingConstants.outerHorizontalPadding, width: nil, height: SpacingConstants.smallElementHeight)
    }
    
    func constrainColorPaletteView() {
        colorPaletteView.anchor(top: paletteTitleLabel.bottomAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, paddingTop: SpacingConstants.verticalObjectBuffer, paddingBottom: SpacingConstants.outerVerticalPadding, paddingLeading: SpacingConstants.outerHorizontalPadding, paddingTrailing: SpacingConstants.outerHorizontalPadding, width: nil, height: SpacingConstants.mediumElementHeight)
    }
    
    // MARK: - Views
    let palettImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        return imageView
    }()
    
    let paletteTitleLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.text = "Legion Of Boom"
        return label
    }()
    
    let colorPaletteView: ColorPaletteView = {
        let paletteView = ColorPaletteView()
        return paletteView
    }()
}

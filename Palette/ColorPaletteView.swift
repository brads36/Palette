//
//  ColorPaletteView.swift
//  Palette
//
//  Created by Bryce Bradshaw on 5/19/20.
//  Copyright © 2020 trevorAdcock. All rights reserved.
//

import UIKit

class ColorPaletteView: UIView {

    var colors: [UIColor] {
        didSet {
            buildColorBricks()
        }
    }
    
    init(colors: [UIColor] = [], frame: CGRect = .zero) {
        self.colors = colors
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildColorBricks() {
        
    }
    
    // MARK: - Views
    let colorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
}

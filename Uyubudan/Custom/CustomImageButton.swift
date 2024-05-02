//
//  CustomImageButton.swift
//  Uyubudan
//
//  Created by SangRae Kim on 5/2/24.
//

import UIKit

final class CustomImageButton: UIButton {
    
    var buttonConfiguration = UIButton.Configuration.borderless()
    let imageConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .light)
    
    init(image: String) {
        buttonConfiguration.image = UIImage(systemName: image, withConfiguration: imageConfig)
        buttonConfiguration.imagePadding = 3
        buttonConfiguration.imagePlacement = .leading
        buttonConfiguration.baseForegroundColor = .systemGray4
        buttonConfiguration.buttonSize = .mini
        
        super.init(frame: .zero)
        configuration = buttonConfiguration
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

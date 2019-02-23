//
//  DisplayTimer.swift
//  Interval Trainer
//
//  Created by Steven on 2/21/19.
//  Copyright © 2019 Steven Santiago. All rights reserved.
//

import UIKit

@IBDesignable
class DisplayTimer: UILabel {

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpLabel()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpLabel()
    }
    
    func setUpLabel(){
        
        let originalFont = UIFont(name: "Laserian", size: 45)
        var originalFontDescriptor = originalFont!.fontDescriptor
        //print(originalFontDescriptor)

        let fontDescriptorFeatureSettings = [
            [
                UIFontDescriptor.FeatureKey.featureIdentifier: kNumberSpacingType,
                UIFontDescriptor.FeatureKey.typeIdentifier: kMonospacedNumbersSelector
            ]
        ]

        let fontDescriptorFeatureSettingsT = [
            [
                UIFontDescriptor.FeatureKey.featureIdentifier:kAllTypographicFeaturesType,
                UIFontDescriptor.FeatureKey.typeIdentifier: kAllTypeFeaturesOnSelector
            ]
        ]

        let fontDescriptorAttributes = [UIFontDescriptor.AttributeName.featureSettings: fontDescriptorFeatureSettings]
        originalFontDescriptor = originalFontDescriptor.addingAttributes(fontDescriptorAttributes)
        originalFontDescriptor = originalFontDescriptor.addingAttributes([UIFontDescriptor.AttributeName.featureSettings: fontDescriptorFeatureSettingsT])
        let fontDescriptor = originalFontDescriptor

        //print(fontDescriptor)

        let font = UIFont(descriptor: fontDescriptor, size: 0.0)

        self.font = font


        
//        let attributedString = NSMutableAttributedString(string: "111111111")
//        attributedString.addAttribute(NSAttributedString.Key.kern, value: CGFloat(1.5), range: NSRange(location: 0, length: 9))
//
//        self.attributedText = attributedString
        self.adjustsFontSizeToFitWidth = true
    }
}

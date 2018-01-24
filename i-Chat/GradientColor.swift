//
//  GradientColor.swift
//  i-Chat
//
//  Created by cindy on 2018/1/11.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import UIKit

class RadialGradientLayer: CALayer {

    var center: CGPoint {
        return CGPoint(x: bounds.width/2, y: bounds.height/2)
    }

    var radius: CGFloat {
        return (bounds.width + bounds.height)/2
    }

    var colors: [UIColor] = [UIColor(red: 169/255.0, green: 222/255.0, blue: 249/255.0, alpha: 1), UIColor.white] {
        didSet {
            setNeedsDisplay()
        }
    }

    var cgColors: [CGColor] {
        return colors.map({ (color) -> CGColor in
            return color.cgColor
        })
    }

    override init() {
        super.init()
        needsDisplayOnBoundsChange = true
    }

    required init(coder aDecoder: NSCoder) {
        super.init()
    }

    override func draw(in ctx: CGContext) {
        ctx.saveGState()
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations: [CGFloat] = [0.0, 1.0]
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors as CFArray, locations: locations) else {
            return
        }
        ctx.drawRadialGradient(gradient, startCenter: center, startRadius: 0.0, endCenter: center, endRadius: radius, options: CGGradientDrawingOptions(rawValue: 0))
    }

}

class RadialGradientView: UIView {

    private let gradientLayer = RadialGradientLayer()

    var colors: [UIColor] {
        get {
            return gradientLayer.colors
        }
        set {
            gradientLayer.colors = newValue
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if gradientLayer.superlayer == nil {
            layer.insertSublayer(gradientLayer, at: 0)
        }
        gradientLayer.frame = bounds
    }

}

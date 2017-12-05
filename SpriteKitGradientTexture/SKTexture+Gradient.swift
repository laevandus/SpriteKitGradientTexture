//
//  SKTexture+Gradient.swift
//  SpriteKitGradientTexture
//
//  Created by Toomas Vahter on 12/11/2017.
//  Copyright © 2017 Augmented Code.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import SpriteKit

extension SKTexture
{
    convenience init(radialGradientWithColors colors: [UIColor], locations: [CGFloat], size: CGSize)
    {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { (context) in
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let cgColors = colors.map({ $0.cgColor }) as CFArray
            guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors, locations: UnsafePointer<CGFloat>(locations)) else {
                fatalError("Failed creating gradient.")
            }
            
            let radius = max(size.width, size.height) / 2.0
            let midPoint = CGPoint(x: size.width / 2.0, y: size.height / 2.0)
            context.cgContext.drawRadialGradient(gradient, startCenter: midPoint, startRadius: 0, endCenter: midPoint, endRadius: radius, options: [])
        }
        
        self.init(image: image)
    }
    
    
    convenience init(linearGradientWithAngle angleInRadians: CGFloat, colors: [UIColor], locations: [CGFloat], size: CGSize)
    {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { (context) in
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let cgColors = colors.map({ $0.cgColor }) as CFArray
            guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors, locations: UnsafePointer<CGFloat>(locations)) else {
                fatalError("Failed creating gradient.")
            }
            
            let angles = [angleInRadians + .pi, angleInRadians]
            let radius = (pow(size.width / 2.0, 2.0) + pow(size.height / 2.0, 2.0)).squareRoot()
            let points = angles.map { (angle) -> CGPoint in
                let dx = radius * cos(-angle) + size.width / 2.0
                let dy = radius * sin(-angle) + size.height / 2.0
                return CGPoint(x: dx, y: dy)
            }
            
            context.cgContext.drawLinearGradient(gradient, start: points[0], end: points[1], options: [])
        }
        
        self.init(image: image)
    }
}

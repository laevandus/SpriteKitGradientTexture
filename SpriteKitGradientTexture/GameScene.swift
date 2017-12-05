//
//  GameScene.swift
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
import GameplayKit

final class GameScene: SKScene
{
    override func didMove(to view: SKView)
    {
        let linearGradientSize = size
        let linearGradientColors = [UIColor(red: 53.0 / 255.0, green: 92.0 / 255.0, blue: 125.0 / 255.0, alpha: 1.0),
                                    UIColor(red: 108.0 / 255.0, green: 91.0 / 255.0, blue: 123.0 / 255.0, alpha: 1.0),
                                    UIColor(red: 192.0 / 255.0, green: 108.0 / 255.0, blue: 132.0 / 255.0, alpha: 1.0)]
        let linearGradientLocations: [CGFloat] = [0, 0.5, 1]
        let textureCount = 8
        let textures = (0..<textureCount).map { (index) -> SKTexture in
            let angle = 2.0 * CGFloat.pi / CGFloat(textureCount) * CGFloat(index)
            return SKTexture(linearGradientWithAngle: angle, colors: linearGradientColors, locations: linearGradientLocations, size: linearGradientSize)
        }
        
        let linearGradientNode = SKSpriteNode(texture: textures.first)
        linearGradientNode.zPosition = 1
        addChild(linearGradientNode)
        
        let action = SKAction.animate(with: textures, timePerFrame: 0.5)
        linearGradientNode.run(SKAction.repeatForever(action))
        
        let radialGradientSize = CGSize(width: min(size.width, size.height), height: min(size.width, size.height))
        let radialGradientColors = [UIColor.yellow, UIColor.orange]
        let radialGradientLocations: [CGFloat] = [0, 1]
        let radialGradientTexture = SKTexture(radialGradientWithColors: radialGradientColors, locations: radialGradientLocations, size: radialGradientSize)
        let radialGradientNode = SKSpriteNode(texture: radialGradientTexture)
        radialGradientNode.zPosition = 2
        addChild(radialGradientNode)
        
        let pulse = SKAction.sequence([SKAction.fadeIn(withDuration: 3.0), SKAction.fadeOut(withDuration: 1.0)])
        radialGradientNode.run(SKAction.repeatForever(pulse))
    }
}

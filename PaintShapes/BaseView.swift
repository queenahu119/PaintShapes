//
//  BaseView.swift
//  ShapeView
//
//  Created by QueenaHuang on 7/6/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import UIKit

enum Shape {
    case Square
    case Circle
}

class BaseView: UIView {

    class func shapeType() -> Shape {
        return Shape.Square
    }

    var path: UIBezierPath!
    var backColor: UIColor? {
        didSet {
            self.setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.clear
        backColor = UIColor.orange
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        backColor?.setFill()
        path.fill()

        backColor?.setStroke()
        path.stroke()
    }

    func changeColor() {
        backColor = .blue
    }

    @objc func doubleTap(touch:UITapGestureRecognizer){
        let touchPoint = touch.location(in: self)

        backColor = .blue
    }

}

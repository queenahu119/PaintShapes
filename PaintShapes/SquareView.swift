//
//  SquareView.swift
//  ShapeView
//
//  Created by QueenaHuang on 7/6/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import UIKit

class SquareView: BaseView {

    override func shapeType() -> Shape {
        return Shape.square
    }

    override func draw(_ rect: CGRect) {
        self.createRectangle()

        super.draw(rect)
    }

    func createRectangle() {
        path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))

        // the left line.
        path.addLine(to: CGPoint(x: 0.0, y: self.frame.size.height))
        // the bottom line
        path.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        // the right line.
        path.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))
        path.close()
    }
}

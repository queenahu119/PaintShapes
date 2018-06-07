//
//  BaseView.swift
//  ShapeView
//
//  Created by QueenaHuang on 7/6/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import UIKit

enum Shape {
    case square
    case circle
}

class BaseView: UIView {

    func shapeType() -> Shape {
        return Shape.square
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
        backColor = UIColor.clear
        setColor()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        backColor?.setFill()
        path.fill()
    }

    let apiService = APIService()
    func setColor() {
        apiService.getRandomColor(completion: { [weak self] (color) in
            DispatchQueue.main.async {
                guard let color = color else {
                    self?.backColor = UIColor.random()
                    print("Use code to generate random colours")
                    return
                }
                self?.backColor = color
            }
        })
    }

    @objc func doubleTap(touch:UITapGestureRecognizer){
        let touchPoint = touch.location(in: self)

        setColor()

        print("type: ", self.shapeType())
    }

}

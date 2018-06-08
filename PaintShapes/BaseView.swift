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
        return Shape.circle
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

                self?.alpha = 0
                self?.layer.setAffineTransform(CGAffineTransform(scaleX: 0.1, y: 0.1))

                UIView.animate(withDuration: 2.0,
                               delay: 0,
                               usingSpringWithDamping: 0.2,
                               initialSpringVelocity: 3.0,
                               options: .allowUserInteraction,
                               animations: { [weak self] in
                                self?.alpha = 1
                                self?.layer.setAffineTransform(CGAffineTransform.identity)
                                self?.backColor = color
                                self?.backgroundColor = UIColor.clear
                    }, completion: nil)
            }
        })
    }

    @objc func doubleTap(touch:UITapGestureRecognizer) {
        setColor()
    }

    @objc func oneTap(touch:UITapGestureRecognizer) {
        
    }
}

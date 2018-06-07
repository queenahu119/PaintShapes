//
//  ViewController.swift
//  PaintShapes
//
//  Created by QueenaHuang on 7/6/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tap: UITapGestureRecognizer?

    let shapes = [Shape.circle, Shape.square]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray

        navigationItem.title = "Shapes"
        navigationController?.navigationBar.isTranslucent = false

        tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.singleTap(touch:)))
        if let tap = tap {
            tap.numberOfTapsRequired = 1
            view.addGestureRecognizer(tap)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @objc func singleTap(touch: UITapGestureRecognizer) {
        let touchPoint = touch.location(in: self.view)

        let size = getRandomSize(touchPoint: touchPoint)
        let rect = CGRect(x: touchPoint.x, y: touchPoint.y, width: size, height: size)

        self.createShape(rect: rect)
    }

    func createShape(rect: CGRect) {
        var dynamicView: BaseView?

        let random = shapes[Int(arc4random_uniform(UInt32(shapes.count)))]

        switch random {
        case .circle:
            dynamicView = CircleView(frame: rect)
            break
        case .square:
            dynamicView = SquareView(frame: rect)
            break
        default:
            break
        }

        if let dynamicView = dynamicView {
            let doubleTap = UITapGestureRecognizer(target: dynamicView, action: #selector(SquareView.doubleTap(touch:)))
            doubleTap.numberOfTapsRequired = 2
            dynamicView.addGestureRecognizer(doubleTap)

            tap?.require(toFail: doubleTap)
            self.view.addSubview(dynamicView)
        }
    }

    func getRandomSize(touchPoint: CGPoint) -> CGFloat {
        let screenSize = UIScreen.main.bounds
        let maxWidth:CGFloat = screenSize.width - touchPoint.x
        let maxHeight:CGFloat = screenSize.height - touchPoint.y

        let size = CGFloat.random(min: 1, max: min(maxWidth, maxHeight))
        return size
    }
}

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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray

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

        let names = [Shape.Circle, Shape.Square]

        let rect = CGRect(x: touchPoint.x, y: touchPoint.y, width: 100, height: 100)

        var dynamicView: BaseView?

        let random = names[Int(arc4random_uniform(UInt32(names.count)))]

        switch random {
        case .Circle:
            dynamicView = CircleView(frame: rect)
        case .Square:
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
}


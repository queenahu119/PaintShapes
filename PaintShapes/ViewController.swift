//
//  ViewController.swift
//  PaintShapes
//
//  Created by QueenaHuang on 7/6/18.
//  Copyright © 2018 queenahu. All rights reserved.
//

import UIKit

let minSize:CGFloat = 5.0

class ViewController: UIViewController {

    var tap: UITapGestureRecognizer?
    var viewList: [UIView?] = []

    let shapes = [Shape.circle, Shape.square]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray

        navigationItem.title = "Shapes"
        navigationController?.navigationBar.isTranslucent = false

        setupTapGesture()
        setupLeftSwipe()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func setupTapGesture() {
        tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.singleTap(touch:)))
        if let tap = tap {
            tap.numberOfTapsRequired = 1
            view.addGestureRecognizer(tap)
        }
    }

    func setupLeftSwipe() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.leftSwiped(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
    }

    // MARK: - GestureRecognizer
    @objc func singleTap(touch: UITapGestureRecognizer) {
        let touchPoint = touch.location(in: self.view)
        self.createShape(touchPoint: touchPoint)
    }

    @objc func leftSwiped(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.left:
            resetCanvas()
        default: break
        }
    }

    // MARK: - private function

    fileprivate func createShape(touchPoint:CGPoint) {
        let random = shapes[Int(arc4random_uniform(UInt32(shapes.count)))]
        let dynamicView: BaseView? = getNotOverlapRect(shapeType: random, touchPoint: touchPoint)

        if let dynamicView = dynamicView {
            let doubleTap = UITapGestureRecognizer(target: dynamicView, action: #selector(SquareView.doubleTap(touch:)))
            doubleTap.numberOfTapsRequired = 2
            dynamicView.addGestureRecognizer(doubleTap)

            tap?.require(toFail: doubleTap)
            self.view.addSubview(dynamicView)
            viewList.append(dynamicView)

            // Touch the shapes
            let shapesTap = UITapGestureRecognizer(target: dynamicView, action: #selector(SquareView.oneTap(touch:)))
            shapesTap.numberOfTapsRequired = 1
            dynamicView.addGestureRecognizer(shapesTap)

            tap?.require(toFail: shapesTap)
        }
    }

    fileprivate func getNotOverlapRect(shapeType: Shape, touchPoint:CGPoint) -> BaseView? {
        var dynamicView: BaseView? = nil
        var rect: CGRect

        // Initial: Get random number for not over the screen
        let diffWidth:CGFloat = UIScreen.main.bounds.size.width - touchPoint.x
        let diffHeight:CGFloat = UIScreen.main.bounds.size.height - touchPoint.y
        let maxShapeSize = min(diffWidth, diffHeight)
        var currentMaxSize = CGSize(width: maxShapeSize, height: maxShapeSize)

        var isOverlap = false

        repeat {
            if (Int(minSize) >= Int(currentMaxSize.width)) {
                dynamicView = nil
            } else {
                // Get random number for minSize to currentMaxSize
                let size = CGFloat.random(min: minSize, max: currentMaxSize.width)
                rect = CGRect(x: touchPoint.x, y: touchPoint.y, width: size, height: size)
                currentMaxSize = CGSize(width: size, height: size)

                switch shapeType {
                case .circle:
                    dynamicView = CircleView(frame: rect)
                case .square:
                    dynamicView = SquareView(frame: rect)
                }

                isOverlap = isOverlay(rect: (dynamicView?.frame)!)
                if (isOverlap) {
                    dynamicView = nil
                }
            }

        } while ((Int(minSize) < Int(currentMaxSize.width)) && isOverlap)

        return dynamicView
    }

    fileprivate func isOverlay(rect: CGRect) -> Bool {
        for subView in viewList {
            guard let subView = subView else {
                return false
            }

            if (subView.frame.intersects(rect)) {
                return true
            }
        }
        return false
    }

    func resetCanvas() {
        print("Clear Canvas.")
        for subView in view.subviews {
            subView.removeFromSuperview()
        }

        viewList = []
    }
}

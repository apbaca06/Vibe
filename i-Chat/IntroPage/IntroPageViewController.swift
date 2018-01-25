//
//  IntroPageViewController.swift
//  i-Chat
//
//  Created by cindy on 2018/1/25.
//  Copyright © 2018年 Jui-hsin.Chen. All rights reserved.
//

import Foundation
import UIKit

class IntroPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var list = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let vc1 = storyboard.instantiateViewController(withIdentifier: "vcOne")
        let vc2 = storyboard.instantiateViewController(withIdentifier: "vcTwo")
        let vc3 = storyboard.instantiateViewController(withIdentifier: "vcThree")
        let vc4 = storyboard.instantiateViewController(withIdentifier: "vcFour")

        list.append(vc1)
        list.append(vc2)
        list.append(vc3)
        list.append(vc4)

        setViewControllers([list[0]], direction: .reverse, animated: true, completion: nil)

        dataSource = self

        setupPageControlColor()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        for v in view.subviews {
            if v is UIScrollView {
                v.frame = view.bounds
                break
            }
        }
    }

    // MARK: - Setup

    func setupPageControlColor() {

        let pageControl = UIPageControl.appearance()

        pageControl.pageIndicatorTintColor = UIColor.white

        pageControl.currentPageIndicatorTintColor = UIColor(
            red: 200.0/255,
            green: 95.0/255,
            blue: 95.0/255,
            alpha: 1.0
        )
    }

    // MARK: - PageController DataSource

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        if let index = list.index(of: viewController), index < list.count - 1 {

            return list[index + 1]

        }

        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        if let index = list.index(of: viewController), index > 0 {

            return list[index - 1]

        }

        return nil
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {

        return list.count

    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {

        return 0

    }
}

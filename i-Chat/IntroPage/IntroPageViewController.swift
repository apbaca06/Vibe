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

        let matchViewController = UIViewController.load(MatchPageViewController.self)
        let likeViewController = UIViewController.load(LikePageViewController.self)
        let chatPageViewController = UIViewController.load(ChatPageViewController.self)

        let vibeIntroViewController = UIViewController.load(VibeIntroViewController.self)

        list.append(likeViewController)
        list.append(matchViewController)
        list.append(chatPageViewController)
        list.append(vibeIntroViewController)

        setViewControllers([list[0]], direction: .reverse, animated: true, completion: nil)

        dataSource = self

        setupPageControlColor()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        for v in view.subviews where v is UIScrollView {
                v.frame = view.bounds
                break
        }
    }

    // MARK: - Setup

    func setupPageControlColor() {

        let pageControl = UIPageControl.appearance()

        pageControl.pageIndicatorTintColor = UIColor.black

        pageControl.currentPageIndicatorTintColor =
            UIColor(red: 7/255.0, green: 160/255.0, blue: 195/255.0, alpha: 1)
    }

    // MARK: - PageController DataSource

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        if let index = list.index(of: viewController), index < list.count - 1 {

            return list[index + 1]

        } else {

            return nil
        }
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

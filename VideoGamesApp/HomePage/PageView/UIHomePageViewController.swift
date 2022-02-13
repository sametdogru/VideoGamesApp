//
//  UIPageViewController.swift
//  VideoGamesApp
//
//  Created by Samet Doğru on 10.02.2022.
//

import UIKit

class UIHomePageViewController: UIPageViewController {
    
    fileprivate var items: [UIViewController] = []
    
    var gameList : [Results] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        delegate = self
        dataSource = self
        decoratePageControl()
        
        getItems()
        if let firstViewController = items.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    fileprivate func getItems() {
        let text = [gameList[0].background_image, gameList[1].background_image, gameList[2].background_image]
        
        for (_, t) in text.enumerated() {
            let c = createItemControler(with: t)
            items.append(c)
        }
    }
    
    fileprivate func decoratePageControl() {
        let pc = UIPageControl.appearance(whenContainedInInstancesOf: [UIHomePageViewController.self])
        pc.currentPageIndicatorTintColor = .orange
        pc.pageIndicatorTintColor = .gray
    }
    
    fileprivate func createItemControler(with img: String?) -> UIViewController {
        let c = UIViewController()
        c.view = UIHomePageView(img: img)
        return c
    }
}

extension UIHomePageViewController: UIPageViewControllerDelegate {
    
}

extension UIHomePageViewController: UIPageViewControllerDataSource {
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return items.last
        }
        
        guard items.count > previousIndex else {
            return nil
        }
        
        return items[previousIndex]
    }
    
    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = items.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        guard items.count != nextIndex else {
            return items.first
        }
        
        guard items.count > nextIndex else {
            return nil
        }
        
        return items[nextIndex]
    }
    
    func presentationCount(for _: UIPageViewController) -> Int {
        return items.count
    }
    
    func presentationIndex(for _: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
              let firstViewControllerIndex = items.firstIndex(of: firstViewController) else {
                  return 0
              }
        
        return firstViewControllerIndex
    }
}
// MARK : - StoryboardInstantiable
extension UIHomePageViewController: StoryboardInstantiable {
    
    static var storyboardName: String { return "HomePage" }
    static var storyboardIdentifier: String? { return "UIHomePageViewController" }
}

//
//  ContainerViewController.swift
//  AOAD
//
//  Created by Hassine on 10/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    enum SlideOutState {
        case bothCollapsed
        case leftPanelExpanded
        case rightPanelExpanded
    }
    
    var mainNavigationController: UINavigationController!
    var mainVC: MainViewController!
    
    var currentState: SlideOutState = .bothCollapsed {
        didSet {
            let shouldShowShadow = currentState != .bothCollapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    var leftViewController: SideMenuViewController?
    
    let centerPanelExpandedOffset: CGFloat = 90
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        mainVC = UIStoryboard.mainVC()
        mainVC.delegate = self
        
        mainNavigationController = UINavigationController(rootViewController: mainVC)
        view.addSubview(mainNavigationController.view)
        addChild(mainNavigationController)
        
        mainNavigationController.didMove(toParent: self)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        mainNavigationController.view.addGestureRecognizer(panGestureRecognizer)
    }
}

extension ContainerViewController: MainDelegate {
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func addLeftPanelViewController() {
        guard leftViewController == nil else { return }
        
        if let vc = UIStoryboard.sideMenuController() {
            addChildSidePanelController(vc)
            leftViewController = vc
        }
    }
    
    func animateLeftPanel(shouldExpand: Bool) {
        if shouldExpand {
            currentState = .leftPanelExpanded
            animateCenterPanelXPosition(
                targetPosition: mainNavigationController.view.frame.width - centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { _ in
                self.currentState = .bothCollapsed
                self.leftViewController?.view.removeFromSuperview()
                self.leftViewController = nil
            }
        }
    }
    
    func toggleRightPanel() {
        let notAlreadyExpanded = (currentState != .rightPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateRightPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func animateRightPanel(shouldExpand: Bool) {
        if shouldExpand {
            currentState = .rightPanelExpanded
            animateCenterPanelXPosition(
                targetPosition: -mainNavigationController.view.frame.width + centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { _ in
                self.currentState = .bothCollapsed
                self.leftViewController?.view.removeFromSuperview()
                self.leftViewController = nil
            }
        }
    }
    
    func collapseSidePanels() {
        switch currentState {
        case .rightPanelExpanded:
            toggleRightPanel()
        case .leftPanelExpanded:
            toggleLeftPanel()
        default:
            break
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut, animations: {
                        self.mainNavigationController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    func addChildSidePanelController(_ sidePanelController: SideMenuViewController) {
        sidePanelController.delegate = mainVC
        view.insertSubview(sidePanelController.view, at: 0)
        
        addChild(sidePanelController)
        sidePanelController.didMove(toParent: self)
    }
    
    func showShadowForCenterViewController(_ shouldShowShadow: Bool) {
        if shouldShowShadow {
            mainNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            mainNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
}

extension ContainerViewController: UIGestureRecognizerDelegate {
    
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        
        let gestureIsDraggingFromLeftToRight = (recognizer.velocity(in: view).x > 0)
        switch recognizer.state {
            
        case .began:
            if currentState == .bothCollapsed {
                if gestureIsDraggingFromLeftToRight {
                    addLeftPanelViewController()
                }
                
                showShadowForCenterViewController(true)
            }
            
        case .changed:
            if let rview = recognizer.view {
                if rview.frame.origin.x > 0 {
                    rview.center.x = rview.center.x + recognizer.translation(in: view).x
                    recognizer.setTranslation(CGPoint.zero, in: view)
                    let vw = recognizer.view
                    print(vw?.frame ?? CGRect.zero)
                } else if rview.frame.origin.x == 0 {
                    rview.center.x = rview.center.x + recognizer.translation(in: view).x
                    if rview.frame.origin.x < 0 {
                        rview.frame = CGRect(x: 0, y: 0, width: rview.frame.size.width, height: rview.frame.size.height)
                        recognizer.setTranslation(CGPoint.zero, in: view)
                    }
                } else {
                    recognizer.setTranslation(CGPoint.zero, in: view)
                }
            }
            
        case .ended:
            if let _ = leftViewController,
                let rview = recognizer.view {
                // animate the side panel open or closed based on whether the view has moved more or less than halfway
                let hasMovedGreaterThanHalfway = rview.center.x > view.bounds.size.width
                animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfway)
            }
        default:
            break
        }
    }
}

private extension UIStoryboard {
    
    static func main() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
    
    static func sideMenuController() -> SideMenuViewController? {
        return main().instantiateViewController(withIdentifier: "sideMenuViewController") as? SideMenuViewController
    }
    
    static func mainVC() -> MainViewController? {
        return main().instantiateViewController(withIdentifier: "mainViewController") as? MainViewController
    }
    
}

//
//  MainViewController.swift
//  AOAD
//
//  Created by Hassine on 30/08/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import UIKit
import CarbonKit
import SwitchLanguage
import Social

class MainViewController: UIViewController, CarbonTabSwipeNavigationDelegate {
    
    var delegate: MainDelegate?
    var swipe:[UIGestureRecognizer]? = []
    var firstLabel = UILabel()
    var secondLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Language.getCurrentLanguage() == "ar" {
            self.navigationController?.navigationBar.semanticContentAttribute = .forceRightToLeft
            self.navigationController?.view.semanticContentAttribute = .forceRightToLeft
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }else {
            self.navigationController?.navigationBar.semanticContentAttribute = .forceLeftToRight
            self.navigationController?.view.semanticContentAttribute = .forceLeftToRight
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let tabSwipe = CarbonTabSwipeNavigation(items: ["Statistics".localized(using: "Localizable"), "News".localized(using: "Localizable"), "Documents".localized(using: "Localizable"), "Networks & DB".localized(using: "Localizable")], delegate: self)
        tabSwipe.setTabExtraWidth(40)
        tabSwipe.setNormalColor(#colorLiteral(red: 0.662745098, green: 0.9176470588, blue: 0.9960784314, alpha: 1))
        tabSwipe.setSelectedColor(#colorLiteral(red: 0.662745098, green: 0.9176470588, blue: 0.9960784314, alpha: 1))
        tabSwipe.setIndicatorColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        tabSwipe.carbonTabSwipeScrollView.backgroundColor = #colorLiteral(red: 0.2319583297, green: 0.4583241343, blue: 0.1610836089, alpha: 1)
        tabSwipe.setTabBarHeight(60)
        tabSwipe.insert(intoRootViewController: self)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if swipe!.count > 0 {
            for recognizer in swipe ?? [] {
                navigationController?.view.addGestureRecognizer(recognizer)
            }
        }
        
        if let navigationBar = self.navigationController?.navigationBar {
            let firstFrame = CGRect(x: 0, y: 5, width: navigationBar.frame.width, height: navigationBar.frame.height/2)
            let secondFrame = CGRect(x: 0, y: 0, width: navigationBar.frame.width, height: navigationBar.frame.height*5/3)
            
            firstLabel = UILabel(frame: firstFrame)
            firstLabel.text = "AOAD".localized(using: "Localizable")
            firstLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            firstLabel.textAlignment = .center
            secondLabel = UILabel(frame: secondFrame)
            secondLabel.text = "Arab Organization for Agricultural Development".localized(using: "Localizable")
            secondLabel.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
            secondLabel.textAlignment = .center
            secondLabel.font = UIFont.systemFont(ofSize: 12.0)
            navigationBar.addSubview(firstLabel)
            navigationBar.addSubview(secondLabel)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.collapseSidePanels?()
        swipe = navigationController?.view.gestureRecognizers
        for recognizer in navigationController?.view.gestureRecognizers ?? [] {
            navigationController?.view.removeGestureRecognizer(recognizer)
        }
        
        firstLabel.removeFromSuperview()
        secondLabel.removeFromSuperview()
    }
    
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        guard let storyboard = storyboard else { return UIViewController() }

        switch index {
        case 0:
            return storyboard.instantiateViewController(withIdentifier: "StatisticsViewController")
        case 1:
            return storyboard.instantiateViewController(withIdentifier: "newsViewController")
        case 2:
            return storyboard.instantiateViewController(withIdentifier: "documentsViewController")
        case 3:
            return storyboard.instantiateViewController(withIdentifier: "network&DBViewController")
        default:
            return UIViewController()
        }
    }

    @IBAction func changeLanguage(_ sender: UIBarButtonItem) {
    }
    @IBAction func openSideMenu(_ sender: UIBarButtonItem) {
        if Language.getCurrentLanguage() == "ar" {
            delegate?.toggleRightPanel?()
        }else {
            delegate?.toggleLeftPanel?()
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "whoAreWeSegue":
            let controller = segue.destination as! WhoAreWeViewController
            controller.myTitle = "Who are we?".localized(using: "Localizable")
            controller.option = "option1"
            break
        case "oraganizationSegue":
            let controller = segue.destination as! WhoAreWeViewController
            controller.myTitle = "Organizational chart".localized(using: "Localizable")
            controller.option = "option2"
            break
        case "favoriteSegue":
            let controller = segue.destination as! NewsViewController
            controller.favortie = true
            break
        case "communicationSegue":
            let controller = segue.destination as! CommunicationOfficeViewController
            controller.choice = "Communication office".localized(using: "Localizable")
            break
        case "ministrieSegue":
            let controller = segue.destination as! MinistriesViewController
            controller.choice = "Departments".localized(using: "Localizable")
            break
        case "contactUsSegue":
            let controller = segue.destination as! ContactUsViewController
            controller.choice = "Contact us".localized(using: "Localizable")
            break
        default:
            break
        }
    }
}

extension MainViewController: SideMenuDelegate {
    func didSelectOption(_ menuOption: String) {
        delegate?.collapseSidePanels?()
        let app = UIApplication.shared.delegate as! AppDelegate
        app.viewOnly = false
        switch menuOption {
        case "option0":
            self.performSegue(withIdentifier: "favoriteSegue", sender: nil)
            break
        case "option1":
            self.performSegue(withIdentifier: "whoAreWeSegue", sender: nil)
            break
        case "option2":
            self.performSegue(withIdentifier: "oraganizationSegue", sender: nil)
            break
        case "option3":
            self.performSegue(withIdentifier: "countriesSegue", sender: nil)
            break
        case "option4":
             self.performSegue(withIdentifier: "communicationSegue", sender: nil)
            break
        case "option5":
             self.performSegue(withIdentifier: "ministrieSegue", sender: nil)
            break
        case "option6":
            if let url = URL(string: "https://www.facebook.com/pg/AOAD.ORG/photos/?tab=albums&ref=page_internal"), !url.absoluteString.isEmpty {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            break
        case "option7":
           if let url = URL(string: "https://www.youtube.com/channel/UCtOWBVtCWkXtdqcam64POMQ"), !url.absoluteString.isEmpty {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            break
        case "option8":
            let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "CustomAlertID") as! CustomAlertViewViewController
            customAlert.providesPresentationContextTransitionStyle = true
            customAlert.definesPresentationContext = true
            customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(customAlert, animated: true, completion: nil)
            break
        case "option9":
            let share = ["image", "text", "url"]
            let activityViewController = UIActivityViewController(activityItems: share, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
            break
        case "option10":
            self.performSegue(withIdentifier: "contactUsSegue", sender: nil)
            break
        default:
            break
        }
    }
}

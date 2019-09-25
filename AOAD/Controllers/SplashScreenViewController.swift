//
//  SplashScreenViewController.swift
//  AOAD
//
//  Created by Hassine on 03/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import UIKit
import SwitchLanguage

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var arabicBtn: UIButton!
    @IBOutlet weak var englishBtn: UIButton!
    @IBOutlet weak var frenchBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arabicBtn.layer.cornerRadius = 10
        arabicBtn.clipsToBounds = true
        
        englishBtn.layer.cornerRadius = 10
        englishBtn.clipsToBounds = true
        
        frenchBtn.layer.cornerRadius = 10
        frenchBtn.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func arabicBtnAction(_ sender: UIButton) {
        Language.setCurrentLanguage("ar")
        let containerViewController = ContainerViewController()
        self.navigationController?.pushViewController(containerViewController, animated: true)
    }
    
    @IBAction func englishBtnAction(_ sender: UIButton) {
        Language.setCurrentLanguage("en")
        let containerViewController = ContainerViewController()
        self.navigationController?.pushViewController(containerViewController, animated: true)
    }
    
    @IBAction func frenchBtnAction(_ sender: UIButton) {
        Language.setCurrentLanguage("fr")
        let containerViewController = ContainerViewController()
        self.navigationController?.pushViewController(containerViewController, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

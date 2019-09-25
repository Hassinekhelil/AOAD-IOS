//
//  CustomAlertViewViewController.swift
//  AOAD
//
//  Created by Hassine on 25/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import UIKit

class CustomAlertViewViewController: UIViewController {

    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var arabicCheckBox: CheckBox!
    @IBOutlet weak var frenchCheckBox: CheckBox!
    @IBOutlet weak var englishCheckBox: CheckBox!
    
    let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    var selected_lang:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setupView() {
        alertView.layer.cornerRadius = 15
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
    
    @IBAction func arabicChoosed(_ sender: UIButton) {
        if arabicCheckBox.isChecked == true {
            arabicCheckBox.isChecked = false
        }else {
            arabicCheckBox.isChecked = true
            frenchCheckBox.isChecked = false
            englishCheckBox.isChecked = false
            selected_lang = "ar"
        }
    }
    @IBAction func frenchChoosed(_ sender: UIButton) {
        if frenchCheckBox.isChecked == true {
            frenchCheckBox.isChecked = false
        }else {
            arabicCheckBox.isChecked = false
            frenchCheckBox.isChecked = true
            englishCheckBox.isChecked = false
            selected_lang = "fr"
        }
    }
    @IBAction func englishChoosed(_ sender: UIButton) {
        if englishCheckBox.isChecked == true {
            englishCheckBox.isChecked = false
        }else {
            arabicCheckBox.isChecked = false
            frenchCheckBox.isChecked = false
            englishCheckBox.isChecked = true
            selected_lang = "en"
        }
    }
    @IBAction func valid(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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

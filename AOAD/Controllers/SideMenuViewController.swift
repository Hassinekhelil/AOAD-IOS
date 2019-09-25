//
//  SideMenuViewController.swift
//  AOAD
//
//  Created by Hassine on 10/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    var delegate: SideMenuDelegate?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemMenu0: UILabel!
    @IBOutlet weak var firstSectionTitle: UILabel!
    @IBOutlet weak var itemMenu1: UILabel!
    @IBOutlet weak var itemMenu2: UILabel!
    @IBOutlet weak var itemMenu3: UILabel!
    @IBOutlet weak var secondSectionTitle: UILabel!
    @IBOutlet weak var itemMenu4: UILabel!
    @IBOutlet weak var itemMenu5: UILabel!
    @IBOutlet weak var itemMenu6: UILabel!
    @IBOutlet weak var itemMenu7: UILabel!
    @IBOutlet weak var thirdSectionTitle: UILabel!
    @IBOutlet weak var itemMenu8: UILabel!
    @IBOutlet weak var itemMenu9: UILabel!
    @IBOutlet weak var itemMenu10: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = "Arab Organization for Agricultural Development".localized(using: "Localizable")
        firstSectionTitle.text = "Presentation of the organization".localized(using: "Localizable")
        itemMenu0.text = "Favorite list".localized(using: "Localizable")
        itemMenu1.text = "Who are we?".localized(using: "Localizable")
        itemMenu2.text = "Organizational chart".localized(using: "Localizable")
        itemMenu3.text = "Member Country".localized(using: "Localizable")
        secondSectionTitle.text = "Links".localized(using: "Localizable")
        itemMenu4.text = "Communication Office".localized(using: "Localizable")
        itemMenu5.text = "Departments".localized(using: "Localizable")
        itemMenu6.text = "Photos".localized(using: "Localizable")
        itemMenu7.text = "Videos".localized(using: "Localizable")
        thirdSectionTitle.text = "Communication".localized(using: "Localizable")
        itemMenu8.text = "Language".localized(using: "Localizable")
        itemMenu9.text = "Share".localized(using: "Localizable")
        itemMenu10.text = "Contact us".localized(using: "Localizable")

    }
    
    @IBAction func item0Selected(_ sender: UIButton) {
        delegate?.didSelectOption("option0")
    }
    @IBAction func item1Selected(_ sender: UIButton) {
        delegate?.didSelectOption("option1")
    }
    @IBAction func item2Selected(_ sender: UIButton) {
        delegate?.didSelectOption("option2")
    }
    @IBAction func item3Selected(_ sender: UIButton) {
        delegate?.didSelectOption("option3")
    }
    @IBAction func item4Selected(_ sender: UIButton) {
        delegate?.didSelectOption("option4")
    }
    @IBAction func item5Selected(_ sender: UIButton) {
        delegate?.didSelectOption("option5")
    }
    @IBAction func item6Selected(_ sender: UIButton) {
        delegate?.didSelectOption("option6")
    }
    @IBAction func item7Selected(_ sender: UIButton) {
        delegate?.didSelectOption("option7")
    }
    @IBAction func item8Selected(_ sender: UIButton) {
        delegate?.didSelectOption("option8")
    }
    @IBAction func item9Selected(_ sender: UIButton) {
        delegate?.didSelectOption("option9")
    }
    @IBAction func item10Selected(_ sender: UIButton) {
        delegate?.didSelectOption("option10")
    }
}

//
//  ChartSettingsViewController.swift
//  AOAD
//
//  Created by Hassine on 02/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import UIKit
import SwitchLanguage

class ChartSettingsViewController: UIViewController, UIStepperControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var selected_table:String = ""
    var selected_chart:String = ""
    var selected_item:[String] = []
    var selected_item2:[String] = []
    var selected_countries:[String] = []
    var selected_year_from:String = ""
    var selected_year_to:String = ""
    var choice:String = ""
    var selected_title:[String] = []
    

    @IBOutlet weak var yearFromStepper: UIStepperController!
    @IBOutlet weak var yearToStepper: UIStepperController!
    @IBOutlet weak var countryCheckBox: CheckBox!
    @IBOutlet weak var regionsCheckBox: CheckBox!
    @IBOutlet weak var countriesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        self.title = choice
        
        self.yearToStepper.delegate = self
        self.yearToStepper.tag = 10002
        self.yearToStepper.incrementBy(number: 1)
        self.yearToStepper.textColor(color: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
        self.yearToStepper.count = 2019
        selected_year_to = String(format: "%.0f", yearToStepper.count)
        
        self.yearFromStepper.delegate = self
        self.yearFromStepper.tag = 10001
        self.yearFromStepper.incrementBy(number: 1)
        self.yearFromStepper.textColor(color: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
        self.yearFromStepper.count = 2015
        selected_year_from = String(format: "%.0f", yearFromStepper.count)
        
        countryCheckBox.style = .circle
        countryCheckBox.borderStyle = .rounded
        regionsCheckBox.style = .circle
        regionsCheckBox.borderStyle = .rounded
        
    }
    
    func stepperDidAddValues(stepper: UIStepperController) {
        switch stepper.tag {
        case 10001:
             selected_year_from = String(format: "%.0f", stepper.count)
        case 10002:
            selected_year_to = String(format: "%.0f", stepper.count)
        default:
            break
        }
    }
    
    func stepperDidSubtractValues(stepper: UIStepperController) {
        switch stepper.tag {
        case 10001:
            selected_year_from = String(format: "%.0f", stepper.count)
        case 10002:
            selected_year_to = String(format: "%.0f", stepper.count)
        default:
            break
        }
    }
    
    @IBAction func checkCountryAction(_ sender: UIButton) {
        countryCheckBox.isChecked = true
        regionsCheckBox.isChecked = false
        countriesTableView.reloadData()
        selected_countries.removeAll()
    }
    
    @IBAction func checkRegionsAction(_ sender: UIButton) {
        countryCheckBox.isChecked = false
        regionsCheckBox.isChecked = true
        countriesTableView.reloadData()
        selected_countries.removeAll()
    }
    @IBAction func validate(_ sender: UIButton) {
        if selected_countries.count == 0 {
            
        }else {
            performSegue(withIdentifier: "viewChartSegue", sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if countryCheckBox.isChecked == true {
            return Constants.countries.count
        }else if regionsCheckBox.isChecked == true {
            return Constants.regions.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "countryCell")!
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let checkBox = cell.contentView.viewWithTag(301) as! CheckBox
        let flag = cell.contentView.viewWithTag(302) as! UIImageView
        let name = cell.contentView.viewWithTag(303) as! UILabel
        checkBox.style = .tick
        checkBox.borderStyle = .square
        if countryCheckBox.isChecked == true {
            flag.sd_setImage(with: URL(string: Constants.flags[indexPath.row]), placeholderImage: UIImage(named: "placeholder"))
            name.text = Constants.countries[indexPath.row]
        }else {
            flag.sd_setImage(with: URL(string: Constants.regions_flags[indexPath.row]), placeholderImage: UIImage(named: "placeholder"))
            name.text = Constants.regions[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checkbox = tableView.cellForRow(at: indexPath)?.contentView.viewWithTag(301) as! CheckBox
        if countryCheckBox.isChecked == true {
                if checkbox.isChecked == true {
                    checkbox.isChecked = false
                    selected_countries.remove(at: selected_countries.firstIndex(of: Constants.countries_item[indexPath.row])!)
                }else {
                    if selected_countries.count < 4 {
                        checkbox.isChecked = true
                        selected_countries.append(Constants.countries_item[indexPath.row])
                    }
                }
        }else {
        
            if checkbox.isChecked == true {
                checkbox.isChecked = false
                selected_countries.remove(at: selected_countries.firstIndex(of: Constants.regions_item[indexPath.row])!)
            }else {
                if selected_countries.count < 4 {
                    checkbox.isChecked = true
                    selected_countries.append(Constants.regions_item[indexPath.row])
                }
            }
        }
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewChartSegue" {
            let controller = segue.destination as! ChartViewController
            controller.choice = choice
            controller.selected_item = selected_item
            if selected_item2.count > 0 {
                controller.selected_item2 = selected_item2
            }
            controller.selected_table = selected_table
            controller.selected_chart = selected_chart
            controller.selected_countries = selected_countries
            controller.selected_year_from = selected_year_from
            controller.selected_year_to = selected_year_to
            controller.selected_title = selected_title
        }
    }
    

}

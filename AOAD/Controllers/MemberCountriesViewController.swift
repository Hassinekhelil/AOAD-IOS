//
//  MemberCountriesViewController.swift
//  AOAD
//
//  Created by Hassine on 12/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import UIKit
import SwitchLanguage

class MemberCountriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var countries:[Country] = []
    var url:String = ""
    @IBOutlet weak var countriesTableView: SelfSizedTableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.countriesTableView.tableFooterView = UIView()
        self.countriesTableView.rowHeight = UITableView.automaticDimension
        self.countriesTableView.estimatedRowHeight = 247
        
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.hidesBarsOnSwipe = true
        
        self.title = "List of member countries".localized(using: "Localizable")
        
        if Language.getCurrentLanguage() == "ar" {
            url = "http://aoadstat.org/MOBILE/Liste_Pays/liste_pays_ar.php"
        }else {
            url = "http://aoadstat.org/MOBILE/Liste_Pays/liste_pays_en.php"
        }
        
        getCountries()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let flag = cell.contentView.viewWithTag(501) as! UIImageView
        flag.sd_setImage(with: URL(string: countries[indexPath.row].flag), placeholderImage: UIImage(named: "placeholder"))
        let name = cell.contentView.viewWithTag(502) as! UILabel
        name.text = countries[indexPath.row].name
        let region = cell.contentView.viewWithTag(503) as! UILabel
        region.text = countries[indexPath.row].region
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func getCountries()  {
        
        NetworkManager.getCopuntries(url: url) { (error, data)  in
            self.countries = data
            self.countriesTableView.reloadData()
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

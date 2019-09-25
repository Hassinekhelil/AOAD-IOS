//
//  NetworkBDViewController.swift
//  AOAD
//
//  Created by Hassine on 13/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import UIKit
import SwitchLanguage
import Firebase

class NetworkBDViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var networkDBList:[NetworkDB] = []
    var lang:String = ""
    @IBOutlet weak var networkDBTableView: SelfSizedTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.hidesBarsOnSwipe = true
        
        self.networkDBTableView.tableFooterView = UIView()
        self.networkDBTableView.rowHeight = UITableView.automaticDimension
        self.networkDBTableView.estimatedRowHeight = 247
        
        if Language.getCurrentLanguage() == "ar" {
            lang = "ar"
        }else {
            lang = "en"
        }
        
        getNetworkDB()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return networkDBList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "networkDBCell", for: indexPath)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let image = cell.contentView.viewWithTag(701) as! UIImageView
        image.sd_setImage(with: URL(string: networkDBList[indexPath.row].image), placeholderImage: UIImage(named: "placeholder"))
        let title = cell.contentView.viewWithTag(702) as! UILabel
        title.text = networkDBList[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "networkDBDetailSegue", sender: nil)
    }
    
    func getNetworkDB()  {
        let messageDb = Database.database().reference().child("Galleryc")
        let query = messageDb.queryOrdered(byChild: "lang").queryEqual(toValue: lang)
        query.observe(.childAdded) { (snapshot) in
            let networkDB:NetworkDB = NetworkDB(data: snapshot.value as! [String: AnyObject])
            self.networkDBList.append(networkDB)
            self.networkDBTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "networkDBDetailSegue" {
            let controller = segue.destination as! DocumentDetailsViewController
            if let indexPath = networkDBTableView .indexPathForSelectedRow {
                controller.link = "http://docs.google.com/gview?embedded=true&url=" + networkDBList[indexPath.row].link
            }
        }
    }
}

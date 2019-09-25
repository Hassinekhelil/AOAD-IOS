//
//  DocumentsViewController.swift
//  AOAD
//
//  Created by Hassine on 13/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import UIKit
import SwitchLanguage
import SDWebImage
import Firebase

class DocumentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var documents:[Documuent] = []
    var lang:String = ""
    @IBOutlet weak var documentsTableView: SelfSizedTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.hidesBarsOnSwipe = true

        self.documentsTableView.tableFooterView = UIView()
        self.documentsTableView.rowHeight = UITableView.automaticDimension
        self.documentsTableView.estimatedRowHeight = 247
        
        if Language.getCurrentLanguage() == "ar" {
            lang = "ar"
        }else {
            lang = "en"
        }
        
        getDocuments()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "documentsCell", for: indexPath)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let image = cell.contentView.viewWithTag(601) as! UIImageView
        image.sd_setImage(with: URL(string: documents[indexPath.row].image), placeholderImage: UIImage(named: "placeholder"))
        let title = cell.contentView.viewWithTag(602) as! UILabel
        title.text = documents[indexPath.row].title
        let date = cell.contentView.viewWithTag(603) as! UILabel
        date.text = documents[indexPath.row].date
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "documentDetailsSegue", sender: nil)
    }
    
    func getDocuments()  {
        let messageDb = Database.database().reference().child("pdfdoc")
        let query = messageDb.queryOrdered(byChild: "language").queryEqual(toValue: lang)
        query.observe(.childAdded) { (snapshot) in
            let document:Documuent = Documuent(data: snapshot.value as! [String: AnyObject])
            self.documents.append(document)
            self.documentsTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "documentDetailsSegue" {
            let controller = segue.destination as! DocumentDetailsViewController
            if let indexPath = documentsTableView .indexPathForSelectedRow {
                controller.link = "http://docs.google.com/gview?embedded=true&url=" + documents[indexPath.row].link
            }
        }
    }
}

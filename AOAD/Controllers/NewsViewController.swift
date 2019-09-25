//
//  NewsViewController.swift
//  AOAD
//
//  Created by Hassine on 10/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import SwitchLanguage
import CoreData

class NewsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var newsTableView: SelfSizedTableView!
    var newsList:[News] = []
    var lang:String = ""
    var favortie:Bool = false
    var favorites: [Favorite] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.tableFooterView = UIView()
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.estimatedRowHeight = 400
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        if !favortie {
        getNews()
        }
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if favortie {
            self.title = "Favoris"
            getFavorites(list: &newsList)
            newsTableView.reloadData()
        } else {
            checkFavorite()
        }
    }
    
    func getNews() {
        let messageDb = Database.database().reference().child("Spacecraft")
        let query = messageDb.queryOrdered(byChild: "language").queryEqual(toValue: Language.getCurrentLanguage() )
        
        query.observe(.childAdded) { (snapshot) in
            let news:News = News(data: snapshot.value as! [String: AnyObject])
            self.newsList.append(news)
            DispatchQueue.main.async {
                self.checkFavorite()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "newsCell")!
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let image = cell.contentView.viewWithTag(401) as! UIImageView
        image.sd_setImage(with: URL(string: newsList[indexPath.row].image), placeholderImage: UIImage(named: "placeholder"))
        let title = cell.contentView.viewWithTag(402) as! UILabel
        title.text = newsList[indexPath.row].title
        let date = cell.contentView.viewWithTag(403) as! UILabel
        date.text = newsList[indexPath.row].date
        let fav_icon = cell.contentView.viewWithTag(404) as! UIImageView
        if newsList[indexPath.row].favorite {
            fav_icon.image = UIImage(named: "favoris_selected")
        }else {
            fav_icon.image = UIImage(named: "favoris_unselected")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "newsDetailsSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newsDetailsSegue" {
            let controller = segue.destination as! NewsDetailsViewController
            if let indexPath = newsTableView.indexPathForSelectedRow {
                controller.news = newsList[indexPath.row]
            }
        }
    }
    
    func getFavorites(list: inout [News]) {
        list.removeAll()
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        do {
            favorites = try managedContext.fetch(fetchRequest) as [Favorite]
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        for item in favorites {
            let news = News()
            news.id = Int(item.id)
            news.title = item.title!
            news.date = item.date!
            news.content = item.content!
            news.link = item.link!
            news.image = item.image!
            news.favorite = true
            list.append(news)
        }
    }
    
    func checkFavorite()  {
        var favortiesList:[News] = []
        getFavorites(list: &favortiesList)
        
        for news in newsList {
            for item in favortiesList {
                if news.id == item.id {
                    news.favorite = true
                }
            }
        }
        newsTableView.reloadData()
    }

}

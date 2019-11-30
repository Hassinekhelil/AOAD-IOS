//
//  NewsDetailsViewController.swift
//  AOAD
//
//  Created by Hassine on 12/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import UIKit
import SDWebImage
import WebKit
import CoreData

var MyObservationContext = 0

class NewsDetailsViewController: UIViewController {
    
    var news:News?
    var observing = false
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsContent: UIWebView!
    @IBOutlet weak var webViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsContent.scrollView.isScrollEnabled = false
        newsContent.delegate = self
        
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.hidesBarsOnSwipe = true
        
        if news!.favorite {
            let fav_btn = UIBarButtonItem(image: UIImage(named: "favoris_selected"), style: .plain, target: self, action: #selector(deleteNewsFromFavorites))
            self.navigationItem.rightBarButtonItem  = fav_btn
        } else {
            let fav_btn = UIBarButtonItem(image: UIImage(named: "favoris_unselected"), style: .plain, target: self, action: #selector(addNewsToFavorites))
            self.navigationItem.rightBarButtonItem  = fav_btn
        } 
        
        newsTitle.text = news?.title
        newsImage.sd_setImage(with: URL(string: news!.image), placeholderImage: UIImage(named: "placeholder"))
        newsContent.loadHTMLString(news!.content, baseURL: nil)
    }
    
    
    @IBAction func shareToSocialMedia(_ sender: UIButton) {
        if let name = URL(string: news!.link), !name.absoluteString.isEmpty {
            let objectsToShare = [name]
            let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    @objc func addNewsToFavorites() {
        let fav_btn = UIBarButtonItem(image: UIImage(named: "favoris_selected"), style: .plain, target: self, action: #selector(deleteNewsFromFavorites))
        self.navigationItem.rightBarButtonItem  = fav_btn
        //save to coredata
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedContext)!
        let favorite = NSManagedObject(entity: entity, insertInto: managedContext)
        favorite.setValue(news?.id, forKeyPath: "id")
        favorite.setValue(news?.title, forKeyPath: "title")
        favorite.setValue(news?.content, forKeyPath: "content")
        favorite.setValue(news?.date, forKeyPath: "date")
        favorite.setValue(news?.image, forKeyPath: "image")
        favorite.setValue(news?.link, forKeyPath: "link")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    @objc func deleteNewsFromFavorites() {
        let fav_btn = UIBarButtonItem(image: UIImage(named: "favoris_unselected"), style: .plain, target: self, action: #selector(addNewsToFavorites))
        self.navigationItem.rightBarButtonItem  = fav_btn
        //delete data from coredata
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %d",news!.id)
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
            for object in objects {
                managedContext.delete(object)
            }
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    deinit {
        //stopObservingHeight()
    }
    
    func startObservingHeight() {
        let options = NSKeyValueObservingOptions([.new])
        newsContent.scrollView.addObserver(self, forKeyPath: "contentSize", options: options, context: &MyObservationContext)
        observing = true;
    }
    
    func stopObservingHeight() {
        newsContent.scrollView.removeObserver(self, forKeyPath: "contentSize", context: &MyObservationContext)
        observing = false
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let keyPath = keyPath else {
            super.observeValue(forKeyPath: nil, of: object, change: change, context: context)
            return
        }
        switch keyPath {
        case "contentSize":
            if context == &MyObservationContext {
                webViewHeightConstraint.constant = newsContent.scrollView.contentSize.height
            }
        default:
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
}

extension NewsDetailsViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webViewHeightConstraint.constant = newsContent.scrollView.contentSize.height
        if (!observing) {
            startObservingHeight()
        }
    }
}

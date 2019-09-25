//
//  WhoAreWeViewController.swift
//  AOAD
//
//  Created by Hassine on 12/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import SwitchLanguage

class WhoAreWeViewController: UIViewController {
    
    var myTitle:String = ""
    var observing = false
    var option:String = ""
    var lang:String = "en"

    @IBOutlet weak var pageTitle: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var content: UIWebView!
    @IBOutlet weak var webViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        content.scrollView.isScrollEnabled = false
        content.delegate = self
        
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.hidesBarsOnSwipe = true

        self.title = myTitle
        
        if Language.getCurrentLanguage() == "ar" {
            lang = "ar"
        }else {
            lang = "en"
        }
        
        setupView()
        
    }
    
    func setupView()  {
        let messageDb = Database.database().reference().child("aoad")
        let query = messageDb.queryOrdered(byChild: "language").queryEqual(toValue: lang)
        switch option {
        case "option1":
            query.observe(.childAdded) { (snapshot) in
                let data = snapshot.value as! [String: AnyObject]
                self.pageTitle.text = data["presentation_title"] as? String
                self.image.sd_setImage(with: URL(string: (data["description_presentation"] as? String)!), placeholderImage: UIImage(named: "placeholder"))
                self.content.loadHTMLString(data["presentation_body"] as! String, baseURL: nil)
            }
            break
        case "option2":
          query.observe(.childAdded) { (snapshot) in
                print(snapshot)
                let data = snapshot.value as! [String: AnyObject]
                self.pageTitle.text = data["production_title"] as? String
                self.image.sd_setImage(with: URL(string: (data["description_production"] as? String)!), placeholderImage: UIImage(named: "placeholder"))
                self.content.loadHTMLString(data["production_body"] as! String, baseURL: nil)
            }
            break
        default:
            break
        }
    }
    

    deinit {
        stopObservingHeight()
    }
    
    func startObservingHeight() {
        let options = NSKeyValueObservingOptions([.new])
        content.scrollView.addObserver(self, forKeyPath: "contentSize", options: options, context: &MyObservationContext)
        observing = true;
    }
    
    func stopObservingHeight() {
        content.scrollView.removeObserver(self, forKeyPath: "contentSize", context: &MyObservationContext)
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
                webViewHeightConstraint.constant = content.scrollView.contentSize.height
            }
        default:
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

}
extension WhoAreWeViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webViewHeightConstraint.constant = content.scrollView.contentSize.height
        if (!observing) {
            startObservingHeight()
        }
    }
}

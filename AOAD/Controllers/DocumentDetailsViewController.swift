//
//  DocumentDetailsViewController.swift
//  AOAD
//
//  Created by Hassine on 13/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import UIKit

class DocumentDetailsViewController: UIViewController {
    
    var link:String = ""

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.hidesBarsOnSwipe = true
        
        let url = URLRequest(url: URL(string: link)!)
        webView.loadRequest(url)

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

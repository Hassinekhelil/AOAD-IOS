//
//  FirstViewController.swift
//  CarbonKitSwiftExample
//
//  Created by Ermal Kaleci on 06/10/2017.
//  Copyright © 2017 Ermal Kaleci. All rights reserved.
//

import UIKit
import SDWebImage
import SwitchLanguage

class StatisticsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var url:String = "http://aoadstat.org/MOBILE/Menu/menu_en.php"
    var lang:String = ""
    var type:String = "menu"
    var choice:String = ""
    var strings: [String] = []
    var images: [String] = []
    var names: [String] = []
    
    @IBOutlet weak var statisticsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        if type == "details" || type == "submenu" {
            self.title = choice
        }else {
            if Language.getCurrentLanguage() == "ar" {
                url = "http://aoadstat.org/MOBILE/Menu/menu.php"
            }else if Language.getCurrentLanguage() == "en" {
                url = "http://aoadstat.org/MOBILE/Menu/menu_en.php"
            }else {
                url = "http://aoadstat.org/MOBILE/Menu/menu_fr.php"
            }
        }
        
        loadData()
    }
    
    func loadData(){
        let params = [
            "req": choice
        ]
        if type == "submenu" {
            NetworkManager.getSubmenu(param: params as NSDictionary) { (error, data) in
                var response:String = data
                for _ in response {
                    if let index = response.index(of: ",") {
                        let substring = response[..<index]
                        let nextIndex = response.index(after: index)
                        response = String(response[nextIndex...])
                        self.strings.append(String(substring))
                    }
                }
                for n in 0...self.strings.count-1 {
                    if self.strings[n].contains("annee"){
                        self.names.append(self.strings[n+1])
                    }else if self.strings[n].contains("pop_mas_y") {
                        self.images.append("http://aoadstat.org/MOBILE/image_m/"+self.strings[n+1])
                    }
                }
                self.statisticsTableView.reloadData()
            }
        }else {
            NetworkManager.getStatisticsMenu(url: url) { (error, data) in
                var response:String = data!
                for _ in response {
                    if let index = response.index(of: ",") {
                        let substring = response[..<index]
                        let nextIndex = response.index(after: index)
                        response = String(response[nextIndex...])
                        self.strings.append(String(substring))
                    }
                }
                for n in 0...self.strings.count-1 {
                    if self.strings[n].contains("annee"){
                        self.names.append(self.strings[n+1])
                    }else if self.strings[n].contains("pop_mas_y") {
                        if self.type == "details" {
                            self.images.append("http://aoadstat.org/MOBILE/image_m/"+self.strings[n+1])
                        }else {
                            self.images.append("http://aoadstat.org/FLAG/"+self.strings[n+1])
                        }
                    }
                }
                self.statisticsTableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "statisticsCell")!
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let image = cell.contentView.viewWithTag(100) as! UIImageView
        image.sd_setImage(with: URL(string: images[indexPath.row]), placeholderImage: UIImage(named: "placeholder"))
        let name = cell.contentView.viewWithTag(101) as! UILabel
        name.text = names[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == "menu" {
            let detailsStatistics = storyboard?.instantiateViewController(withIdentifier: "StatisticsViewController") as! StatisticsViewController
            
            switch names[indexPath.row] {
            case "البيانات والإحصاءات الزراعية", "Agricultural data and statistics", "Données et statistiques agricoles" :
                if Language.getCurrentLanguage() == "ar" {
                    detailsStatistics.url = "http://aoadstat.org/MOBILE/Menu/libelle_agri.php"
                }else if Language.getCurrentLanguage() == "en" {
                    detailsStatistics.url = "http://aoadstat.org/MOBILE/Menu/libelle_agri_en.php"
                } else {
                    detailsStatistics.url = "http://aoadstat.org/MOBILE/Menu/libelle_agri_fr.php"
                }
                break
            case "البيانات والإحصاءات الـمـائـية", "Water data and statistics", "Données et statistiques des ressources hydrauliques":
                if Language.getCurrentLanguage() == "ar" {
                    detailsStatistics.url = "http://aoadstat.org/MOBILE/Menu/libelle_eau.php"
                }else if Language.getCurrentLanguage() == "en" {
                    detailsStatistics.url = "http://aoadstat.org/MOBILE/Menu/libelle_eau_en.php"
                } else {
                    detailsStatistics.url = "http://aoadstat.org/MOBILE/Menu/libelle_eau_fr.php"
                }
                break
            case "البيانات والإحصاءات السمكية", "Fishery data and statistics", "Données et statistiques de la pêche":
                if Language.getCurrentLanguage() == "ar" {
                    detailsStatistics.url = "http://aoadstat.org/MOBILE/Menu/libelle_peche.php"
                }else if Language.getCurrentLanguage() == "en" {
                    detailsStatistics.url = "http://aoadstat.org/MOBILE/Menu/libelle_peche_en.php"
                } else {
                    detailsStatistics.url = "http://aoadstat.org/MOBILE/Menu/libelle_peche_fr.php"
                }
                break
            default:
                break
            }
            detailsStatistics.type = "details"
            detailsStatistics.choice = names[indexPath.row]
            self.navigationController?.pushViewController(detailsStatistics, animated: true)
        }else {
            self.navigationController?.pushViewController(selectedController(indexPath: indexPath), animated: true)
        }
    }
    
    func selectedController(indexPath: IndexPath) -> UIViewController {
        
        switch names[indexPath.row] {
        case "الناتج المحلي الإجمالي", "Gross domestic product", "Produit Intérieur Brut", "التنظيمات المهنية للمنتجين الزراعين", "Professional organizations of agricultural producers", "Organisations professionnelles de producteurs agricoles", "قيمة الاستثمارات الكلية بالدولة", "The value of the total investments in the country", "La valeur des investissements totaux dans le pays":
            let controller = storyboard?.instantiateViewController(withIdentifier: "mapsViewController") as! MapsViewController
            controller.choice = names[indexPath.row]
            return controller
        case "السكان والقوى العاملة", "Population and labor force", "Population et force de travail", "الرقعة الأرضية والزراعية والمراعي والغابات", "Agricultural land and grasslands and forests", "Terres agricoles prairies et forêts", "التمويل الزراعي والسمكي", "Agricultural and fisheries finance", "Financement agricole et de la pêche", "الميزان التجاري السلعي الكلى والزراعى والغذائى", "Total trade balance of agricultural and food commodities", "Balance commerciale totale de produits agricoles et alimentaires", "الإنتاج النباتي  الحبوب والدرنات والمحاصيل السكرية", "Plant production: cereals and tubers and sugar crops", "Production végétale: céréales et tubercules et cultures sucrières", "توزيع اعداد الحيوانات وفقا للانواع ", "Distribution of animals according to species", "Répartition des animaux selon les espèces", "انتاج اللحوم الحمراء", "Production of red meat", "Production de viande rouge", "الانتاج الداجني", "Poultry production", "Production de volaille", "منتجات حيوانية أخرى", "Other animal products", "Autres produits origine animale", "انتاج اللبن", "Milk production", "Production de lait", "الانتاج السمكي", "Fish production", "Production de poisson", "اعداد الآلات الزراعية", "Preparation of agricultural machinery", "Préparation de machines agricoles", "المبيدات والعلاجات البيطرية المستخدمة", "Pesticides and veterinary treatments used", "Pesticides et traitements vétérinaires utilisés", "كمية الأسمدة الكيماوية المنتجة والمستهلكة", "Quantity of chemical fertilizers produced and consumed", "Quantité engrais chimiques produits et consommés":
            let controller = storyboard?.instantiateViewController(withIdentifier: "chartTypeViewController") as! ChartTypeViewController
            controller.choice = names[indexPath.row]
            //controller.selected_tab = ""
            return controller
        case "الإنتاج الحيواني", "Animal Production", "Production Animale", "مستلزمات الإنتاج الزراعي", "Agricultural production requirements", "Besoins pour la production agricole", "كمية وقيمة الصادرات الزراعية البيئية", "Quantity and value of environmental agricultural exports", "Quantité et valeur des exportations agricoles environnementales", "كمية وقيمة الصادرات الوطنية وإعادة الصادر والواردات الزراعية", "Quantity and value of national exports re-export and agricultural imports", "Quantité et valeur des exportations nationales réexportées et des importations agricoles", "كمية وقيمة الواردات الزراعية البيئية", "Quantity and value of environmental agricultural imports", "Quantité et valeur des importations agricoles environnementales":
             let detailsStatistics = storyboard?.instantiateViewController(withIdentifier: "StatisticsViewController") as! StatisticsViewController
             detailsStatistics.type = "submenu"
             detailsStatistics.choice = names[indexPath.row]
             return detailsStatistics
        default:
            return UIViewController()
        }
    }
    
    
}

extension StringProtocol {
    func index(of string: Self, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    func endIndex(of string: Self, options: String.CompareOptions = []) -> Index? {
        return range(of: string, options: options)?.upperBound
    }
    func indexes(of string: Self, options: String.CompareOptions = []) -> [Index] {
        var result: [Index] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...].range(of: string, options: options) {
                result.append(range.lowerBound)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
    func ranges(of string: Self, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...].range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}

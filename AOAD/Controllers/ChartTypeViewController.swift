//
//  ChartTypeViewController.swift
//  AOAD
//
//  Created by Hassine on 02/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import UIKit

class ChartTypeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var checkListTableView: UITableView!
    @IBOutlet weak var checkListTitle: UILabel!
    var choice:String = ""
    var selected_tab:[String] = []
    var item_tab:[String] = []
    var item_tab2:[String] = []
    var selected_item:[String] = []
    var selected_item2:[String] = []
    var selected_chart:String = "pie"
    var selected_table:String = ""
    var selected_title:[String] = []
    var item_list:[Item] = []
    
    var chartNumber:Int = 0
    @IBOutlet weak var prevBtn: UIImageView!
    @IBOutlet weak var nextBtn: UIImageView!
    @IBOutlet weak var chartImage: UIImageView!
    @IBOutlet weak var validateBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        validateBtn.setTitle("Validate statistics".localized(using: "Localizable"), for: .normal)
        checkListTitle.text = "Choice of statistical items to compare".localized(using: "Localizable")
        self.title = choice
        prevBtn.isHidden = true
            
        switch choice {
        case "السكان والقوى العاملة", "Population and labor force", "Population et force de travail":
            selected_tab = Constants.population_lib
            item_tab = Constants.population_lib_item
            selected_table = "population_active"
            break
        case "الرقعة الأرضية والزراعية والمراعي والغابات", "Agricultural land and grasslands and forests", "Terres agricoles prairies et forêts":
            selected_tab = Constants.terre_lib
            item_tab = Constants.terre_lib_item
            selected_table = "terees_agric_t3"
            break
        case "التمويل الزراعي والسمكي", "Agricultural and fisheries finance", "Financement agricole et de la pêche":
            selected_tab = Constants.finance_aqua_lib
            item_tab = Constants.finance_aqua_lib_item
            selected_table = "finance_agri_hali_tab7"
            break
        case "الميزان التجاري السلعي الكلى والزراعى والغذائى", "Total trade balance of agricultural and food commodities", "Balance commerciale totale de produits agricoles et alimentaires":
            selected_tab = Constants.balance_lib
            item_tab = Constants.balance_lib_item
            selected_table = "balance_agric_tab13"
            break
        case "الإنتاج النباتي : الحبوب والدرنات والمحاصيل السكرية", "Plant production: cereals and tubers and sugar crops", "Production végétale: céréales et tubercules et cultures sucrières":
            selected_tab = Constants.prodcer_lib
            item_tab = Constants.prodcer_lib_item
            item_tab2 = Constants.prodcer_lib_item2
            selected_table = "cereales_tab91"
            break
        case  "توزيع اعداد الحيوانات وفقا للانواع ", "Distribution of animals according to species", "Répartition des animaux selon les espèces", " توزيع اعداد الحيوانات وفقا للانواع":
            selected_tab = Constants.viande_qte_lib
            item_tab = Constants.viande_qte_lib_item
            item_tab2 = Constants.viande_qte_lib_item2
            selected_table = "anim_especes_tab11"
            break
        case "انتاج اللحوم الحمراء", "Production of red meat", "Production de viande rouge":
            selected_tab = Constants.viande_prod_lib
            item_tab = Constants.viande_prod_lib_item
            item_tab2 = Constants.viande_prod_lib_item2
            selected_table = "prod_vian_roug_tab111"
            break
        case "الانتاج الداجني", "Poultry production", "Production de volaille":
            selected_tab = Constants.poulet_lib
            item_tab = Constants.poulet_lib_item
            selected_table = "prod_vian_pou_tab113"
            break
        case "منتجات حيوانية أخرى", "Other animal products", "Autres produits origine animale":
            selected_tab = Constants.prod_animal_other_lib
            item_tab = Constants.prod_animal_other_lib_item
            item_tab2 = Constants.prod_animal_other_lib_item2
            selected_table = "prod_autres_tab116"
            break
        case "انتاج اللبن", "Milk production", "Production de lait" :
            selected_tab = Constants.prod_lait_lib
            item_tab = Constants.prod_lait_lib_item
            selected_table = "prod_lait_tab112"
            break
        case  "الانتاج السمكي", "Fish production", "Production de poisson" :
            selected_tab = Constants.prod_fish_lib
            item_tab = Constants.prod_fish_lib_item
            selected_table = "prod_poisson_tab114"
            break
        case   "اعداد الآلات الزراعية", "Preparation of agricultural machinery", "Préparation de machines agricoles":
            selected_tab = Constants.machinisme_lib
            item_tab = Constants.machinisme_lib_item
            selected_table = "machinismes_tab121"
            break
        case "المبيدات والعلاجات البيطرية المستخدمة", "Pesticides and veterinary treatments used", "Pesticides et traitements vétérinaires utilisés":
            selected_tab = Constants.fongicide_vet_lib
            item_tab = Constants.fongicide_vet_lib_item
            item_tab2 = Constants.fongicide_vet_lib_item2
            selected_table = "trait_vet_tab123"
            break
        case "كمية الأسمدة الكيماوية المنتجة والمستهلكة", "Quantity of chemical fertilizers produced and consumed", "Quantité engrais chimiques produits et consommés":
            selected_tab = Constants.pesticide_prodconsom_lib
            item_tab = Constants.pesticide_prodconsom_lib_item
            item_tab2 = Constants.pesticide_prodconsom_lib_item2
            selected_table = "engrais_tab122"
            break
        case "كمية وقيمة الواردات الوطنية من الاسمدة الازوتية والفوسفاتية والبوتاسية", "Quantity and value of national imports of nitrogen and phosphate and potash fertilizers", "Quantité et valeur des importations nationales d engrais azotés phosphatés et potassiques":
            selected_tab = Constants.import_potass_lib
            item_tab = Constants.import_potass_lib_item
            item_tab2 = Constants.import_potass_lib_item2
            selected_table = "im_import_expot_engrais_tab143"
            break
        case "كمية وقيمة الصادرات الوطنية من الاسمدة الازوتية والفوسفاتية والبوتاسية", " Quantity and value of national exports of nitrogen and phosphate and potash fertilizers", "Quantité et valeur des exportations nationales d engrais azotés phosphatés et potassiques":
            selected_tab = Constants.export_potass_lib
            item_tab = Constants.export_potass_lib_item
            item_tab2 = Constants.export_potass_lib_item2
            selected_table = "ex_import_expot_engrais_tab143"
            break
        case " كمية وقيمة الصادرات الوطنية من المطهرات والمبيدات والالات الزراعية", "Quantity and value of national exports of disinfectants pesticides and agricultural machinery", "Quantité et valeur des exportations nationales de désinfectants de pesticides et de machines agricoles":
            selected_tab = Constants.export_import_moutahir_lib
            item_tab = Constants.export_import_moutahir_lib_item
            item_tab2 = Constants.export_import_moutahir_lib_item2
            selected_table = "ex_import_expot_mach_tab142"
            break
        default:
            break
        }
            
        for n in 0...selected_tab.count-1 {
            item_list.append(Item(name: selected_tab[n], checked: false))
        }

        
        
    }
    @IBAction func validate(_ sender: UIButton) {
        if selected_item.count != 0 || selected_item2.count != 0 {
            performSegue(withIdentifier: "charSettingsSegue", sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "checkListCell")!
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        let checkBox = cell.contentView.viewWithTag(200) as! CheckBox
        checkBox.style = .tick
        checkBox.borderStyle = .square
        checkBox.checkboxBackgroundColor = #colorLiteral(red: 0.2319583297, green: 0.4583241343, blue: 0.1610836089, alpha: 1)
        if item_list[indexPath.row].checked {
            checkBox.isChecked = true
        } else {
            checkBox.isChecked = false
        }
        let name = cell.contentView.viewWithTag(201) as! UILabel
        name.text = item_list[indexPath.row].name
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let checkbox = tableView.cellForRow(at: indexPath)?.contentView.viewWithTag(200) as! CheckBox

        if indexPath.row == 0 {
            if checkbox.isChecked == true {
                checkbox.isChecked = false
                for item in item_list {
                    item.checked = false
                }
                selected_item.removeAll()
                selected_item2.removeAll()
                selected_title.removeAll()
            }else {
                checkbox.isChecked = true
                for item in item_list {
                    item.checked = true
                }
                selected_item = item_tab
                for n in 1...selected_tab.count-1 {
                 selected_title.append(selected_tab[n])
                }
                switch choice {
                case "الإنتاج النباتي  الحبوب والدرنات والمحاصيل السكرية", "Plant production: cereals and tubers and sugar crops", "Production végétale: céréales et tubercules et cultures sucrières", "توزيع اعداد الحيوانات وفقا للانواع ", "Distribution of animals according to species", "Répartition des animaux selon les espèces", "انتاج اللحوم الحمراء", "Production of red meat", "Production de viande rouge", "منتجات حيوانية أخرى", "Other animal products", "Autres produits origine animale", "المبيدات والعلاجات البيطرية المستخدمة", "Pesticides and veterinary treatments used", "Pesticides et traitements vétérinaires utilisés", "كمية الأسمدة الكيماوية المنتجة والمستهلكة", "Quantity of chemical fertilizers produced and consumed", "Quantité engrais chimiques produits et consommés", "كمية وقيمة الواردات الوطنية من الاسمدة الازوتية والفوسفاتية والبوتاسية", " Quantity and value of national imports of nitrogen and phosphate and potash fertilizers", "Quantité et valeur des importations nationales d engrais azotés phosphatés et potassiques":
                    selected_item2 = item_tab2
                    break
                default:
                    break
                }
            }
            self.checkListTableView.reloadData()

        }else {
            if checkbox.isChecked == true {
                checkbox.isChecked = false
                selected_item.remove(at: selected_item.firstIndex(of: item_tab[indexPath.row-1])!)
                selected_title.remove(at: selected_title.firstIndex(of: selected_tab[indexPath.row])!)

                switch choice {
                case "الإنتاج النباتي  الحبوب والدرنات والمحاصيل السكرية", "Plant production: cereals and tubers and sugar crops", "Production végétale: céréales et tubercules et cultures sucrières", "توزيع اعداد الحيوانات وفقا للانواع ", "Distribution of animals according to species", "Répartition des animaux selon les espèces", "انتاج اللحوم الحمراء", "Production of red meat", "Production de viande rouge", "منتجات حيوانية أخرى", "Other animal products", "Autres produits origine animale", "المبيدات والعلاجات البيطرية المستخدمة", "Pesticides and veterinary treatments used", "Pesticides et traitements vétérinaires utilisés", "كمية الأسمدة الكيماوية المنتجة والمستهلكة", "Quantity of chemical fertilizers produced and consumed", "Quantité engrais chimiques produits et consommés", "كمية وقيمة الواردات الوطنية من الاسمدة الازوتية والفوسفاتية والبوتاسية", " Quantity and value of national imports of nitrogen and phosphate and potash fertilizers", "Quantité et valeur des importations nationales d engrais azotés phosphatés et potassiques":
                    selected_item2.remove(at: selected_item.firstIndex(of: item_tab2[indexPath.row-1])!)
                    break
                default:
                        break
                }
            }else {
                checkbox.isChecked = true
                selected_item.append(item_tab[indexPath.row-1])
                selected_title.append(selected_tab[indexPath.row])
                switch choice {
                case "الإنتاج النباتي  الحبوب والدرنات والمحاصيل السكرية", "Plant production: cereals and tubers and sugar crops", "Production végétale: céréales et tubercules et cultures sucrières", "توزيع اعداد الحيوانات وفقا للانواع ", "Distribution of animals according to species", "Répartition des animaux selon les espèces", "انتاج اللحوم الحمراء", "Production of red meat", "Production de viande rouge", "منتجات حيوانية أخرى", "Other animal products", "Autres produits origine animale", "المبيدات والعلاجات البيطرية المستخدمة", "Pesticides and veterinary treatments used", "Pesticides et traitements vétérinaires utilisés", "كمية الأسمدة الكيماوية المنتجة والمستهلكة", "Quantity of chemical fertilizers produced and consumed", "Quantité engrais chimiques produits et consommés", "كمية وقيمة الواردات الوطنية من الاسمدة الازوتية والفوسفاتية والبوتاسية", " Quantity and value of national imports of nitrogen and phosphate and potash fertilizers", "Quantité et valeur des importations nationales d engrais azotés phosphatés et potassiques":
                    selected_item2.append(item_tab2[indexPath.row-1])
                    break
                default:
                    break
                }
            }
        }
    }
    
    @IBAction func nextChart(_ sender: UIButton) {
        switch chartNumber {
        case 0:
            selected_chart = "area"
            chartImage.image = UIImage(named: "area")
            chartNumber += 1
            prevBtn.isHidden = false
            break
        case 1:
            selected_chart = "line"
            chartImage.image = UIImage(named: "line")
            chartNumber += 1
            break
//        case 2:
//            selected_chart = "bar"
//            chartImage.image = UIImage(named: "bar")
//            chartNumber += 1
//            break
//        case 3:
//            selected_chart = ""
//            chartImage.image = UIImage(named: "polar")
//            chartNumber += 1
//            break
//        case 4:
//            selected_chart = ""
//            chartImage.image = UIImage(named: "stacked")
//            chartNumber += 1
//            break
        case 2:
            selected_chart = "mikko"
            chartImage.image = UIImage(named: "mikko")
            chartNumber += 1
            nextBtn.isHidden = true
            break
        case 6:
//            selected_chart = "pie"
//            chartImage.image = UIImage(named: "pie")
//            chartNumber = 0
            break
        default:
            break
        }
    }
    @IBAction func prevChart(_ sender: UIButton) {
        switch chartNumber {
        case 0:
//            selected_chart = "area"
//            chartImage.image = UIImage(named: "area")
//            chartNumber += 1
            break
        case 1:
            selected_chart = "pie"
            chartImage.image = UIImage(named: "pie")
            chartNumber -= 1
            prevBtn.isHidden = true
            break
        case 2:
            selected_chart = "area"
            chartImage.image = UIImage(named: "area")
            chartNumber -= 1
            break
        case 3:
            selected_chart = "line"
            chartImage.image = UIImage(named: "line")
            chartNumber -= 1
            nextBtn.isHidden = false
            break
//        case 4:
//            selected_chart = ""
//            chartImage.image = UIImage(named: "bar")
//            chartNumber -= 1
//            break
//        case 5:
//            selected_chart = ""
//            chartImage.image = UIImage(named: "polar")
//            chartNumber -= 1
//            break
//        case 6:
//            selected_chart = ""
//            chartImage.image = UIImage(named: "stacked")
//            chartNumber -= 1
//            nextBtn.isHidden = false
//            break
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "charSettingsSegue" {
            let controller = segue.destination as! ChartSettingsViewController
            controller.choice = choice
            controller.selected_item = selected_item
            if selected_item2.count > 0 {
                controller.selected_item2 = selected_item2
            }
            controller.selected_table = selected_table
            controller.selected_chart = selected_chart
            controller.selected_title = selected_title
        }
    }
}

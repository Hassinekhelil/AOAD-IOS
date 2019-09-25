//
//  File.swift
//  AOAD
//
//  Created by Hassine on 02/09/2019.
//  Copyright © 2019 aoad. All rights reserved.
//

import Foundation

struct Constants{
    
    //url
    static let pib_secteur_date = "http://aoadstat.org/MOBILE/Menu/pib_secteur_date.php"
    static let get_submenu = "http://aoadstat.org/MOBILE/Menu/sous_menu.php"
    static let get_statistic_data = "http://aoadstat.org/MOBILE/Menu/statistic_ios.php"
    static let get_communication_office = "http://aoadstat.org/MOBILE/Liste_Pays/bureau.php"
    static let get_departments = "http://aoadstat.org/MOBILE/Liste_Pays/listemin.php"

    
    static let population_lib:[String] = ["All".localized(using: "Localizable"),"Population".localized(using: "Localizable"),"Rural population".localized(using: "Localizable"),"Man power".localized(using: "Localizable"),"Agricultural Manpower".localized(using: "Localizable")]
    static let population_lib_item:[String] = ["pop_mas_y","pop_rurale_mas_y","main_euvre_mas_y","main_euvre_agri_mas_y"]
    
    
    
    static let terre_lib:[String] = ["All".localized(using: "Localizable"),"Geographic area".localized(using: "Localizable"),"Total arable land".localized(using: "Localizable"),"Forest area".localized(using: "Localizable"),"Grassland".localized(using: "Localizable")]
    static let terre_lib_item:[String] = ["geo_area","total_arab_land","forest_area","pastures_area"]
    
    
    
    static let finance_aqua_lib:[String] = ["All".localized(using: "Localizable"),"Total Agricultural and Fisheries Loans".localized(using: "Localizable"),"Total Support to Agriculture and Fisheries Sector".localized(using: "Localizable"),"Total Subsidies to Agriculture and Fisheries Sector".localized(using: "Localizable")]
    static let finance_aqua_lib_item:[String] = ["tot_pret_agri_pech","tot_sout_agri_pech","tot_subv_agri_pech"]
    
    
    
    static let balance_lib:[String] = ["All".localized(using: "Localizable"),"Wholesale Exports".localized(using: "Localizable"),"Agricultural exports".localized(using: "Localizable"),"Wholesale Imports".localized(using: "Localizable"),"Agricultural imports".localized(using: "Localizable")]
    static let balance_lib_item:[String] = ["export_tot","export_agric","import_tot","import_agric"]
    
    
    
    static let prodcer_lib:[String] = ["All".localized(using: "Localizable"),"Area of grain".localized(using: "Localizable"),"Production of Grain".localized(using: "Localizable"),"Tubers area".localized(using: "Localizable"),"Production of tubers".localized(using: "Localizable"),"Sugar Crop Area".localized(using: "Localizable"),"Production of Sugar Crop".localized(using: "Localizable")]
    static let prodcer_lib_item:[String] = ["SUM(spble+smble+spmais+smmais+smsorgho+spsorgho+spsorgho+smsorgho+spriz+smriz+sporge+smorge+smmillet+spmillet+spautre+smautre)AS cereal_superf","SUM(qpble+qmble+qpmais+qmmais+qmsorgho+qpsorgho+qpsorgho+qmsorgho+qpriz+qmriz+qporge+qmorge+qmmillet+qpmillet+qpautre+qmautre)AS cereal_prod","SUM(sppom_terre+smpom_terre+spautres_tub+smautres_tub) AS pomt_superf","SUM(qppom_terre+qmpom_terre+qpautres_tub+qmautres_tub) AS pomt_prod","SUM(spcan_sucre+smcan_sucre+spbetterave+smbetterave) AS sucre_superf","SUM(qpcan_sucre+qmcan_sucre+qpbetterave+qmbetterave) AS sucre_prod"]
     static let prodcer_lib_item2:[String] = ["cereal_superf","cereal_prod","pomt_superf","pomt_prod","sucre_superf","sucre_prod"]
    
    
    static let viande_qte_lib:[String] = ["All".localized(using: "Localizable"),"Number of cows per thousand head".localized(using: "Localizable"),"Number of Sheep in Thousand Heads".localized(using: "Localizable"),"Goats in 1000 Heads".localized(using: "Localizable"),"Number of camels per thousand head".localized(using: "Localizable"),"Number of horses per thousand head".localized(using: "Localizable"),"Number of mules and donkeys per thousand head".localized(using: "Localizable")]
    static let viande_qte_lib_item:[String] = ["SUM(vacfl+vacfe+vacml+vacme) as cereal_superf", "SUM(moufl+moufe+mouml+moume)AS cereal_prod","SUM(chevrfl+chevrfe+chevrml+chevrme)AS pomt_superf","SUM(ebel) AS pomt_prod","SUM(cheval) AS sucre_superf", "SUM(ane) AS sucre_prod"]
      static let viande_qte_lib_item2:[String] = ["cereal_superf", "cereal_prod","pomt_superf","SUM(ebel) AS pomt_prod","sucre_superf", "sucre_prod"]
    
    
    static let viande_prod_lib:[String] = ["All".localized(using: "Localizable"),"Total red meat production per ton".localized(using: "Localizable"),"Production of meat from cattle, cattle and buffalo per ton".localized(using: "Localizable"),"Production of meat from sheep and goats per ton".localized(using: "Localizable"),"Meat production from camels per ton".localized(using: "Localizable"),"Production of viscous meat per ton".localized(using: "Localizable")]
    static let viande_prod_lib_item:[String] = ["SUM(totprodintviroug+totprodextviroug) AS cereal_superf","SUM(prodintbov+prodextbov) as cereal_prod","SUM(prodintmou+prodextmou)AS pomt_superf","SUM(prodintibel+prodextibel)AS pomt_prod","SUM(totprodintviavis+totprodextviavis) AS sucre_superf",]
    static let viande_prod_lib_item2:[String] = ["cereal_superf","cereal_prod","pomt_superf","pomt_prod","sucre_superf",]
    
    
    
    static let poulet_lib:[String] = ["All".localized(using: "Localizable"),"Production of a thousand tons of chicken meat".localized(using: "Localizable"),"Production of other poultry meat by thousand tons ".localized(using: "Localizable"),"Production of cat meat in thousand tons".localized(using: "Localizable"),"Egg production in million eggs".localized(using: "Localizable")]
    static let poulet_lib_item:[String] = ["prodvipoul","prodviautre","prodvilap","prodvihac","prodeuf"]
    
    
    
    
    static let prod_animal_other_lib:[String] = ["All".localized(using: "Localizable"),"Production of honey per ton".localized(using: "Localizable"),"Production of tonnes of leather".localized(using: "Localizable")]
    static let prod_animal_other_lib_item:[String] = ["SUM(prodmimu+prodmibo)AS cereal_superf","SUM(prodcuir)AS cereal_prod","SUM(prodlaine)AS pomt_superf"]
     static let prod_animal_other_lib_item2:[String] = ["cereal_superf","cereal_prod","pomt_superf"]
    
    
    
    static let prod_lait_lib:[String] = ["All".localized(using: "Localizable"),"Production of cow's milk per ton".localized(using: "Localizable"),"Production of buffalo milk per ton".localized(using: "Localizable"),"Production of sheep milk per ton".localized(using: "Localizable"),"Production of goat milk per ton".localized(using: "Localizable"),"Production of camel milk per ton".localized(using: "Localizable")]
    static let prod_lait_lib_item:[String] = ["prodvac","prodbuf","prodmou","prodchev","prodibel"]
    
    
    
    
    static let prod_fish_lib:[String] = ["All".localized(using: "Localizable"),"Ton fisheries from marine sources".localized(using: "Localizable"),"Farms from tonnes of marine sources".localized(using: "Localizable"),"Tons of freshwater fisheries per ton".localized(using: "Localizable"),"Farms from freshwater sources per ton".localized(using: "Localizable"),"Ton algae fisheries".localized(using: "Localizable"),"Ton algae farms".localized(using: "Localizable")]
    static let prod_fish_lib_item:[String] = ["prodppemer","prodpfemer","prodppedou","prodpfedou","prodppalg","prodpfalg"]
    
    
    
    
    static let machinisme_lib:[String] = ["All".localized(using: "Localizable"),"Tractors".localized(using: "Localizable"),"Combine harvesters".localized(using: "Localizable"),"Seeders".localized(using: "Localizable"),"Insecticide Sprayers".localized(using: "Localizable"),"Water Pumps".localized(using: "Localizable"),"Other Supplies".localized(using: "Localizable")]
    static let machinisme_lib_item:[String] = ["tracteur","moisson","graine","pulver","pompe","autre"]
    
    
    
    
    static let fongicide_vet_lib:[String] = ["All".localized(using: "Localizable"),"Total pesticide production in terms of quantity per ton".localized(using: "Localizable"),"Total pesticide production in terms of value in million dollars".localized(using: "Localizable"),"Total veterinary treatments in terms of quantity per ton".localized(using: "Localizable"),"Total Veterinary Remedies in Million Dollars".localized(using: "Localizable")]
    static let fongicide_vet_lib_item:[String] = ["SUM(fongic+herbicide+insect)AS cereal_superf","SUM(vfongic+vherbicide+vinsect)AS cereal_prod", "SUM(vaccin+serum+beaute+dieteti+chimique)AS pomt_superf", "SUM(vvaccin+vserum+vbeaute+vdieteti+vchimique)AS pomt_prod"]
     static let fongicide_vet_lib_item2:[String] = ["cereal_superf","cereal_prod", "pomt_superf", "pomt_prod"]
    
    
    static let pesticide_prodconsom_lib:[String] = ["All".localized(using: "Localizable"),"National production of nitrogen fertilizers per tonv".localized(using: "Localizable"),"Total nitrogen fertilizer consumption in ton".localized(using: "Localizable"),"National production of phosphate fertilizers per ton".localized(using: "Localizable"),"Total consumption of phosphate fertilizers in ton".localized(using: "Localizable"),"National production of potash fertilizers per ton".localized(using: "Localizable"),"Total consumption of potassium fertilizer in ton".localized(using: "Localizable")]
    static let pesticide_prodconsom_lib_item:[String] = ["SUM(pazote+pazote1+pazote2)AS pazote", "SUM(tazote+tazote1+tazote2)as tazote", "SUM(pphosphate+pphosphate1+pphosphate2)as pphosphate", "SUM(tphosphate1+tphosphate+tphosphate2)as tphosphate", "SUM(ppotassium+ppotassium1+ppotassium2)as ppotassium", "SUM(tpotassium+tpotassium1+tpotassium2)AS tpotassioom"]
     static let pesticide_prodconsom_lib_item2:[String] = ["pazote", "tazote", "pphosphate", "tphosphate", "ppotassium", "tpotassioom"]
    
    
    static let countries:[String] = ["Hashemite kingdom of Jordan".localized(using: "Localizable"),"United Arab Emirates".localized(using: "Localizable"),"Kingdom of Bahrain".localized(using: "Localizable"),"Republic of Tunisia".localized(using: "Localizable"),"Republic of Algeria".localized(using: "Localizable"),"Republic of Djibouti".localized(using: "Localizable"),"Kingdom of Saudi Arabia".localized(using: "Localizable"),"Republic of The Sudan".localized(using: "Localizable"),"Syrian Arab Republic".localized(using: "Localizable"),"Somali Democratic Republic".localized(using: "Localizable"),"Republic of Iraq".localized(using: "Localizable"),"Sultanate of Oman".localized(using: "Localizable"),"State of Palestine".localized(using: "Localizable"),"Qatar".localized(using: "Localizable"),"Kuwait".localized(using: "Localizable"),"Republic of Lebanon".localized(using: "Localizable"),"Libya".localized(using: "Localizable"),"Arab Republic of Egypt".localized(using: "Localizable"),"Kingdom of Morocco".localized(using: "Localizable"),"Islamic Republic of Mauritania".localized(using: "Localizable"),"Republic of Yemen".localized(using: "Localizable"),"Union of the Comoros".localized(using: "Localizable")]
    
        static let countries_item:[String] = ["Hashemite kingdom of Jordan","United Arab Emirates","Kingdom of Bahrain","Republic of Tunisia","Republic of Algeria","Republic of Djibouti","Kingdom of Saudi Arabia","Republic of The Sudan","Syrian Arab Republic","Somali Democratic Republic","Republic of Iraq","Sultanate of Oman","State of Palestine","Qatar","Kuwait","Republic of Lebanon","Libya","Arab Republic of Egypt","Kingdom of Morocco","Islamic Republic of Mauritania","Republic of Yemen","Union of the Comoros"]
    
    static let flags:[String] = ["http://aoadstat.org/FLAG/jordan.png","http://aoadstat.org/FLAG/uae.png","http://aoadstat.org/FLAG/bahrein.png","http://aoadstat.org/FLAG/tunisie.png","http://aoadstat.org/FLAG/algerie.png","http://aoadstat.org/FLAG/djibouti.png","http://aoadstat.org/FLAG/saudi.png","http://aoadstat.org/FLAG/sudan.png","http://aoadstat.org/FLAG/syria.png","http://aoadstat.org/FLAG/somali.png","http://aoadstat.org/FLAG/iraq.png","http://aoadstat.org/FLAG/oman.png","http://aoadstat.org/FLAG/palestine.png","http://aoadstat.org/FLAG/qatar.png","http://aoadstat.org/FLAG/kuwait.png","http://aoadstat.org/FLAG/lebnon.png","http://aoadstat.org/FLAG/libya.png","http://aoadstat.org/FLAG/egypt.png","http://aoadstat.org/FLAG/maroc.png","http://aoadstat.org/FLAG/mauritanie.jpg","http://aoadstat.org/FLAG/yemen.png","http://aoadstat.org/FLAG/comoros.png"]
    
    static let regions:[String] = ["Arab Maghreb".localized(using: "Localizable"),"Middle".localized(using: "Localizable"),"Arab Orient".localized(using: "Localizable"),"Arabian Peninsula".localized(using: "Localizable")]
    static let regions_item:[String] = ["Arab Maghreb","Middle","Arab Orient","Arabian Peninsula"]
    
    static let regions_flags:[String] = ["http://aoadstat.org/FLAG/Flag_of_Maghreb.png","http://aoadstat.org/FLAG/Flag_of_Maghreb.png","http://aoadstat.org/FLAG/Flag_of_Maghreb.png","http://aoadstat.org/FLAG/peninsula.png"]
    
}

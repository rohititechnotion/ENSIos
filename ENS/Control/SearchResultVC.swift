//
//  SearchResultVC.swift
//  ENS
//
//  Created by itechnotion-mac1 on 20/03/18.
//  Copyright © 2018 itechnotion-mac1. All rights reserved.
//

import UIKit

class SearchResultVC: UIViewController {

    @IBOutlet weak var tableSearchResult: UITableView!
    @IBOutlet weak var lblSeachKeywords: UILabel!
    var searchReasultList = SearchResultData()
    var searchKEyword = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIColor.clear.as1ptImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIColor.yellow.as1ptImage()
        lblSeachKeywords.text = searchKEyword
       
        self.tableSearchResult.rowHeight = UITableViewAutomaticDimension
        self.tableSearchResult.estimatedRowHeight = 50
        self.tableSearchResult.register(UINib(nibName: "ResultCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
}

// MARK: - Extention for UITAbleview Delegate and Datasourse

extension SearchResultVC : UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return searchReasultList.group_list.count
        }else if section == 1{
            return searchReasultList.category_list.count
        }else if section == 2{
            return searchReasultList.subcategory_list.count
        }else{
            return searchReasultList.person_list.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ResultCell
        if indexPath.section == 0{
            cell.lblName.text = searchReasultList.group_list[indexPath.row].name
        }else if indexPath.section == 1{
            cell.lblName.text = searchReasultList.category_list[indexPath.row].name
        }else if indexPath.section == 2{
            cell.lblName.text = searchReasultList.subcategory_list[indexPath.row].name
        }else if indexPath.section == 3{
            cell.lblName.text = searchReasultList.person_list[indexPath.row].name
        }
        return cell
    }
    
}

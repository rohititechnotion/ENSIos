//
//  SearchVC.swift
//  ENS
//
//  Created by itechnotion-mac1 on 19/03/18.
//  Copyright © 2018 itechnotion-mac1. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var trendingTable: UITableView!
    var searchReasultList = SearchResultData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.setBackgroundImage(UIColor.clear.as1ptImage(), for: .default)
//        navigationController?.navigationBar.shadowImage = UIColor.yellow.as1ptImage()
    }
    
    
    // MARK: - IBAction MEthods (Click Events)
    
    @IBAction func actionChangeSearchvalue(_ sender: UITextField) {
        
    }
    
    // MARK: - user define methods
    func getPerson(){
        
        let parameter = "keyword=".appending(txtSearch.text!)
        Webservice.web_search.webserviceFetch(parameters: parameter)
        { (parsedData,error,httpResponse) in
            if(error){
                self.hideProgressHUD()
                self.ShowAlertMessage(title: "", message: NETWORKMESSAGE, buttonText: "OK")
            }else
                if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300{
                    // let info = parsedData["result"] as! NSDictionary
                    let status = parsedData["status"] as! String
                    if (status == "1"){
                        let info = parsedData["result"] as! NSDictionary
                        var groupList = [SearchResult]()
                        var categoryList = [SearchResult]()
                        var subCategoryList = [SearchResult]()
                        var personList = [SearchResult]()
                        
                        self.searchReasultList = SearchResultData()
                        
                        //let group = info["group_list"] as? [JSONType]
                        if let group = info["group_list"] as? [JSONType]{
                            let groupData = group.flatMap(SearchResult.init)
                            groupList.append(contentsOf: groupData)
                        }
                        
                        if let category = info["category_list"] as? [JSONType]{
                            let categoryData = category.flatMap(SearchResult.init)
                            categoryList.append(contentsOf: categoryData)
                        }
                        
                        if let subCategory = info["subcategory_list"] as? [JSONType]{
                            let subCategoryData = subCategory.flatMap(SearchResult.init)
                            subCategoryList.append(contentsOf: subCategoryData)
                        }
                        
                        if let person = info["person_list"] as? [JSONType]{
                            let personData = person.flatMap(SearchResult.init)
                            personList.append(contentsOf: personData)
                        }
                        
                        self.searchReasultList.group_list.append(contentsOf: groupList)
                        self.searchReasultList.category_list.append(contentsOf: categoryList)
                        self.searchReasultList.subcategory_list.append(contentsOf: subCategoryList)
                        self.searchReasultList.person_list.append(contentsOf: personList)
                        
                        self.hideProgressHUD()
                        let searchResultView = self.storyboard?.instantiateViewController(withIdentifier: "SearchResultVC") as! SearchResultVC
                        searchResultView.searchReasultList = self.searchReasultList
                        searchResultView.searchKEyword = self.txtSearch.text!
                        self.navigationController?.pushViewController(searchResultView, animated: true)
                    }else{
                        self.hideProgressHUD()
                        self.ShowAlertMessage(title: "", message: parsedData["message"] as! String, buttonText: "OK")
                    }
                }else if httpResponse.statusCode == 401{
                    self.hideProgressHUD()
                    var Error : String!
                    Error = parsedData["message"] as! String
                    self.ShowAlertMessage(title: "", message: Error, buttonText: "OK")
            }
        }
    }
    // MARK: - user define methods
    
    func ShowAlertMessage(title : String, message: String, buttonText : String)  {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: buttonText, style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

// MARK: - Extenstion For UitextField Delegate

extension SearchVC : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if (txtSearch.text?.isEmpty)!{
            self.ShowAlertMessage(title: "", message: "Please search some keywords.", buttonText: "OK")
        }else{
            self.showProgressHUD()
            self.getPerson()
        }
//        let searchResultView = self.storyboard?.instantiateViewController(withIdentifier: "SearchResultVC") as! SearchResultVC
//        self.navigationController?.pushViewController(searchResultView, animated: true)
        return true
    }
}

// MARK: - Extenstion For UITableview Delegate and DataSourse

extension SearchVC : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        let label1 = cell.viewWithTag(1) as! UILabel // 1 is tag of first label;
        label1.text = "AAAA"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
         return 20
    }
}

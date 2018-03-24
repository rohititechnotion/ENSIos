//
//  CategoryVC.swift
//  ENS
//
//  Created by itechnotion-mac1 on 19/03/18.
//  Copyright © 2018 itechnotion-mac1. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {

    @IBOutlet weak var collectionCategory: UICollectionView!
    var groupName = String()
    var groupID = String()

    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblCategoryName: UILabel!
    var catagoryList = [CategoryData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showProgressHUD()
        lblLocation.text = appDelegate.location
        let nibName = UINib(nibName: "CategoryCell", bundle:nil)
        collectionCategory.register(nibName, forCellWithReuseIdentifier: "cell")
        self.getCategory()
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblCategoryName.text = groupName
      /*
        var cmd = CategoryData(id: "1", title: "Events")
        catagoryList.append(cmd)
        
        cmd = CategoryData(id: "2", title: "Category1")
        catagoryList.append(cmd)
        
        cmd = CategoryData(id: "3", title: "Category2")
        catagoryList.append(cmd)
        
        cmd = CategoryData(id: "3", title: "Category3")
        catagoryList.append(cmd)
        
        cmd = CategoryData(id: "3", title: "Category4")
        catagoryList.append(cmd)
 */
    }
    
    func getCategory(){
        let parameter = "group_id=".appending(groupID)
        Webservice.web_category.webserviceFetch(parameters: parameter)
        { (parsedData,error,httpResponse) in
            if(error){
                self.hideProgressHUD()
                self.ShowAlertMessage(title: "", message: NETWORKMESSAGE, buttonText: "OK")
            }else
                if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300{
                    let info = parsedData["result"] as! NSDictionary
                    self.catagoryList = [CategoryData]()
                    let info1 = info["categories"] as! [JSONType]
                    let category = info1.flatMap(CategoryData.init)
                    //                    self.fetchingState = .fetched(customers)
                    self.catagoryList.append(contentsOf: category)
                    
//                    for blog in info1 {
//                        var cmd = CategoryData()
//                        cmd.category_id = blog["category_id"] as? String
//                        cmd.name = blog["name"] as? String
//                        cmd.description = blog["description"] as? String
//                        cmd.group_id = blog["group_id"] as? String
//                        cmd.img = blog["img"] as? String
//                        cmd.active_flag = blog["active_flag"] as? String
//                        cmd.date_created = blog["date_created"] as? String
//                        self.catagoryList.append(cmd)
//                    }
                    self.collectionCategory.reloadData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                        self.hideProgressHUD()
                        // Put your code which should be executed with a delay here
                    })
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

// MARK: - Exenstion UICOlletionview Delegate And DataSourse And DataFlowLayout

extension CategoryVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    //1
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return catagoryList.count
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as! CategoryCell
        cell.lblTitle.text = catagoryList[indexPath.row].name
        let url = URL(string: catagoryList[indexPath.row].img!)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            cell.imgProfile.boderRoundwithShadow()
            cell.imgProfile.image = UIImage(data: imageData)
        }else  {
            cell.imgProfile.image = #imageLiteral(resourceName: "default")
        }
        
        // Configure the cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewControllerCategory = self.storyboard?.instantiateViewController(withIdentifier: "SubCategoryVC") as! SubCategoryVC
        viewControllerCategory.categoryName = catagoryList[indexPath.row].name
        viewControllerCategory.categoryID = catagoryList[indexPath.row].category_id
        viewControllerCategory.groupName = self.groupName
        self.navigationController?.pushViewController(viewControllerCategory, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        return CGSize(width: 80.0, height: 100.0)
    }
    
}


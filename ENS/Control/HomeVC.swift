//
//  HomeVC.swift
//  ENS
//
//  Created by itechnotion-mac1 on 19/03/18.
//  Copyright © 2018 itechnotion-mac1. All rights reserved.
//

import UIKit
import SDWebImage

class HomeVC: UIViewController {

    @IBOutlet weak var collectionCategory: UICollectionView!
    
    //var catagoryList = [CategoryData]()
   var groupList = [GroupData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().backgroundColor = UIColor.white

        let nibName = UINib(nibName: "CategoryCell", bundle:nil)
        
        collectionCategory.register(nibName, forCellWithReuseIdentifier: "cell")
        self.getGroupList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 /*
        var cmd = CategoryData(id: "1", title: "Marketing")
        catagoryList.append(cmd)
        
        cmd = CategoryData(id: "2", title: "ITC Services")
        catagoryList.append(cmd)
        
        cmd = CategoryData(id: "3", title: "Building")
        catagoryList.append(cmd)
   */
    }
    
    func getGroupList(){
        self.showProgressHUD()
        let parameter = ""
        Webservice.web_group.webserviceFetch(parameters: parameter)
        { (parsedData,error,httpResponse) in
            if(error){
                self.hideProgressHUD()
                self.ShowAlertMessage(title: "", message: NETWORKMESSAGE, buttonText: "OK")
            }else
                if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300{
//                    let info = parsedData["info"] as! NSDictionary
                    self.groupList = [GroupData]()
                    let info1 = parsedData["result"] as! [JSONType]
                    
                    let customers = info1.flatMap(GroupData.init)
//                    self.fetchingState = .fetched(customers)
                    self.groupList.append(contentsOf: customers)
                    

//                    for blog in info1 {
//                        var cmd = GroupData()
//                        cmd.group_id =  blog["group_id"] as? String
//                        cmd.name =  blog["name"] as? String
//                        cmd.list_id =  blog["list_id"] as? String
//                        cmd.description =  blog["description"] as? String
//                        cmd.active_flag =  blog["active_flag"] as? String
//                        cmd.date_created =  blog["date_created"] as? String
//                        self.groupList.append(cmd)
//                    }

                    self.collectionCategory.reloadData()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                        self.hideProgressHUD()
                        // Put your code which should be executed with a delay here
                    })
                    
                    print(parsedData)
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

extension HomeVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    //1
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return groupList.count
    }
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                      for: indexPath) as! CategoryCell
        cell.lblTitle.text = groupList[indexPath.row].name
        let url = URL(string: groupList[indexPath.row].img!)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            cell.imgProfile.boderRoundwithShadow()
            cell.imgProfile.sd_setImage(with: url,placeholderImage: nil)
//            cell.imgProfile.image = UIImage(data: imageData)
            
        }
        
        
//        imageView.sd_setImage(with: url, placeholderImage: arrayImage[j])
        
        
        
        // Configure the cell
        return cell
    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewControllerCategory = self.storyboard?.instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
        viewControllerCategory.groupName = groupList[indexPath.row].name
        viewControllerCategory.groupID = groupList[indexPath.row].group_id
//        let url = URL(string: "http://i.imgur.com/w5rkSIj.jpg")
//        let data = try? Data(contentsOf: url)
//        
//        if let imageData = data {
//            let image = UIImage(data: imageData)
//        }
        
        self.navigationController?.pushViewController(viewControllerCategory, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        return CGSize(width: 80.0, height: 100.0)
    }
    
}

//
//  StructureModal.swift
//  ENS
//
//  Created by itechnotion-mac1 on 19/03/18.
//  Copyright © 2018 itechnotion-mac1. All rights reserved.
//

import Foundation

struct GroupData {
    var group_id : String!
    var name : String!
    var description : String?
    var list_id : String?
    var active_flag : String?
    var date_created : String?
    var img : String?
}

extension GroupData : JSONParsable{
    init?(json: JSONType?) {
        self.group_id = json?["group_id"] as? String
        self.name = json?["name"] as? String
        self.description = json?["description"] as? String
        self.list_id = json?["list_id"] as? String
        self.active_flag = json?["active_flag"] as? String
        self.date_created = json?["date_created"] as? String
        self.img = json?["img"] as? String
    }
}

struct CategoryData {
    var category_id : String!
    var name : String!
    var description : String?
    var group_id : String!
    var img : String?
    var active_flag : String?
    var date_created : String?
}

extension CategoryData : JSONParsable{
    init?(json: JSONType?) {
        self.category_id = json?["category_id"] as? String
        self.name = json?["name"] as? String
        self.description = json?["description"] as? String
        self.group_id = json?["group_id"] as? String
        self.img = json?["img"] as? String
        self.active_flag = json?["active_flag"] as? String
        self.date_created = json?["date_created"] as? String
    }
}

struct SubCategoryData{
    var subcategory_id : String!
    var name : String?
    var description : String?
    var category_id : String?
    var icon : String?
    var active_flag : String?
    var date_created : String?
}

extension SubCategoryData : JSONParsable{
    init?(json: JSONType?) {
        self.subcategory_id = json?["subcategory_id"] as? String
        self.name = json?["name"] as? String
        self.description = json?["description"] as? String
        self.category_id = json?["category_id"] as? String
        self.icon = json?["icon"] as? String
        self.active_flag = json?["active_flag"] as? String
        self.date_created = json?["date_created"] as? String
    }
}

struct  PersonData {
    var person_id : String?
    var name : String?
    var position : String?
    var company : String?
    var email : String?
    var designation : String?
    var contact_number : String?
    var img : String?
    var active_flag : String?
    var date_created : String?
    var location_id : String?
    var location_name : String?
}

extension PersonData : JSONParsable{
    init?(json: JSONType?) {
        self.person_id  = json?["person_id"] as? String
        self.name  = json?["name"] as? String
        self.position  = json?["position"] as? String
        self.company  = json?["company"] as? String
        self.email  = json?["email"] as? String
        self.designation  = json?["designation"] as? String
        self.contact_number  = json?["contact_number"] as? String
        self.img  = json?["img"] as? String
        self.active_flag  = json?["active_flag"] as? String
        self.date_created  = json?["date_created"] as? String
        self.location_id  = json?["location_id"] as? String
        self.location_name  = json?["location_name"] as? String
    }
}


struct SearchResultData {
    var group_list = [SearchResult]()
    var category_list = [SearchResult]()
    var subcategory_list = [SearchResult]()
    var person_list = [SearchResult]()
}


struct SearchResult {
    var name : String?
}

extension SearchResult : JSONParsable{
    init?(json: JSONType?) {
        self.name = json?["name"] as? String
    }
}


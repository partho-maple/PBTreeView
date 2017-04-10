//
//  TreeViewData.swift
//  FamilyTree
//
//  Created by Partho Biswas on 3/14/17.
//  Copyright © 2017 Partho Biswas. All rights reserved.
//

class TreeViewData {
    var level: Int
    var details: RelationshipDetails?
    
    var id: String
    var parentId: String
    
    
    init?(level: Int, details: RelationshipDetails, id: String, parentId: String) {
        self.level = level
        self.details = details
        self.id = id
        self.parentId = parentId
    }
}



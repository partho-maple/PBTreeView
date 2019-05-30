//
//  TreeViewNodeItem.swift
//  FamilyTree
//
//  Created by Partho Biswas on 3/14/17.
//  Copyright © 2017 Partho Biswas. All rights reserved.
//

class TreeViewNodeItem {
    var nodeLevel: Int?
    var isExpanded: Bool?
    var nodeObject: RelationshipDetails?
    var nodeChildren: [TreeViewNodeItem]?
}

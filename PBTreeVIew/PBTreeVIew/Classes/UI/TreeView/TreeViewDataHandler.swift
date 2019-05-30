//
//  TreeViewDataHandler.swift
//  PBTreeVIew
//
//  Created by Partho Biswas on 4/11/17.
//  Copyright © 2017 Partho Biswas. All rights reserved.
//

import UIKit

class TreeViewDataHandler {

    //MARK:  Creating tree view data source here.
    var nodes: [TreeViewNodeItem] = []
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(expandCollapseNode(_:)), name: NSNotification.Name(rawValue: "TreeNodeButtonClicked"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver("TreeNodeButtonClicked")
    }
    
    @objc func expandCollapseNode(_ notification: Notification) {
        //        self.LoadDisplayArray()
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "RelodeTreeView"), object: self)
        
    }
    
    public func configureTreeViewDatasource(_ relationDetails: [RelationshipDetails]) -> [TreeViewNodeItem]? {
        
        nodes = self.loadInitialNodes((self.createDataSourceWith(relationDetails)))
        
        
        
        return refreshNodes()
    }
    
    func refreshNodes() -> [TreeViewNodeItem]? {
        var nodeDataSource = [TreeViewNodeItem]()
        for node: TreeViewNodeItem in nodes {
            nodeDataSource.append(node)
            if (node.isExpanded == true) {
                self.addChildrenNode(node.nodeChildren!, parentNodeDataSource: &nodeDataSource)
            }
        }
        return nodeDataSource
    }
    
    private func addChildrenNode(_ childrenNodeDataSource: [TreeViewNodeItem], parentNodeDataSource:  inout [TreeViewNodeItem]) {
        for node: TreeViewNodeItem in childrenNodeDataSource {
            parentNodeDataSource.append(node)
            if (node.isExpanded == true ) {
                if (node.nodeChildren != nil) {
                    self.addChildrenNode(node.nodeChildren!, parentNodeDataSource: &parentNodeDataSource)
                }
            }
        }
    }
    
    private func loadInitialNodes(_ dataList: [TreeViewData]) -> [TreeViewNodeItem] {
        var nodes: [TreeViewNodeItem] = []
        
        for data in dataList where data.level == 0 {
            
            let node: TreeViewNodeItem = TreeViewNodeItem()
            node.nodeLevel = data.level
            node.nodeObject = data.details as RelationshipDetails?
            node.isExpanded = true
            let newLevel = data.level + 1
            node.nodeChildren = loadChildrenNodes(dataList, level: newLevel, parentId: data.id)
            
            if (node.nodeChildren?.count == 0) {
                node.nodeChildren = nil
            }
            
            nodes.append(node)
        }
        
        return nodes
    }
    
    private func createDataSourceWith(_ relationDetails: [RelationshipDetails]) -> [TreeViewData]
    {
        var data: [TreeViewData] = []
        
        for relation in relationDetails {
            data.append(TreeViewData(level: 0, details: relation, id: (relation.social_security_number)!, parentId: "-1")!)
            
            self.addNodeToDataSourceWith(lavel: 0, relations: relation.relatives!, parentID: (relation.social_security_number)!, currentNodeList: &data)
        }
        
        return data
        
    }
    
    
    private func addNodeToDataSourceWith(lavel: Int, relations: [RelationshipDetails], parentID: String, currentNodeList: inout [TreeViewData]) -> [TreeViewData] {
        
        for relation in relations {
            
            currentNodeList.append(TreeViewData(level: (lavel + 1), details: relation, id: (relation.social_security_number)!, parentId: parentID)!)
            
            if (relation.relatives != nil) {
                self.addNodeToDataSourceWith(lavel: (lavel + 1), relations: relation.relatives!, parentID: relation.social_security_number!, currentNodeList: &currentNodeList)
            }
            
        }
        return currentNodeList
    }
    
    //MARK:  Recursive Method to Create the Children/Grandchildren....  node arrays
    
    private func loadChildrenNodes(_ dataList: [TreeViewData], level: Int, parentId: String) -> [TreeViewNodeItem] {
        var nodes: [TreeViewNodeItem] = []
        
        for data in dataList where data.level == level && data.parentId == parentId {
            
            let node: TreeViewNodeItem = TreeViewNodeItem()
            node.nodeLevel = data.level
            node.nodeObject = data.details as RelationshipDetails?
            
            node.isExpanded = false
            
            let newLevel = level + 1
            node.nodeChildren = loadChildrenNodes(dataList, level: newLevel, parentId: data.id)
            
            if (node.nodeChildren?.count == 0) {
                node.nodeChildren = nil
            }
            
            nodes.append(node)
        }
        
        return nodes
    }
    
}

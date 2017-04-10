//
//  PBTreeViewController.swift
//  PBTreeVIew
//
//  Created by Partho Biswas on 4/9/17.
//  Copyright © 2017 Partho Biswas. All rights reserved.
//

import UIKit

class PBTreeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var famityTreeTableView: UITableView!
    
    var displayArray = [TreeViewNodeItem]()
    var nodes: [TreeViewNodeItem] = []
    var data: [TreeViewData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.famityTreeTableView.delegate = self
        self.famityTreeTableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(PBTreeViewController.expandCollapseNode(_:)), name: NSNotification.Name(rawValue: "TreeNodeButtonClicked"), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let relations: [RelationshipDetails]? = readJson(JSON_File_Name)
        
        if (relations != nil) {
            //MARK:  Creating tree datasource here.
            self.nodes = self.loadInitialNodes(self.createDataSourceWith(relations!))
            self.LoadDisplayArray()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // MARK: - Tableview methodes
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let node: TreeViewNodeItem = self.displayArray[indexPath.row]
        let cell  = (self.famityTreeTableView.dequeueReusableCell(withIdentifier: "FamilyTreeTableViewCell") as! FamilyTreeTableViewCell)
        
        let relation = node.nodeObject as! RelationshipDetails?
        
        cell.treeNode = node
        cell.titleLable.text = relation?.name
        cell.subTitleLable.text = relation?.relation
        
        if (node.isExpanded == true) {
            cell.setTheButtonBackgroundImage(UIImage(named: "whiteOpen")!)
        } else {
            cell.setTheButtonBackgroundImage(UIImage(named: "whiteClose")!)
        }
        
        cell.setNeedsDisplay()
        
        return cell
    }

    // MARK: - Utility methodes
    
    private func readJson(_ fileName: String) -> [RelationshipDetails]? {
        do {
            if let file = Bundle.main.url(forResource: fileName, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])

                let relationObjects = Relations(JSON: json as! [String : Any])!
                
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    print(object)
                    
                    return relationObjects.relations!
                } else if let object = json as? [Any] {
                    // json is an array
                    print(object)
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("No such file")
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    
    
    
    
    
    
    
    //MARK:  Node/Data Functions
    
    func expandCollapseNode(_ notification: Notification) {
        self.LoadDisplayArray()
        
        DispatchQueue.main.async {
            self.famityTreeTableView.reloadData()
//            self.showNoDataFoundViewIfNeeded(self.displayArray.count)
        }
    }
    
    
    func LoadDisplayArray() {
        self.displayArray = [TreeViewNodeItem]()
        for node: TreeViewNodeItem in nodes {
            self.displayArray.append(node)
            if (node.isExpanded == true) {
                self.addChildrenArray(node.nodeChildren!)
            }
        }
    }
    
    func addChildrenArray(_ childrenArray: [TreeViewNodeItem]) {
        for node: TreeViewNodeItem in childrenArray {
            self.displayArray.append(node)
            if (node.isExpanded == true ) {
                if (node.nodeChildren != nil) {
                    self.addChildrenArray(node.nodeChildren!)
                }
            }
        }
    }
    
    //MARK:  Creating tree view data source here.
    
    func loadInitialNodes(_ dataList: [TreeViewData]) -> [TreeViewNodeItem] {
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
    
    func createDataSourceWith(_ relationDetails: [RelationshipDetails]) -> [TreeViewData]
    {
        var data: [TreeViewData] = []
        
        for relation in relationDetails {
            data.append(TreeViewData(level: 0, details: relation, id: (relation.social_security_number)!, parentId: "-1")!)
            
            self.addNodeToDataSourceWith(lavel: 0, relations: relation.relatives!, parentID: (relation.social_security_number)!, currentNodeList: &data)
        }
        
        return data
        
    }
    
    
    func addNodeToDataSourceWith(lavel: Int, relations: [RelationshipDetails], parentID: String, currentNodeList: inout [TreeViewData]) -> [TreeViewData] {
        
        for relation in relations {
            
            currentNodeList.append(TreeViewData(level: (lavel + 1), details: relation, id: (relation.social_security_number)!, parentId: parentID)!)
            
            if (relation.relatives != nil) {
                self.addNodeToDataSourceWith(lavel: (lavel + 1), relations: relation.relatives!, parentID: relation.social_security_number!, currentNodeList: &currentNodeList)
            }
            
        }
        return currentNodeList
    }
    
    //MARK:  Recursive Method to Create the Children/Grandchildren....  node arrays
    
    func loadChildrenNodes(_ dataList: [TreeViewData], level: Int, parentId: String) -> [TreeViewNodeItem] {
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

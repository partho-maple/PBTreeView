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
    var dataHandler: TreeViewDataHandler? = TreeViewDataHandler()
    
    
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
            self.nodes = dataHandler!.loadInitialNodes((dataHandler?.createDataSourceWith(relations!))!)
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
        
        let relation = node.nodeObject 
        
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

}

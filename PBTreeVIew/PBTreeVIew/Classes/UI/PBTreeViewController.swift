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
    
    var treeViewDataSource = [PBTreeViewNodeItem]()
    var dataHandler: PBTreeViewDataHandler? = PBTreeViewDataHandler()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting up delegates and observer. This step is necessary
        self.famityTreeTableView.delegate = self
        self.famityTreeTableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(PBTreeViewController.relodeTreeView(_:)), name: NSNotification.Name(rawValue: "RelodeTreeView"), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Loading and converting JSON data
        let relations: [RelationshipDetails]? = readJson(JSON_File_Name)
        
        if (relations != nil) {
            //  Creating tree datasource here.
            self.treeViewDataSource = (dataHandler?.configureTreeViewDatasource(relations!))!
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
        return treeViewDataSource.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let node: PBTreeViewNodeItem = self.treeViewDataSource[indexPath.row]
        let cell  = (self.famityTreeTableView.dequeueReusableCell(withIdentifier: "FamilyTreeTableViewCell") as! PBTreeViewTableCell)
        
        let relation = node.nodeObject 
        
        cell.treeNode = node
        cell.titleLable.text = relation?.name
        cell.subTitleLable.text = relation?.relation
        
        if (node.isExpanded == true) {
            cell.setTheButtonBackgroundImage(UIImage(named: "arrow_down")!)
        } else {
            cell.setTheButtonBackgroundImage(UIImage(named: "arrow_right")!)
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
    

    
    
    @objc func relodeTreeView(_ notification: Notification) {
        self.treeViewDataSource = (dataHandler?.refreshNodes())!
        DispatchQueue.main.async {
            self.famityTreeTableView.reloadData()
        }
    }

}

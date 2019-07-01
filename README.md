# PBTreeView

<p align="center">
<a href="https://developer.apple.com/swift/" target="_blank">
<img src="https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat" alt="Swift 5.0">
</a>
<a href="https://developer.apple.com/swift/" target="_blank">
<img src="https://img.shields.io/badge/Platforms-OS%20X%20%7C%20Linux%20-lightgray.svg?style=flat" alt="iOS">
</a>
<a href="http://perfect.org/licensing.html" target="_blank">
<img src="https://img.shields.io/badge/License-Apache-lightgrey.svg?style=flat" alt="License Apache">
</a>
<a href="http://twitter.com/ParthoBiswas007" target="_blank">
<img src="https://img.shields.io/badge/Twitter-@ParthoBiswas007-blue.svg?style=flat" alt="PerfectlySoft Twitter">
</a>
</p>

----------

An UITreeView implementation from UITableView that Apple missed in its UIKit framework. And it is in pure Swift.

<p align="center" >★★ <b>Star our github repository to help us!</b> ★★</p>
<p align="center" >Created by <a href="http://parthobiswas.com/">Partho Biswas</a> (<a href="http://www.twitter.com/ParthoBiswas007">@ParthoBiswas007</a>)</p>

## What's in it

- [x] An UITreeView implementation from UITableView.
- [x] An iOS application showing it's implementation and usage.

## Preview
![preview](/Preview.gif?raw=true)  

## Requirements

iOS 8.0+ / Swift 5.0+

## Setup and Usage
This `PBTreeView` has been drawn over `UITableView`. Every row/node of the TreeView represents a `UITableViewCell` with a custom object.


> Step 1:
* First you need to arrange some datasource that seems like a tree. Check this [JSON datasource](https://github.com/partho-maple/PBTreeView/blob/master/PBTreeVIew/PBTreeVIew/Supporting%20FIles/getRelation.json) as example. 
* This JSON data contains [RelationshipDetails](https://github.com/partho-maple/PBTreeView/blob/master/PBTreeVIew/PBTreeVIew/Classes/Model/JSON/RelationshipDetails.swift) object as primary unit. This object will contain the information for each node of the tree. This object need to have an unique identifire. In this case, it's `social_security_number`.

> Step 2:
* Create a `TreeViewDataHandler` object and call it's following function passing the parsed data array
```
public func configureTreeViewDatasource(_ relationDetails: [RelationshipDetails]) -> [TreeViewNodeItem]?
```
And use the return value of the above function as TreeView's data source. Lile following.
```
var dataHandler: TreeViewDataHandler? = TreeViewDataHandler()
    
let relations: [RelationshipDetails]? = readJson(JSON_File_Name)
var treeViewDataSource = [TreeViewNodeItem]()
treeViewDataSource = (dataHandler?.configureTreeViewDatasource(relations!))!
```

> Step 3:
* Listen for `RelodeTreeView` notification to relode the TreeView.
```
NotificationCenter.default.addObserver(self, selector: #selector(relodeTreeView(_:)), name: NSNotification.Name(rawValue: "RelodeTreeView"), object: nil)

func relodeTreeView(_ notification: Notification) {
  self.treeViewDataSource = (dataHandler?.refreshNodes())!
  DispatchQueue.main.async {
    self.famityTreeTableView.reloadData()
    }
}
```

## Customisation

### Setting up `UITableViewCell` and `UITableView`
* Create your own `UITableViewCell` custom subclass for the TreeView node.

### Setting up custom data model
* Just replace `Relations` and `RelationshipDetails` object with your own with proper changes and requirments.

## Up Next
* Dynamic addition and deletion of tree node.
* Dyanmic Data Container
* Dynamic View Holder

## Contributing

Contributions are welcome. Please just open an Issue on GitHub to discuss a point or request a feature or send a Pull Request with your suggestion. If there's a related discussion on the Swift Evolution mailing list, please also post the thread name with a link.

Please also try to follow the same syntax and semantic in your **commit messages** (see rationale [here](http://chris.beams.io/posts/git-commit/)).

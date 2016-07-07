//
//  TableViewDataDisplayer.swift
//  Architecture
//
//  Created by Ivan Shevelev on 07/07/16.
//  Copyright © 2016 Sibers. All rights reserved.
//

import UIKit

class TableViewDataDisplayer: CollectionDataDisplayer {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    func setupAutoCalculatingHeightForRow(withEstimatedRowHeight estimatedRowHeight: CGFloat) {
        self.tableView.estimatedRowHeight = 150
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func reloadData() {
        super.reloadData()
        
    }
    
}

extension TableViewDataDisplayer: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var result = 0
        
        if let dataSource = self.dataSource {
            result = dataSource.numberOfSectionsInCollectionDataDisplayer(self)
        }
        
        return result
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource!.collectionDataDisplayer(self, numberOfRowsInSection: section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        fatalError("method must be overriden")
        
    }
    
}

extension TableViewDataDisplayer: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.delegate?.collectionDataDisplayer(self, cellTappedAtIndexPath: indexPath)
    }
    
}

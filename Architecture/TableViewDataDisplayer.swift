//
//  TableViewDataDisplayer.swift
//  Architecture
//
//  Created by Ivan Shevelev on 07/07/16.
//  Copyright © 2016 Ivan Shevelev. All rights reserved.
//

import UIKit

class TableViewDataDisplayer: CollectionDataDisplayer {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.reloadData()  
        }
    }
    
    
    func setupAutoCalculatingHeightForRow(withEstimatedRowHeight estimatedRowHeight: CGFloat) {
        self.tableView.estimatedRowHeight = estimatedRowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func reloadData() {
        super.reloadData()
        self.tableView.reloadData()
    }
    
}

extension TableViewDataDisplayer: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var result = 0
        
        if let dataSource = self.dataSource {
            result = dataSource.numberOfSectionsInCollectionDataDisplayer(self)
        }
        
        return result
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var result = 0

        if let dataSource = self.dataSource {
            result = dataSource.collectionDataDisplayer(self, numberOfRowsInSection: section)
        }

        return result
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        fatalError("method must be overridden")
        
    }
    
}

extension TableViewDataDisplayer: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.collectionDataDisplayer(self, cellTappedAtIndexPath: indexPath)
    }
    
}

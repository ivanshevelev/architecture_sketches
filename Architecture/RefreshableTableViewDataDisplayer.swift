//
//  RefreshableTableViewDataDisplayer.swift
//  Architecture
//
//  Created by Ivan Shevelev on 07/07/16.
//  Copyright © 2016 Sibers. All rights reserved.
//

import UIKit

class RefreshableTableViewDataDisplayer: TableViewDataDisplayer {
    
    @IBOutlet override weak var tableView: UITableView! {
        didSet {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self,
                                     action: #selector(RefreshableTableViewDataDisplayer.refreshData(_:)),
                                     forControlEvents: .ValueChanged)
            self.tableView!.addSubview(refreshControl)
            self.reloadData()
        }
    }
    
    
    func refreshData(refreshControl: UIRefreshControl? = nil) {
        self.dataSource?.collectionDataDisplayer(self) { (error) in
            refreshControl?.endRefreshing()
            self.reloadData()
            if error != nil {
                self.delegate?.collectionDataDisplayer(self, didUpdateWithError: error!)
            }
        }
    }
    
}

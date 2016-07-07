//
//  RefreshableTableViewDataDisplayer.swift
//  Architecture
//
//  Created by Ivan Shevelev on 07/07/16.
//  Copyright © 2016 Sibers. All rights reserved.
//

import UIKit

protocol RefreshableTableViewDataDisplayerDataSource: CollectionDataDisplayerDataSource {
    func collectionDataDisplayer(collectionDataDisplayer: CollectionDataDisplayer,
                                 didFetchFreshDataWithCompletion completion: ((error: NSError?) -> Void))
}

class RefreshableTableViewDataDisplayer: TableViewDataDisplayer {
    
    private var refreshableDataSource: RefreshableTableViewDataDisplayerDataSource? {
        return self.dataSource as? RefreshableTableViewDataDisplayerDataSource
    }
    
    func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(RefreshableTableViewDataDisplayer.refreshData(_:)),
                                 forControlEvents: .ValueChanged)
        self.tableView!.addSubview(refreshControl)
    }
    
    func refreshData(refreshControl: UIRefreshControl? = nil) {
        self.refreshableDataSource?.collectionDataDisplayer(self) { (error) in
            refreshControl?.endRefreshing()
            self.reloadData()
            if error != nil {
                self.delegate?.collectionDataDisplayer(self, didUpdateWithError: error!)
            }
        }
    }
    
}

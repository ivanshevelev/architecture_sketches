//
//  RefreshableTableViewDataDisplayer.swift
//  Architecture
//
//  Created by Ivan Shevelev on 07/07/16.
//  Copyright © 2016 Ivan Shevelev. All rights reserved.
//

import UIKit

protocol RefreshableTableViewDataDisplayerDataSource: CollectionDataDisplayerDataSource {
    func collectionDataDisplayer(_ collectionDataDisplayer: CollectionDataDisplayer,
                                 didFetchFreshDataWithCompletion completion: ((_ error: NSError?) -> Void))
}

class RefreshableTableViewDataDisplayer: TableViewDataDisplayer {
    
    var refreshableDataSource: RefreshableTableViewDataDisplayerDataSource? {
        return super.dataSource as? RefreshableTableViewDataDisplayerDataSource
    }
    
    func addRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(RefreshableTableViewDataDisplayer.refreshData(_:)),
                                 for: .valueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    func refreshData(_ refreshControl: UIRefreshControl? = nil) {
        self.refreshableDataSource?.collectionDataDisplayer(self) { (error) in
            refreshControl?.endRefreshing()
            self.reloadData()
            if error != nil {
                self.delegate?.collectionDataDisplayer(self, didUpdateWithError: error!)
            }
        }
    }
    
}

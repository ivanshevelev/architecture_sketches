//
//  DataDisplayer.swift
//  WHParser3
//
//  Created by Ivan Shevelev on 07/07/16.
//  Copyright © 2016 Sibers. All rights reserved.
//

import UIKit

protocol DataDisplayerDataSource: class {
    func numberOfSectionsInDataDisplayer(dataDisplayer: DataDisplayer) -> Int
    func dataDisplayer(dataDisplayer: DataDisplayer, numberOfRowsInSection section: Int) -> Int
    func fetchFreshData(completion completion: ((error: NSError?) -> Void))
}

protocol DataDisplayerDelegate: class {
    
    func dataDisplayer(dataDisplayer: DataDisplayer, cellTappedAtIndexPath indexPath: NSIndexPath)
    func dataDisplayer(dataDisplayer: DataDisplayer, didUpdateWithError error: NSError)
    
}


class DataDisplayer: NSObject {
    
    weak var delegate: DataDisplayerDelegate?
    weak var dataSource: DataDisplayerDataSource?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView?.estimatedRowHeight = 150
            self.tableView?.rowHeight = UITableViewAutomaticDimension
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self,
                                     action: #selector(DataDisplayer.refreshData(_:)),
                                     forControlEvents: .ValueChanged)
            self.tableView?.addSubview(refreshControl)
            self.reloadData()
        }
    }
    
    func refreshData(refreshControl: UIRefreshControl? = nil) {
        self.dataSource?.fetchFreshData(completion: { (error) in
            refreshControl?.endRefreshing()
            self.reloadData()
            if error != nil {
                self.delegate?.dataDisplayer(self, didUpdateWithError: error!)
            }
        })
    }
    
    func reloadData() -> Void {
        self.tableView?.reloadData()
    }
    
}

extension DataDisplayer: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.delegate?.dataDisplayer(self, cellTappedAtIndexPath: indexPath)
    }
    
}

extension DataDisplayer: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var result = 0
        
        if let dataSource = self.dataSource {
            result = dataSource.numberOfSectionsInDataDisplayer(self)
        }
        
        return result
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource!.dataDisplayer(self, numberOfRowsInSection: section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        fatalError("method must be overriden")
        
    }
    
}

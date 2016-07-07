//
//  FullFetchableDataDisplayer.swift
//  Architecture
//
//  Created by Ivan Shevelev on 08/07/16.
//  Copyright © 2016 Sibers. All rights reserved.
//

import UIKit

protocol FullFetchableDataDisplayerDataSource: RefreshableTableViewDataDisplayerDataSource {
    
    func collectionDataDisplayer(collectionDataDisplayer: CollectionDataDisplayer,
                                 didFetchNextDataWithCompletion completion: ((error: NSError?) -> Void))
    
}

class FullFetchableDataDisplayer: RefreshableTableViewDataDisplayer {
    
    var fullFetchableDataSource: FullFetchableDataDisplayerDataSource? {
        return super.dataSource as? FullFetchableDataDisplayerDataSource
    }
    
    var cellCountBeforeFetch = 5
    
    private var download = false
    
    func fetchNextIfNeeded(byIndexPath indexPath: NSIndexPath) {
        let cellIndex = indexPath.row
        let maxIndexAtSection = self.dataSource!.collectionDataDisplayer(self, numberOfRowsInSection: indexPath.section)
        
        let differense = maxIndexAtSection - cellIndex
        
        if differense <= self.cellCountBeforeFetch && !self.download {
            self.download = true
            self.fullFetchableDataSource?.collectionDataDisplayer(self) { (error) in
                self.download = false
                self.reloadData()
                if error != nil {
                    self.delegate?.collectionDataDisplayer(self, didUpdateWithError: error!)
                }
            }
        }
    }
    
}

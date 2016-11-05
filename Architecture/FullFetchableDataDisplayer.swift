//
//  FullFetchableDataDisplayer.swift
//  Architecture
//
//  Created by Ivan Shevelev on 08/07/16.
//  Copyright © 2016 Ivan Shevelev. All rights reserved.
//

import UIKit

protocol FullFetchableDataDisplayerDataSource: RefreshableTableViewDataDisplayerDataSource {
    
    func collectionDataDisplayer(_ collectionDataDisplayer: CollectionDataDisplayer,
                                 didFetchNextDataWithCompletion completion: ((_ error: NSError?) -> Void))
    
    func hasDataForFetch(forCollectionDataDisplayer collectionDataDisplayer: CollectionDataDisplayer) -> Bool
    
}

class FullFetchableDataDisplayer: RefreshableTableViewDataDisplayer {
    
    var fullFetchableDataSource: FullFetchableDataDisplayerDataSource? {
        return super.dataSource as? FullFetchableDataDisplayerDataSource
    }
    
    var cellCountBeforeFetch = 5
    
    fileprivate var downloading = false
    
    func fetchNextIfNeeded(byIndexPath indexPath: IndexPath) {
        
        if let hasData = self.fullFetchableDataSource?.hasDataForFetch(forCollectionDataDisplayer: self), hasData == true {
            guard let dataSource = self.dataSource else { return }

            let cellIndex = indexPath.row
            let maxIndexAtSection = dataSource.collectionDataDisplayer(self, numberOfRowsInSection: indexPath.section)
            
            let difference = maxIndexAtSection - cellIndex
            
            if difference <= self.cellCountBeforeFetch && !self.downloading {
                self.downloading = true

                self.fullFetchableDataSource?.collectionDataDisplayer(self) {
                    (error) in
                    
                    self.downloading = false
                    self.reloadData()

                    if let error = error {
                        self.delegate?.collectionDataDisplayer(self, didUpdateWithError: error)
                    }
                }

            }
        }
    }
    
}

//
//  DownFetchableDataDisplayer.swift
//  WHParser3
//
//  Created by Ivan Shevelev on 07/07/16.
//  Copyright © 2016 Sibers. All rights reserved.
//

import UIKit

protocol DownFetchableDataDisplayerDataSource: DataDisplayerDataSource {
    func fetchNextPageData(completion completion: ((error: NSError?) -> Void))
}

class DownFetchableDataDisplayer: DataDisplayer {
    
    private var downFetchableDataSource: DownFetchableDataDisplayerDataSource? {
        return self.dataSource as? DownFetchableDataDisplayerDataSource
    }
    
    private var download = false
    
    func fetchNextIfNeeded(byIndexPath indexPath: NSIndexPath) {
        let cellIndex = indexPath.row
        let maxIndexAtSection = self.dataSource!.dataDisplayer(self, numberOfRowsInSection: indexPath.section)
        
        let differense = maxIndexAtSection - cellIndex
        
        if differense <= 5 && !self.download {
            self.download = true
            self.downFetchableDataSource?.fetchNextPageData(completion: { (error) in
                self.download = false
                self.reloadData()
                if error != nil {
                    self.delegate?.dataDisplayer(self, didUpdateWithError: error!)
                }
            })
        }
    }
    
}

//
//  CollectionDataDisplayer.swift
//  Architecture
//
//  Created by Ivan Shevelev on 07/07/16.
//  Copyright © 2016 Sibers. All rights reserved.
//

import UIKit

protocol CollectionDataDisplayerDataSource: class {
    
    func numberOfSectionsInCollectionDataDisplayer(collectionDataDisplayer: CollectionDataDisplayer) -> Int
    
    func collectionDataDisplayer(collectionDataDisplayer: CollectionDataDisplayer,
                                 numberOfRowsInSection section: Int) -> Int
    
    func collectionDataDisplayer(collectionDataDisplayer: CollectionDataDisplayer,
                                 didFetchFreshDataWithCompletion completion: ((error: NSError?) -> Void))
}

protocol CollectionDataDisplayerDelegate: class {
    
    func collectionDataDisplayer(collectionDataDisplayer: CollectionDataDisplayer,
                                 cellTappedAtIndexPath indexPath: NSIndexPath)
    
    func collectionDataDisplayer(collectionDataDisplayer: CollectionDataDisplayer,
                                 didUpdateWithError error: NSError)
    
}


class CollectionDataDisplayer: NSObject {
    
    weak var delegate: CollectionDataDisplayerDelegate?
    weak var dataSource: CollectionDataDisplayerDataSource?
    
    func reloadData() {
        
    }
    
}

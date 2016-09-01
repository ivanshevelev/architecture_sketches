//
//  CollectionDataDisplayer.swift
//  Architecture
//
//  Created by Ivan Shevelev on 07/07/16.
//  Copyright © 2016 Ivan Shevelev. All rights reserved.
//

import UIKit

protocol CollectionDataDisplayerDataSource: class {
    
    func numberOfSectionsInCollectionDataDisplayer(collectionDataDisplayer: CollectionDataDisplayer) -> Int
    
    func collectionDataDisplayer(collectionDataDisplayer: CollectionDataDisplayer,
                                 numberOfRowsInSection section: Int) -> Int
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

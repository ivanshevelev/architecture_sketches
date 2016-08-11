//
//  CollectionViewDataDisplayer.swift
//  Architecture
//
//  Created by Ivan Shevelev on 14/07/16.
//  Copyright © 2016 Sibers. All rights reserved.
//

import UIKit

class CollectionViewDataDisplayer: CollectionDataDisplayer {

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            self.reloadData()
        }
    }
    
    override func reloadData() {
        super.reloadData()
        self.collectionView.reloadData()
    }
    
}

extension CollectionViewDataDisplayer: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        var result = 0
        
        if let dataSource = self.dataSource {
            result = dataSource.numberOfSectionsInCollectionDataDisplayer(self)
        }
        
        return result
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource!.collectionDataDisplayer(self, numberOfRowsInSection: section)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        fatalError("collectionView:cellForItemAtIndexPath must be overridden")
    }
    
}

extension CollectionViewDataDisplayer: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        self.collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        
        self.delegate?.collectionDataDisplayer(self, cellTappedAtIndexPath: indexPath)
        
    }
    
}

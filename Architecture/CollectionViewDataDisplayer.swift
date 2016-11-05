//
//  CollectionViewDataDisplayer.swift
//  Architecture
//
//  Created by Ivan Shevelev on 14/07/16.
//  Copyright © 2016 Ivan Shevelev. All rights reserved.
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var result = 0
        
        if let dataSource = self.dataSource {
            result = dataSource.numberOfSectionsInCollectionDataDisplayer(self)
        }
        
        return result
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource!.collectionDataDisplayer(self, numberOfRowsInSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("collectionView:cellForItemAtIndexPath must be overridden")
    }
    
}

extension CollectionViewDataDisplayer: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.collectionView.deselectItem(at: indexPath, animated: true)
        
        self.delegate?.collectionDataDisplayer(self, cellTappedAtIndexPath: indexPath)
        
    }
    
}

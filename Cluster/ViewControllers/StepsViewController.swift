//
//  StepsViewController.swift
//  Cluster
//
//  Created by Aditya Emani on 3/11/18.
//  Copyright © 2018 Aditya Emani. All rights reserved.
//

import UIKit
import VegaScrollFlowLayout

// MARK: - Configurable constants
private let itemHeight: CGFloat = 200
private let lineSpacing: CGFloat = 20
private let xInset: CGFloat = 20
private let topInset: CGFloat = 10

class StepsViewController: UIViewController {
    
    fileprivate let cellId = "StepCell"
    @IBOutlet private weak var collectionView: UICollectionView!
    fileprivate var steps:[Step] = [];

    override func viewDidLoad() {
        super.viewDidLoad()
        steps = StepsHelper.generateSteps();
        print(steps);
        let nib = UINib(nibName: cellId, bundle: nil)
        collectionView.register( nib, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset.bottom = itemHeight
        configureCollectionViewLayout()
        setUpNavBar()
    }
    
    private func setUpNavBar() {
        navigationItem.title = "Steps"
        navigationController?.view.backgroundColor = UIColor.white
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    private func configureCollectionViewLayout() {
        let layout = VegaScrollFlowLayout()
        collectionView.collectionViewLayout = layout
        
        layout.minimumLineSpacing = lineSpacing
        layout.sectionInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
        let itemWidth = UIScreen.main.bounds.width - 2 * xInset
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension StepsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StepCell
        let share = steps[indexPath.row]
        cell.configureWith(share)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return steps.count
    }
}

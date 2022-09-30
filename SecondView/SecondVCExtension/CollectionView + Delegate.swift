//
//  CollectionView + Delegate.swift
//  MiracleMorningProject
//
//  Created by 이동기 on 2022/09/25.
//

import UIKit

extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return scheduleCountDic.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let space: CGFloat = 8
        let width = UIScreen.main.bounds.width - (space * 7)
        
        // 딕셔너리 value 크기에 따라 정렬
        let sortedScheduleCountDic = scheduleCountDic.sorted { (first, second) in
            return first.value > second.value
        }
    
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecondCollectionViewCell.reuseIdentifier, for: indexPath) as? SecondCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.scheduleLabel.text = sortedScheduleCountDic[indexPath.item].key
        cell.numberOfScheduleLabel.text = "\(sortedScheduleCountDic[indexPath.item].value)"
        
        cell.layer.cornerRadius = width / 6 / 2
        cell.backgroundColor = .collectionViewColor
        
        return cell
    }
}

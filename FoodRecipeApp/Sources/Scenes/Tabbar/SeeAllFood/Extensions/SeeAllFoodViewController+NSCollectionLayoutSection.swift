//
//  SeeAllFoodViewController+NSCollectionLayoutSection.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 17/10/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//
import UIKit

extension SeeAllFoodViewController {
    
    // MARK: - Food All Grid
    
    func createNSCollectionLayoutSectionAllFoodGrid() -> NSCollectionLayoutSection {
        let sectionPadding: CGFloat = 24
        let shadowPadding: CGFloat = 8
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5), // two item per row
                heightDimension: .absolute(200)  // vertical control the height by item instead
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        /// Group = cell container

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(300) // vertical align need the group to extend as need
            ),
            subitems: [item]
        )
        
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: sectionPadding - shadowPadding,
            bottom: 0,
            trailing: sectionPadding - shadowPadding
        )
        
        /// Section = Section container: header, footer can be shown

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none // vertical align use main scroll
        
        section.interGroupSpacing = 0 // vertical align full width will have multiple group in stead of item
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(62)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        header.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        header.pinToVisibleBounds = true
        
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    // MARK: - Food All Table
    
    func createNSCollectionLayoutSectionAllFoodTable() -> NSCollectionLayoutSection {
        let sectionPadding: CGFloat = 24
        let shadowPadding: CGFloat = 8
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1), // two item per row
                heightDimension: .fractionalHeight(1)  // vertical control the height by item instead
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        /// Group = cell container

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(180.0)
            ),
            subitems: [item]
        )
        
        group.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: sectionPadding - shadowPadding,
            bottom: 0,
            trailing: sectionPadding - shadowPadding
        )
        
        /// Section = Section container: header, footer can be shown

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none // vertical align use main scroll
        
        section.interGroupSpacing = 0 // vertical align full width will have multiple group in stead of item
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(62)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        header.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}

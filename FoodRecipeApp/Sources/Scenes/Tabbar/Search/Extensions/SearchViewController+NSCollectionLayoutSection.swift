//
//  SearchViewController+NSCollection.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 12/10/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

extension SearchViewController {
    
    // MARK: - Title
    
    func createNSCollectionLayoutSectionSearchTitle() -> NSCollectionLayoutSection {
        /// item = cell dimension
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        /// group = single collectionView dimension alike
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(64)
            ),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        return section
    }
    
    // MARK: - Search TextField
    
    func createNSCollectionLayoutSectionSearchTextField() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(41)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )

        let bottomPadding: CGFloat = 24
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(54 + bottomPadding)
            ),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        return section
    }
    
    // MARK: - Category
    
    func createNSCollectionLayoutSectionCategory() -> NSCollectionLayoutSection {
        let cellWidth: CGFloat = 130.0
        let padding: CGFloat = 12.0
        
        /// This is quite tricky by making the itemLayoutSize == groupLayoutSize will solve
        /// problem of of dynamic width (solved).
        ///
        /// As set width dimension to .fractional(1) may look more properly way to do however will
        /// cause layout to be buggy.
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .estimated(cellWidth),
                heightDimension: .absolute(41)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .estimated(cellWidth),
                heightDimension: .absolute(41)
            ),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 24,
            bottom: 0,
            trailing: 24
        )
        
        section.interGroupSpacing = padding
        
        return section
    }
    
    // MARK: - Search Results Grid
    
    func createNSCollectionLayoutSectionSearchResultGrid() -> NSCollectionLayoutSection {
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
            heightDimension: .absolute(79)
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
    
    // MARK: - Search Results Table
    
    func createNSCollectionLayoutSectionSearchResultTable() -> NSCollectionLayoutSection {
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
            heightDimension: .absolute(79)
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
}

//
//  ProfileViewController+NSCollectionLayoutSection.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 15/10/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

extension ProfileViewController {
    
    // MARK: - Title
    
    func createNSCollectionLayoutSectionAccountTitle() -> NSCollectionLayoutSection {
        /// item = cell
        
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
        
        /// Group = cell container
        
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
    
    // MARK: - Account
    
    func createNSCollectionLayoutSectionAccount() -> NSCollectionLayoutSection {
        let sectionPadding: CGFloat = 24
        let shadowPadding: CGFloat = 8
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0) // vertical control the height by item instead
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
            
        )
        
        /// Group = cell container

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(96) // vertical align need the group to extend as need
            ),
            subitems: [item]
        )
        
        // Section = Section container: header, footer can be shown
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none // vertical align use main scroll
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: sectionPadding - shadowPadding,
            bottom: 0,
            trailing: sectionPadding - shadowPadding
        )
        
        section.interGroupSpacing = 16 // vertical align full width will have multiple group in stead of item
        
        return section
    }
    
    // MARK: - Setting
    
    func createNSCollectionLayoutSectionSetting() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0) // vertical control the height by item instead
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
            
        )
        
        /// Group = cell container

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(50) // vertical align need the group to extend as need
            ),
            subitems: [item]
        )
        
        // Section = Section container: header, footer can be shown
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none // vertical align use main scroll
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        section.interGroupSpacing = 0 // vertical align full width will have multiple group in stead of item
        
        return section
    }
    
    // MARK: - Logout
    
    func createNSCollectionLayoutSectionLogout() -> NSCollectionLayoutSection {
        let sectionPadding: CGFloat = 24
        let shadowPadding: CGFloat = 8
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0) // vertical control the height by item instead
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
            
        )
        
        /// Group = cell container

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(100) // vertical align need the group to extend as need
            ),
            subitems: [item]
        )
        
        // Section = Section container: header, footer can be shown
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none // vertical align use main scroll
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        section.interGroupSpacing = 0 // vertical align full width will have multiple group in stead of item
        
        return section
    }
}

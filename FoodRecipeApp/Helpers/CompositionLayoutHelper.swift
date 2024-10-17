//
//  CompositionLayoutHelper.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 14/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

enum CompositionalGroupAlignment {
    case vertical
    case horizontal
}

struct CompositionLayoutHelper {
    static func createItem(
        width: NSCollectionLayoutDimension,
        height: NSCollectionLayoutDimension,
        spacing: CGFloat
    ) -> NSCollectionLayoutItem {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: width,
            heightDimension: height
        )
        let item = NSCollectionLayoutItem(
            layoutSize: layoutSize
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: spacing,
            leading: spacing,
            bottom: spacing,
            trailing: spacing
        )
        return item
    }
    
    static func createGroup(
        alignment: CompositionalGroupAlignment,
        width: NSCollectionLayoutDimension,
        height: NSCollectionLayoutDimension,
        items: [NSCollectionLayoutItem]
    ) -> NSCollectionLayoutGroup {
        switch alignment {
        case .vertical:
            return NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: width,
                    heightDimension: height
                ),
                subitems: items
            )
        case .horizontal:
            return NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: width,
                    heightDimension: height
                ),
                subitems: items
            )
        }
    }
    
    static func createGroup(
        alignment: CompositionalGroupAlignment,
        width: NSCollectionLayoutDimension,
        height: NSCollectionLayoutDimension,
        items: NSCollectionLayoutItem,
        count: Int
    ) -> NSCollectionLayoutGroup {
        switch alignment {
        case .vertical:
            return NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: width,
                    heightDimension: height
                ),
                repeatingSubitem: items,
                count: count
            )
        case .horizontal:
            return NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: width,
                    heightDimension: height
                ),
                repeatingSubitem: items,
                count: count
            )
        }
    }
}

//
//  HomeViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 7/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    
}

class HomeViewController: UIViewController, HomeDisplayLogic {
    
    enum Sections: Int, CaseIterable {
        case name = 0
        case featured = 1
        case category = 2
        case popularRecipe = 3
    }
    
    // MARK: - Properties
    
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    private var categories: [HomeModels.Category] = [
        HomeModels.Category(name: "Breakfast", isSelected: true),
        HomeModels.Category(name: "Lunch", isSelected: false),
        HomeModels.Category(name: "Dinner", isSelected: false),
        HomeModels.Category(name: "Snack", isSelected: false),
    ]
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        collectionView.collectionViewLayout = createLayout()
    }
    
    // MARK: - IBAction
    
    
    
    // MARK: - General Function
    
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self else { return nil }
            
            switch Sections(rawValue: sectionIndex) {
            case .name:
                return createNSCollectionLayoutSectionName()
            case .featured:
                return createNSCollectionLayoutSectionFeatured()
            case .category:
                return createNSCollectionLayoutSectionCategory()
            case .popularRecipe:
                return createNSCollectionLayoutSectionPopularRecipe()
            case .none:
                return nil
            }
        }
    }
    
    private func setupCollectionView() {
        /// Name
        collectionView.register(
            UINib(nibName: "NameHeaderViewCell", bundle: .main),
            forCellWithReuseIdentifier: "NameHeaderViewCell"
        )
        
        /// Featured
        collectionView.register(
            UINib(nibName: "FeaturedHeaderCollectionViewCell", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "FeaturedHeaderCollectionViewCell"
        )
        collectionView.register(
            UINib(nibName: "FeaturedCardCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "FeaturedCardCollectionViewCell"
        )
        
        /// Category
        collectionView.register(
            UINib(nibName: "CategoryHeaderCollectionViewCell", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "CategoryHeaderCollectionViewCell"
        )
        collectionView.register(
            UINib(nibName: "CategoryCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "CategoryCollectionViewCell"
        )
        
        /// Popular Recipe
        collectionView.register(
            UINib(nibName: "PopularRecipeHeaderCollectionViewCell", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "PopularRecipeHeaderCollectionViewCell"
        )
        collectionView.register(
            UINib(nibName: "PopularRecipeCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "PopularRecipeCollectionViewCell"
        )
    }
    
    // MARK: - Display
    
    
    // MARK: - Navigation
    
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Sections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == Sections.name.rawValue {
            return 1
        }
        
        if section == Sections.featured.rawValue {
            return 2
        }
        
        if section == Sections.category.rawValue {
            return categories.count
        }
        
        if section == Sections.popularRecipe.rawValue {
            return 6
        }
        
        return 0
    }
    
    /// Set up cell
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == Sections.name.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NameHeaderViewCell", for: indexPath) as! NameHeaderViewCell
            return cell
        }
        
        if indexPath.section == Sections.featured.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedCardCollectionViewCell", for: indexPath) as! FeaturedCardCollectionViewCell
            return cell
        }
        
        if indexPath.section == Sections.category.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            
            cell.setUp(
                name: categories[indexPath.row].name,
                isSelectedCategory: categories[indexPath.row].isSelected
            )
            
            let category = categories[indexPath.row]
            let name: String = category.name
            let isSelected: Bool = category.isSelected
            
            cell.setUp(name: name, isSelectedCategory: isSelected)
            
            cell.categoryClosure = { [weak self] name in
                guard let self else { return }
                
                categories.enumerated().forEach { (index, category) in
                    self.categories[index].isSelected = (category.name == name) ? true : false
                }
                
                collectionView.reloadSections([Sections.category.rawValue])
            }
            
            return cell
        }
        
        if indexPath.section == Sections.popularRecipe.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularRecipeCollectionViewCell", for: indexPath) as! PopularRecipeCollectionViewCell
            
            cell.foodClosure = { [weak self] in
                guard let self else { return }
                    
                router?.routeToFoodDetail()
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    /// Set up header
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader &&
            indexPath.section == Sections.featured.rawValue {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "FeaturedHeaderCollectionViewCell",
                for: indexPath
            ) as! FeaturedHeaderCollectionViewCell
            
            return header
        }
        
        if kind == UICollectionView.elementKindSectionHeader &&
            indexPath.section == Sections.category.rawValue {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "CategoryHeaderCollectionViewCell",
                for: indexPath
            ) as! CategoryHeaderCollectionViewCell
            
            return header
        }
        
        if kind == UICollectionView.elementKindSectionHeader &&
            indexPath.section == Sections.popularRecipe.rawValue {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "PopularRecipeHeaderCollectionViewCell",
                for: indexPath
            ) as! PopularRecipeHeaderCollectionViewCell
            
            return header
        }
        
        return UICollectionReusableView()
    }
}

// MARK: - Set Up CollectionView

extension HomeViewController {
    // Name
    private func createNSCollectionLayoutSectionName() -> NSCollectionLayoutSection {
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
                heightDimension: .absolute(52)
            ),
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        return section
    }
    
    // Featured
    private func createNSCollectionLayoutSectionFeatured() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(264),
                heightDimension: .fractionalHeight(1.0)
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
                widthDimension: .absolute(296),
                heightDimension: .absolute(172)
            ),
            subitems: [item]
        )
        
        group.interItemSpacing = .fixed(16)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 24,
            bottom: 0,
            trailing: 0
        )
        
        /// [Header ] 2. Add header to the section
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(62)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    // Category
    private func createNSCollectionLayoutSectionCategory() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .estimated(50),
                heightDimension: .fractionalHeight(1.0)
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
                widthDimension: .absolute(
                    self.view.frame.width + (CGFloat(categories.count - 1) * 12.0 + 24)
                ),
                heightDimension: .absolute(41)
            ),
            subitems: [item]
        )
        
        group.interItemSpacing = .fixed(12)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 24,
            bottom: 0,
            trailing: 0
        )
        
        /// [Header ] 2. Add header to the section
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(62)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    // Popular recipe
    private func createNSCollectionLayoutSectionPopularRecipe() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(200),
                heightDimension: .absolute(240)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )

        let height: Int = 200
        let popularRecipeCount: Int = 6
        let popularRecipeSpacing: Int = popularRecipeCount - 1
        let spacing: Int = 16
        
        let groupWidth = CGFloat(height * popularRecipeCount + spacing * popularRecipeSpacing) // 6 items of 200pt width + 5 spacings of 16pt each
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(groupWidth),
                heightDimension: .absolute(240)
            ),
            subitems: [item]
        )
        
        group.interItemSpacing = .fixed(16)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 24,
            bottom: 0,
            trailing: 24
        )
        
        /// [Header ] 2. Add header to the section
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(62)
        )
        
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}

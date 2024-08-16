//
//  SearchViewController.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 9/8/2567 BE.
//  Copyright (c) 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

protocol SearchDisplayLogic: AnyObject {
    func displaySomething(viewModel: SearchModels.Something.ViewModel)
}

class SearchViewController: UIViewController, SearchDisplayLogic {
    
    enum Sections: Int, CaseIterable {
        case searchTitle = 0
        case searchTextField = 1
        case category = 2
        case popularRecipe = 3
        case editorChoice = 4
    }

    
    // MARK: - Properties
    
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    
    private var categories: [HomeModels.Category] = [
        HomeModels.Category(name: "Breakfast", isSelected: true),
        HomeModels.Category(name: "Lunch", isSelected: false),
        HomeModels.Category(name: "Dinner", isSelected: false),
        HomeModels.Category(name: "Snack", isSelected: false),
    ]
    
    // MARK: - IBOutlet
    
//    @IBOutlet weak private var categoryCollectionView: UICollectionView!
//    @IBOutlet weak private var searchTextFieldView: UIView! {
//        didSet {
//            searchTextFieldView.layer.borderColor = UIColor.D_2_D_4_D_8.cgColor
//            searchTextFieldView.layer.borderWidth = 1.0
//        }
//    }
    
//    @IBOutlet weak private var popularRecipeViewAllButtonView: UILabel!
//    @IBOutlet weak private var editorChoiceViewAllButtonView: UILabel!
//
//    @IBOutlet weak private var searchPopularRecipeCollectionView: UICollectionView!
//    @IBOutlet weak private var editorChoiceCollectionView: UICollectionView!
    
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
        doSomething()
        
        setupCollectionView()
        collectionView.collectionViewLayout = createLayout()
    }
    
    // MARK: - IBAction
    
    
    
    // MARK: - General Function
    
    private func setup() {
        let viewController = self
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func doSomething() {
        let request = SearchModels.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self else { return nil }
            
            switch Sections(rawValue: sectionIndex) {
            case .searchTitle:
                return createNSCollectionLayoutSectionSearchTitle()
            case .searchTextField:
                return createNSCollectionLayoutSectionSearchTextField()
            case .category:
                return createNSCollectionLayoutSectionCategory()
            case .popularRecipe:
                return createNSCollectionLayoutSectionPopularRecipe()
            case .editorChoice:
                return createNSCollectionLayoutSectionEditorChoice()
            case .none:
                return nil
            }
        }
    }
    
    private func setupCollectionView() {
        /// Search Title
        collectionView.register(
            UINib(nibName: "SearchTitleCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "SearchTitleCollectionViewCell"
        )
        
        /// Search TextField
        collectionView.register(
            UINib(nibName: "SearchTextFieldCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "SearchTextFieldCollectionViewCell"
        )
        
        /// Category
        collectionView.register(
            UINib(nibName: "CategoryCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "CategoryCollectionViewCell"
        )
        
        /// Popular Recipe
        collectionView.register(
            UINib(nibName: "SearchPopularRecipeHeaderCollectionViewCell", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SearchPopularRecipeHeaderCollectionViewCell"
        )
        collectionView.register(
            UINib(nibName: "SearchPopularRecipeCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "SearchPopularRecipeCollectionViewCell"
        )
        
        /// Editor Choice
        collectionView.register(
            UINib(nibName: "EditorChoiceHeaderCollectionViewCell", bundle: nil),
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "EditorChoiceHeaderCollectionViewCell"
        )
        collectionView.register(
            UINib(nibName: "EditorChoiceCollectionViewCell", bundle: .main),
            forCellWithReuseIdentifier: "EditorChoiceCollectionViewCell"
        )
    }
    
    // MARK: - Display
    
    func displaySomething(viewModel: SearchModels.Something.ViewModel) {
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Sections.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == Sections.searchTitle.rawValue {
            return 1
        }
        
        if section == Sections.searchTextField.rawValue {
            return 1
        }
        
        if section == Sections.category.rawValue {
            return categories.count
        }
        
        if section == Sections.popularRecipe.rawValue {
            return 6
        }
        
        if section == Sections.editorChoice.rawValue {
            return 6
        }
        
        return 0
    }
    
    /// Set up cell
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == Sections.searchTitle.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchTitleCollectionViewCell", for: indexPath) as! SearchTitleCollectionViewCell
            return cell
        }
        
        if indexPath.section == Sections.searchTextField.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchTextFieldCollectionViewCell", for: indexPath) as! SearchTextFieldCollectionViewCell
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
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchPopularRecipeCollectionViewCell", for: indexPath) as! SearchPopularRecipeCollectionViewCell
            
//            cell.foodClosure = { [weak self] in
//                guard let self else { return }
//                    
//                router?.routeToFoodDetail()
//            }
            
            return cell
        }
        
        if indexPath.section == Sections.editorChoice.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditorChoiceCollectionViewCell", for: indexPath) as! EditorChoiceCollectionViewCell
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
            indexPath.section == Sections.popularRecipe.rawValue {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "SearchPopularRecipeHeaderCollectionViewCell",
                for: indexPath
            ) as! SearchPopularRecipeHeaderCollectionViewCell
            
            return header
        }
        
        if kind == UICollectionView.elementKindSectionHeader &&
            indexPath.section == Sections.editorChoice.rawValue {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "EditorChoiceHeaderCollectionViewCell",
                for: indexPath
            ) as! EditorChoiceHeaderCollectionViewCell
            
            return header
        }
        
        return UICollectionReusableView()
    }
}

// MARK: - NSCollectionLayoutSection Helper

extension SearchViewController {
    // Search Title
    private func createNSCollectionLayoutSectionSearchTitle() -> NSCollectionLayoutSection {
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
    
    // Search TextField
    private func createNSCollectionLayoutSectionSearchTextField() -> NSCollectionLayoutSection {
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
    
    // Category
    func createNSCollectionLayoutSectionCategory() -> NSCollectionLayoutSection {
        let cellWidth: CGFloat = 115.0
        let padding: CGFloat = 12.0
        
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(cellWidth),
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
                widthDimension: .absolute(cellWidth + padding),
                heightDimension: .absolute(41)
            ),
            subitems: [item]
        )
        
        group.interItemSpacing = .fixed(12)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 24,
            bottom: 0,
            trailing: 24
        )
        
        return section
    }
    
    // Popular recipe
    private func createNSCollectionLayoutSectionPopularRecipe() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(100),
                heightDimension: .fractionalHeight(1)
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )
        
        /// As .fractional width will show defect, need to manually calculate
        
        let height: Int = 100
        let itemsCount: Int = 6
        let spacing: Int = 16
        let itemsSpacing: Int = itemsCount - 1
        
        let groupWidth = CGFloat(height * itemsCount + spacing * itemsSpacing)

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(groupWidth),
                heightDimension: .absolute(136)
            ),
            subitems: [item]
        )
        
        group.interItemSpacing = .fixed(16)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 24,
            bottom: 0,
            trailing: 24
        )
        
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
    
    // Editor Choice
    private func createNSCollectionLayoutSectionEditorChoice() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0), // fractional 1.0 as one item per row
                heightDimension: .absolute(100) // vertical control the height by item instead
            )
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        )

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(300) // vertical align need the group to extend as need
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none // vertical align use main scroll
        
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 24,
            bottom: 0,
            trailing: 24
        )
        
        section.interGroupSpacing = 16 // vertical align full width will have multiple group in stead of item
        
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

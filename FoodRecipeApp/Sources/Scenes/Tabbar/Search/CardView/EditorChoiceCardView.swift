//
//  EditorChoiceCardView.swift
//  FoodRecipeApp
//
//  Created by Chayakan Tangsanga on 13/8/2567 BE.
//  Copyright © 2567 BE BeamtanDev Co. All rights reserved.
//

import UIKit

@IBDesignable
class EditorChoiceCardView: UIView {
    
    private var nextToClosure: (() -> ())?
    
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nextToView: UIView!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        let bundle = Bundle(for: EditorChoiceCardView.self)
        bundle.loadNibNamed("EditorChoiceCardView", owner: self)
        
        view.frame = bounds
        view.translatesAutoresizingMaskIntoConstraints = true
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    func configureView(
        imageView: UIImage,
        userImageView: UIImage,
        title: String,
        name: String,
        nextToClosure: @escaping (() -> ())
    ) {
        self.imageView.image = imageView
        self.userImageView.image = userImageView
        self.titleLabel.text = title
        self.nameLabel.text = name
        self.nextToClosure = nextToClosure
    }
}

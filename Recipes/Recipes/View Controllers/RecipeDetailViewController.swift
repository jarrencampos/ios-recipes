//
//  RecipeDetailViewController.swift
//  Recipes
//
//  Created by Jarren Campos on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var detailTextView: UITextView!
    
    var recipe: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
        // Do any additional setup after loading the view.
    }
    
    
    func updateViews() {
        if isViewLoaded {
            if let recipe = recipe {
                detailLabel.text = recipe.name
                detailTextView.text = recipe.instructions
            }
        }
    }
}

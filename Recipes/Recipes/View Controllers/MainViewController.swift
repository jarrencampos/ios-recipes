//
//  MainViewController.swift
//  Recipes
//
//  Created by Jarren Campos on 3/11/20.
//  Copyright © 2020 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var searchBarTextField: UITextField!
    var recipesTableViewController: RecipesTableViewController?
    
    let networkClient = RecipesNetworkClient()
    
    var allRecipes: [Recipe] = [] {
        didSet {
            filterRecipes()
        }
    }
    
    var filteredRecipes: [Recipe] = [] {
        didSet {
            recipesTableViewController?.recipes = filteredRecipes
            recipesTableViewController?.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        networkClient.fetchRecipes { (recipes, error) in
            if let error = error {
                NSLog("Error loading data \(error)")
                return
            }
            self.allRecipes = recipes ?? []
        }
    }
    func filterRecipes() {
        DispatchQueue.main.async {
            if let text = self.searchBarTextField.text, text != "" {
                self.filteredRecipes = self.allRecipes.filter( {(recipe) in recipe.name.contains(text) || recipe.instructions.contains(text)} )
            } else {
                self.filteredRecipes = self.allRecipes
            }
        }
    }
    // MARK: - IBActions
    @IBAction func searchBarTextFieldAction(_ sender: Any) {
        self.searchBarTextField.resignFirstResponder()
        filterRecipes()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipeListSegue" {
            guard let recipeTableVC = segue.destination as? RecipesTableViewController else { return }
            recipesTableViewController = recipeTableVC
        }
    }
    
}


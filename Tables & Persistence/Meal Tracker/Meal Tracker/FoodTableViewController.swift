//
//  FoodTableViewController.swift
//  Meal Tracker
//
//  Created by Sterling Jenkins on 10/18/22.
//

import UIKit

class FoodTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    var meals: [Meal] {
        var breakfast = Meal(name: "Breakfast", food: [oatmeal])
        var lunch = Meal(name: "Lunch", food: [pbh])
        var dinner = Meal(name: "Dinner", food: [spinachSalad])
        return [breakfast, lunch, dinner]
    }
    
    let oatmeal = Food(name: "Oatmeal", description: "Heated quick oats mixed with milk; with additonal nuts, fruit, spices, and sweeteners added before or after heateing as desired.")
    let pbh = Food(name: "PBH", description: "A sandwich made by spreading peanutbutter and honey between two slices of bread")
    let spinachSalad = Food(name: "Spinach Salad", description: "A salad made with a base of fresh baby spinach, and topped with other veggies, fruits, nuts, dressings, and so on as desired")
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals[section].food.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Food", for: indexPath)
        
        var meal = meals[indexPath.section]
        var food = meal.food[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        content.text = food.name
        content.secondaryText = food.description
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let meal = meals[section].name
        
        return meal
    }
}

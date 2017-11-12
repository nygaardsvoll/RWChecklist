//
//  ChecklistViewController.swift
//  RWChecklist
//
//  Created by Erik Nygårdsvoll on 12/11/2017.
//  Copyright © 2017 Nymain. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {
  
  func addItemViewControllerDidCancel(_ controller: AddItemViewControllerDelegate) {
    navigationController?.popViewController(animated: true)
  }
  
  func addItemViewController(_ controller: AddedItemViewController, didFinishAdding item: ChecklistItem) {
    navigationController?.popViewController(animated: true)
  }
  
  @IBAction func addItem(_ sender: UIBarButtonItem) {
    
    var titles = ["Walk the dog",
                  "Brush teeth",
                  "Learn iOS development",
                  "Socer practice",
                  "Eat ice cream",
                  "Complete RW Challenge",
                  "Do 20 push-ups",
                  "Do 20 squats"
    ]
    let randomNumber = arc4random_uniform(UInt32(titles.count))
    let title = titles[Int(randomNumber)]
    
    
    let newRowIndex = items.count
    let item = ChecklistItem()
    item.text = title
    item.checked = true
    
    items.append(item)
    
    let indexPath = IndexPath(row: newRowIndex, section: 0)
    let indexPaths = [indexPath]
    tableView.insertRows(at: indexPaths, with: .automatic)
  }
  
  var items: [ChecklistItem]
  
  required init?(coder aDecoder: NSCoder) {
    
    items = [ChecklistItem]()
    
    let row0Item = ChecklistItem(),
    row1Item = ChecklistItem(),
    row2Item = ChecklistItem(),
    row3Item = ChecklistItem(),
    row4Item = ChecklistItem(),
    row5Item = ChecklistItem(),
    row6Item = ChecklistItem(),
    row7Item = ChecklistItem()
    
    row0Item.text = "Walk the dog"
    row1Item.text = "Brush teeth"
    row2Item.text = "Learn iOS development"
    row3Item.text = "Socer practice"
    row4Item.text = "Eat ice cream"
    row5Item.text = "Complete RW Challenge"
    row6Item.text = "Do 20 push-ups"
    row7Item.text = "Do 20 squats"
    
    row0Item.checked = false
    row1Item.checked = false
    row3Item.checked = false
    row4Item.checked = false
    row5Item.checked = false
    row6Item.checked = false
    row7Item.checked = false
    
    items.append(row0Item)
    items.append(row1Item)
    items.append(row2Item)
    items.append(row3Item)
    items.append(row4Item)
    items.append(row5Item)
    items.append(row6Item)
    items.append(row7Item)
    
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    
    items.remove(at: indexPath.row)
    let indexPaths = [indexPath]
    tableView.deleteRows(at: indexPaths, with: .automatic)
    //    tableView.reloadData() // alternative method, without delete animation
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let cell = tableView.cellForRow(at: indexPath) {
      let item = items[indexPath.row]
      item.toggleChecked()
      
      configureCheckmark(for: cell, with: item)
    }
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
    let item = items[indexPath.row]
    
    configureText(for: cell, with: item)
    configureCheckmark(for: cell, with: item)
    
    return cell
  }
  
  func configureText(for cell: UITableViewCell, with item: ChecklistItem) {
    let lable = cell.viewWithTag(1000) as! UILabel
    lable.text = item.text
  }
  
  func configureCheckmark(for cell: UITableViewCell, with item: ChecklistItem) {
    if item.checked {
      cell.accessoryType = .checkmark
    } else {
      cell.accessoryType = .none
    }
  }
}


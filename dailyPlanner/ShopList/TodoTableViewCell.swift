//
//  TodoTableViewCell.swift
//  dailyPlanner
//
//  Created by 123 on 10.01.2024.
//


import UIKit

protocol TodoCellDelegate: AnyObject {
    func cellTapped(cell: TodoTableViewCell)
}

class TodoTableViewCell: UITableViewCell {
        @IBOutlet weak var toDoLabel: UILabel!
        @IBOutlet weak var toDoButton: UIButton!
    
    weak var delegate: TodoCellDelegate?
    
    @IBAction func toDoButtonTapped(_ sender: Any) {
        delegate?.cellTapped(cell: self)
    }
   

    func updateCell(with todo: Todo) {
        toDoLabel.text = todo.name
        toDoButton.setImage(UIImage(systemName: todo.isCompleted ? "checkmark.square" : "square"), for: .normal)
    }
}

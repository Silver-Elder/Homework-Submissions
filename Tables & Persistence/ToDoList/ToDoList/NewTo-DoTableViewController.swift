//
//  NewTo-DoTableViewController.swift
//  ToDoList
//
//  Created by Sterling Jenkins on 11/14/22.
//

import UIKit

class NewTo_DoTableViewController: UITableViewController {

    var toDo: ToDo?
    
//    init?(coder: NSCoder, toDo: ToDo?) {
//        self.toDo = toDo
//        super.init(coder: coder)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateDisplayLabel: UILabel!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var notesTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentDueDate: Date
        if let toDo = toDo {
            navigationItem.title = "To-Do"
            titleTextField.text = toDo.title
            isCompleteButton.isSelected = toDo.isComplete
            currentDueDate = toDo.dueDate
            notesTextField.text = toDo.notes
        } else {
            currentDueDate = Date().addingTimeInterval(24*60*60)
            // The added time interval is measured in seconds, so we adjust for the proper number of seconds by multiplying our seconds value by 60 (60 seconds in one minute), then by 60 again (60 minutes in 1 hour), and then by 24 (24 hours in one day)
        }
        
        dueDatePicker.date = currentDueDate
        updateSaveButton()
        updateDueDateLabel(date: dueDatePicker.date)
    }

    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    func updateSaveButton() {
        let shouldEndableSaveButton =  titleTextField.text?.isEmpty != true
        saveButton.isEnabled = shouldEndableSaveButton
    }
    
    @IBAction func titleTextFieldEditingChanged(_ sender: UITextField) {
        updateSaveButton()
    }
    
    @IBAction func titleTextFieldReturnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func notesTextFieldReturnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected.toggle()
    }
    
    func updateDueDateLabel(date: Date) {
        dueDateDisplayLabel.text = date.formatted(.dateTime.month(.defaultDigits).day().year(.twoDigits).hour().minute())
    }
    
    @IBAction func dueDatePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: sender.date)
    }
    
    //MARK: - TableView Controlls
    
    var isDatePickerHidden = true
    let dateDisplayLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesTextFieldIndexPath = IndexPath(row: 0, section: 2)
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath where isDatePickerHidden == true:
            return 0
        case notesTextFieldIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath:
            return 216
        case notesTextFieldIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == dateDisplayLabelIndexPath {
            isDatePickerHidden.toggle()
            updateDueDateLabel(date: dueDatePicker.date)
        } else {
            isDatePickerHidden = true
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePicker.date
        let notes = notesTextField.text
        
        if toDo != nil {
            toDo?.title = title
            toDo?.isComplete = isComplete
            toDo?.dueDate = dueDate
            toDo?.notes = notes
        }
        else {
            toDo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
            
        }
    }
}

// Resume @ p.296

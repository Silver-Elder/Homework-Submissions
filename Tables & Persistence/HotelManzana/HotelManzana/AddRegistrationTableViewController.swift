//
//  AddRegistrationTableViewController.swift
//  HotelManzana
//
//  Created by Sterling Jenkins on 10/26/22.
//

import UIKit

class AddRegistrationTableViewController: UITableViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var setCheckInDateLabel: UILabel!
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var setCheckOutDateLabel: UILabel!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    
    init?(coder: NSCoder, registration: Registration?) {
        self.registration = registration
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
        
        updateDateViews()
        updateNumberOfGuests()
        updateRoomType()
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    var registrationToEdit: Registration?
    
    var registration: Registration? {
        guard let roomType = roomType else { return nil }
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkOutDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWiFi = wifiSwitch.isOn
        
        return Registration(firstName: firstName, lastName: lastName, emailAddress: email, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfAdults: numberOfAdults, numberOfChildren: numberOfChildren, wifi: hasWiFi, roomType: roomType)
        
    }
    
    func updateDateViews() {
        checkOutDatePicker.minimumDate = Calendar.current.date(byAdding:
                .day, value: 1, to: checkInDatePicker.date) // This (byAdding:value:to:) method adds one (value: 1), day (byAdding: .day), to our checkInDatePicker.date (to: checkInDatePicker.date)
        
        setCheckInDateLabel.text = checkInDatePicker.date.formatted(date: .abbreviated, time: .omitted)
        
        setCheckOutDateLabel.text = checkOutDatePicker.date.formatted(date: .abbreviated, time: .omitted)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateViews()
    }
    
    // MARK: - Adjusting Date Picker Display
    
    let checkInDateCellIndexPath = IndexPath(row: 0, section: 1)
    let checkOutDateCellIndexPath = IndexPath(row: 2, section: 1)
    
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    var isCheckInDatePickerVisible: Bool = false {
        didSet {
            checkInDatePicker.isHidden = !isCheckInDatePickerVisible
        }
    }
    var isCheckOutDatePickerVisible: Bool = false {
        didSet {
            checkOutDatePicker.isHidden = !isCheckOutDatePickerVisible
        }
    }
    
    override func tableView(_ tableView: UITableView,
       heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath where
           isCheckInDatePickerVisible == false:
            return 0
        case checkOutDatePickerCellIndexPath where
           isCheckOutDatePickerVisible == false:
            return 0
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView,
       estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath:
            return 190
        case checkOutDatePickerCellIndexPath:
            return 190
        default:
            return UITableView.automaticDimension
        }
    }
    
    // Toggling selected Date Picker View
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        /*
        if indexPath == checkInDateCellIndexPath {
            isCheckInDatePickerVisible.toggle()
            isCheckOutDatePickerVisible = false
        } else if indexPath == checkOutDateCellIndexPath {
            isCheckOutDatePickerVisible.toggle()
            isCheckInDatePickerVisible = false
        } else {
            isCheckInDatePickerVisible = false
            isCheckOutDatePickerVisible = false
        }
        */
            //This ^^^ does the same thing as my switch statement vvv, but I like the switch statement better, and didn't think to write it until someone else suggested it — after I wrote my "if" statement.
        
        switch indexPath {
        case checkInDateCellIndexPath:
            isCheckInDatePickerVisible.toggle()
            isCheckOutDatePickerVisible = false
        case checkOutDateCellIndexPath:
            isCheckOutDatePickerVisible.toggle()
            isCheckInDatePickerVisible = false
        default:
            tableView.deselectRow(at: indexPath, animated: true)
            isCheckInDatePickerVisible = false
            isCheckOutDatePickerVisible = false
        }
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    @IBAction func textFieldTapped(_ sender: UITextField) {
        
        // Personal Code Functionality
        tableView(self.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
    
   // MARK: - Number of Guests
    
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    
    func updateNumberOfGuests() {
        numberOfAdultsLabel.text = "\(Int(numberOfAdultsStepper.value))"
        numberOfChildrenLabel.text = "\(Int(numberOfChildrenStepper.value))"
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        updateNumberOfGuests()
        
        // Personal Code Functionality
        tableView(self.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
    
    //MARK: - Wi-Fi Option
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    @IBAction func wifiSwitchChanged(_ sender: UISwitch) {
        
        // Personal Code Functionality
        tableView(self.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
    
    //MARK: - Select Room Type
    @IBOutlet weak var selectedRoomLabel: UILabel!
    var roomType: RoomType?
    
    func updateRoomType() {
        if let roomType = roomType {
            selectedRoomLabel.text = roomType.name
        } else {
            selectedRoomLabel.text = "Select Room"
        }
    }
    
    @IBSegueAction func selectRoomType(_ coder: NSCoder) -> SelectRoomTypeTableViewController? {
        
        let selectRoomTypeController = SelectRoomTypeTableViewController(coder: coder)
        selectRoomTypeController?.delegate = self
        selectRoomTypeController?.roomType = roomType
        
        return selectRoomTypeController
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "unwindFromAddRegistrationWithUnwindSegue:" else { return }
        
        
    }
    
}

extension AddRegistrationTableViewController: SelectRoomTypeTableViewControllerDelegate {
    func selectRoomTypeViewController(_ sourceController: SelectRoomTypeTableViewController, didSelect roomType: RoomType) {
        self.roomType = roomType
        updateRoomType()
    }
    
    
}

// Pick up @ p.242

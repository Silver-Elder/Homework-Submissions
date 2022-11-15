
import UIKit

class RegistrationTableViewController: UITableViewController {
    
    var registrations: [Registration] = []
    var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        return dateFormatter
    }()
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registrations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegistrationCell", for: indexPath)

        let registration = registrations[indexPath.row]

        cell.textLabel?.text = "\(registration.firstName)  \(registration.lastName)"
        cell.detailTextLabel?.text = "\(dateFormatter.string(from: registration.checkInDate)) -  \(dateFormatter.string(from: registration.checkOutDate)): \(registration.roomType.name)"

        return cell
    }
    
    @IBSegueAction func segueToAddRegistrationTableView(_ coder: NSCoder, sender: Any?) -> AddRegistrationTableViewController? {
        if let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
                // Editing Room
                let registrationToEdit = registrations[indexPath.row]
                return AddRegistrationTableViewController(coder: coder,
                   registration: registrationToEdit)
            } else {
                // Adding Emoji
                return AddEditEmojiTableViewController(coder: coder,
                   emoji: nil)
            }
    }
    
    @IBAction func unwindFromAddRegistration(unwindSegue: UIStoryboardSegue) {
        guard let addRegistrationTableViewController = unwindSegue.source as? AddRegistrationTableViewController, let registration = addRegistrationTableViewController.registration else { return }
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            registrations[selectedIndexPath.row] = registration
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: registrations.count, section: 0)
            registrations.append(registration)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }

}

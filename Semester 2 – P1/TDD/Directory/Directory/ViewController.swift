//
//  ViewController.swift
//  Directory
//
//  Created by Sterling Jenkins on 1/4/23.
//

/*
 - Lab Prompt: With a partner, work to design a system.  Use protocol oriented programming principles and dependency injection to wire everything up.
 
    - Conceptually design a Directory app.
    - It will have a simple list of People.  The UI should be able to view a persons details or create a new person.
    - Don’t write any code at this point.  Simply define the classes and structs and what they should be able to do. Then design protocols that will be used for tying your classes and structs together.
 
 We'll need a PersonListTableViewController class, a PersonDetailTableViewController class, and a AddPersonStaticTableView class
 
 Let's write out what classes and structs we'll need to use in each ViewController Class
 
  - PersonListTableViewController:
    - Classes:
        - TableView
    - Struct:
        - Person
 
  - PersonDetailTableViewController:
     - Classes:
        - TableView
     - Structs:
        - Person
 
  - AddPersonStaticTableView:
     - Classes:
        - Static Table View
 
 
 Let's Define what these Classes, Structs, and Protocols should contain:
 
    - Classes:
        - Table View:
            - Uses all of Swift's prefefined subclasses to construct the table view and configure the default tableView cell based off each person's name
    
    - Structs:
        - Person: Equteable
            - var firstName: String
            - var lastName: String
            - var age: Int
            - var phoneNumber: String
            - var email: String
            - var address: String
            - var birthday: String
            - var notes: String
 
            - func: Allows Person objects to be compared by first name
            - func: Allows Person objects to be compared by last name
  
 
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


//
//  DirectoryTests.swift
//  DirectoryTests
//
//  Created by Sterling Jenkins on 1/4/23.
//

import XCTest
@testable import Directory

final class DirectoryTests: XCTestCase {

    var tableVCUnderTest: ListTableViewController!

    override func setUpWithError() throws {
        super.setUp()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.tableVCUnderTest = storyboard.instantiateViewController(withIdentifier: "ListTableViewController") as? ListTableViewController
                // in view controller, menuItems = ["one", "two", "three"]
                self.tableVCUnderTest.loadView()
                self.tableVCUnderTest.viewDidLoad()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Person_WithParams() {
        let person = Person(name: "bob", age: 90)
        XCTAssert(person.name == "bob")
        XCTAssert(person.age == 90)
    }
    
    func test_Person_WithNewParams() {
        let person = Person(name: "Tyler", lastName: "Sun", phoneNumber: "(208) 442-5674")
        XCTAssertEqual(person.name, "Tyler")
        XCTAssertNil(person.age)
        XCTAssert(person.phoneNumber == "(208) 442-5674")
        
        if let lastName = person.lastName {
            XCTAssert(lastName == "Sun")
        }
    }
    
   

    func test_ListTableVC_WithListOfPeople() {
        
        tableVCUnderTest.loadViewIfNeeded()
        XCTAssertNotNil(tableVCUnderTest)
    }
    
    func test_ListTableVC_RowCount() {
        XCTAssertTrue(tableVCUnderTest.tableView.numberOfRows(inSection: 0) == tableVCUnderTest.people.count)
        
        //XCTAssertNotNil(list.tableView(list.tableView, numberOfRowsInSection: list.people.count))
    }
    
    func test2_ListTableVC_WithListOfPeople() {
        tableVCUnderTest.people = [Person(name: "Michael", phoneNumber: "123-456-7890"),Person(name: "Tyler", phoneNumber: "123-456-7890"), Person(name: "Sterling", phoneNumber: "123-456-7890")]
        XCTAssertTrue(tableVCUnderTest.tableView.numberOfRows(inSection: 0) == tableVCUnderTest.people.count)
    }

    func test_TableViewCell_HasReuseIdentifier() {
        tableVCUnderTest.people = [Person(name: "Michael", phoneNumber: "123-456-7890"),Person(name: "Tyler", phoneNumber: "123-456-7890"), Person(name: "Sterling", phoneNumber: "123-456-7890")]
        
        let cell = tableVCUnderTest.tableView(tableVCUnderTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0))

        XCTAssert(cell.reuseIdentifier == "personCell")
    }
    
    func test_TableViewCell_CellHasPersonsName() {
        tableVCUnderTest.people = [Person(name: "Michael", phoneNumber: "123-456-7890"),Person(name: "Tyler", phoneNumber: "123-456-7890"), Person(name: "Sterling", phoneNumber: "123-456-7890")]
        
        let cell0 = tableVCUnderTest.tableView(tableVCUnderTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        print(cell0.contentConfiguration)
        print(cell0.textLabel?.text as String?)
        let myCell = cell0.textLabel
        print(myCell)
        XCTAssert(cell0.textLabel?.text == "Michael")
    }
    
}

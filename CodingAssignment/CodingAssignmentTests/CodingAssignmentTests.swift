//
//  CodingAssignmentTests.swift
//  CodingAssignmentTests
//
//  Created by Rajesh on 25/06/21.
//

import XCTest
@testable import CodingAssignment

class CodingAssignmentTests: XCTestCase {

    private var citiesViewModel = CitiesListViewModel()
    private var mapVC = MapViewController()
        
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.citiesViewModel.readJSONFromFile()
    }
    
    // Testing CitiesList count matching with json file.
    func testCitiesListCount () {
        XCTAssertTrue(self.citiesViewModel.citiesList.count == 209557)
        XCTAssertTrue(self.citiesViewModel.allCitiesList.count == 209557)
    }
    
    // Testing the filter with provided string.
    func testSearchCitiesListCountWithString () {
        self.citiesViewModel.reloadWithFilter(searchString: "Lichtenrade")
        XCTAssertTrue(self.citiesViewModel.citiesList.count == 1)
    }
    
    // Testing the filter with empty string.
    func testSearchCitiesListCountWithEmptyString () {
        self.citiesViewModel.reloadWithFilter(searchString: "")
        XCTAssertTrue(self.citiesViewModel.citiesList.count == 209557)
    }
    
    // Testing mapview.
    func testMapView () {
        XCTAssertNotNil(mapVC.mapview)
        XCTAssertNil(mapVC.citiyModel)
        mapVC.addAnnotation()
        XCTAssertFalse(mapVC.mapview.annotations.count == 1)
    }

}

//
//  CitiesListViewModel.swift
//  CodingAssignment
//
//  Created by Rajesh on 26/06/21.
//

import Foundation

class CitiesListViewModel: NSObject {
    
    var citiesList: [CityModel]!
    var bindCityViewModelToController : (() -> ()) = {} // Callback function to bind data
    
    // Reading the data from json file.
    func readJSONFromFile()
     {
         if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
             do {
                 let fileUrl = URL(fileURLWithPath: path)
                 // Getting data from JSON file using the file URL
                 let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                 //json = try? JSONSerialization.jsonObject(with: data)
                if let response = try? JSONDecoder().decode(CitiesListModel.self, from: data) {
                    self.citiesList = response
                    self.bindCityViewModelToController()
                }
             } catch {
                 // Handle error here
             }
         }
     }
}

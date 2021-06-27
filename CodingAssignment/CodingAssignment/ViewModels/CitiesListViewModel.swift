//
//  CitiesListViewModel.swift
//  CodingAssignment
//
//  Created by Rajesh on 26/06/21.
//

import Foundation

class CitiesListViewModel: NSObject {
    
    var allCitiesList: [CityModel]!
    var citiesList: [CityModel]!
    var bindCityViewModelToController : (() -> ()) = {} // Callback function to bind data
    
    // Reading the data from json file.
     func readJSONFromFile() {
         if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                //json = try? JSONSerialization.jsonObject(with: data)
                if let response = try? JSONDecoder().decode(CitiesListModel.self, from: data) {
                    var list = response
                    list.sort { (obj1, obj2) -> Bool in
                        if "\(obj1.name ?? ""), \(obj1.country ?? "")" < "\(obj2.name ?? ""), \(obj2.country ?? "")" {
                            return true
                        }
                        return false
                    }
                    self.citiesList = list
                    self.allCitiesList = list
                    self.bindCityViewModelToController()
                }
            } catch {
                 // Handle error here
             }
         }
     }
    
    // Implemented a search algorithm by filtering the citieslist.
    func reloadWithFilter (searchString: String){
        self.citiesList = []
        if searchString.isEmpty {
            self.citiesList = self.allCitiesList
        }
        else {
            self.citiesList = self.allCitiesList.filter({ (cityObj) -> Bool in
                let title = "\(cityObj.name ?? ""), \(cityObj.country ?? "")"
                if title.lowercased().hasPrefix(searchString.lowercased().replacingOccurrences(of: " ", with: "")){
                    return true
                }
                return false
            })
        }
        self.bindCityViewModelToController()
    }
}

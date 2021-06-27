//
//  TableViewDatasourceAndDelegate.swift
//  CodingAssignment
//
//  Created by Rajesh on 26/06/21.
//

import Foundation
import UIKit

class TableViewDataSourceAndDelegate <CELL : UITableViewCell,T> : NSObject, UITableViewDataSource, UITableViewDelegate {

    private var cellIdentifier : String!
    private var items : [T]!
    var configureCell : (CELL, T) -> () = {_,_ in }
    var rowSelected : ((T) -> ()) = {_ in}
    
    init(cellIdentifier : String, items : [T], configureCell : @escaping (CELL, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items =  items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        let item = self.items[indexPath.row]
        cell.selectionStyle = .none
        self.configureCell(cell, item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.rowSelected(items[indexPath.row])
    }
}

//
//  CityTableViewCell.swift
//  CodingAssignment
//
//  Created by Rajesh on 26/06/21.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    // Creating TableViewCell with subtitle style
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

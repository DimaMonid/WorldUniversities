//
//  UniversityCell.swift
//  WorldUniversities
//
//  Created by Дима Монид on 6.03.25.
//

import UIKit

final class UniversityCell: UITableViewCell {
    
    @IBOutlet var nameUniversityLabel: UILabel!
    @IBOutlet var webUniversityLabel: UILabel!
    @IBOutlet var twoCodeUniversityLabel: UILabel!

    private let networkManager = NetworkManager.shared
    
    func configure(with university: University){
        nameUniversityLabel.text = university.name
        university.webPages.forEach{ webPage in
            webUniversityLabel.text = ("\(webPage)\n")
        }
        twoCodeUniversityLabel.text = university.alphaTwoCode
    }

}

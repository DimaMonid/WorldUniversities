//
//  UniversityViewController.swift
//  WorldUniversities
//
//  Created by Дима Монид on 6.03.25.
//

import UIKit

final class UniversityViewController: UITableViewController {

    private var universities: [University] = []
    private let networkManager = NetworkManager.shared
    var country: String?
    
    var filteredUniversities: [University]{
        universities.filter{$0.country == country}
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Universities in \(country ?? "")"
        tableView.rowHeight = 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredUniversities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "universitiesCell", for: indexPath)
        guard let cell = cell as? UniversityCell else { return UITableViewCell() }
        let university = filteredUniversities[indexPath.row]
        cell.configure(with: university)
        return cell
    }

}

extension UniversityViewController{
    
    func fetchUniversities(){
        networkManager.fetchData(from: Link.main.url) { [unowned self] result in
            switch result {
            case .success(let university):
                universities = university
                tableView.reloadData()
                print(filteredUniversities)
            case .failure(let error):
                print(error)
            }
        }
    }
}

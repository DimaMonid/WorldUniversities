//
//  ViewController.swift
//  WorldUniversities
//
//  Created by Дима Монид on 6.03.25.
//

import UIKit

enum Link {
    case main
    
    var url: URL {
        switch self {
        case .main:
            URL(string: "https://raw.githubusercontent.com/Hipo/university-domains-list/refs/heads/master/world_universities_and_domains.json")!
        }
    }
}

final class SearchTableViewController: UITableViewController {
    
    private var universities: [University] = []
    private let networkManager = NetworkManager.shared
    private var countries: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 50
        fetchData()
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let universitiesVC = segue.destination as? UniversityViewController else { return }
                universitiesVC.fetchUniversities()
                universitiesVC.country = countries[indexPath.row]
            }
        }
}

extension SearchTableViewController {
    
    func fetchData(){
        networkManager.fetchData(from: Link.main.url) { [unowned self] result in
            switch result {
            case .success(let data):
                universities = data
                universities
                    .forEach {
                        if !countries.contains($0.country) {
                            countries.append($0.country)
                        }
                    }
                countries.sort()
                tableView.reloadData()
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let country = countries[indexPath.row]
        
        content.text = country
        cell.contentConfiguration = content
        
        return cell
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
 
}




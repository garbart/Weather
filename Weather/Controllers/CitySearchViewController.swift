//
//  CitySearchViewController.swift
//  Weather
//
//  Created by Artem Garbart on 02.12.2022.
//

import UIKit

class CitySearchViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    private static var cities: [CityData] = []
    private var filteredCities: [CityData] = []
    
    var updateWeather: ((CityData) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self

        DispatchQueue.global().async {
            if (CitySearchViewController.cities.isEmpty) {
                CitySearchViewController.cities = JSONParser.parse(fromJSONFile: "cities") ?? []
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCities.removeAll()
        
        if (searchText.isEmpty) {
            self.tableView.reloadData()
            return
        }
        
        for city in CitySearchViewController.cities {
            if city.name.starts(with: searchText) {
                filteredCities.append(city)
            }
        }
        
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        
        let city = filteredCities[indexPath.row]
        var text = city.name
        if !city.state.isEmpty {
            text.append(", \(city.state)")
        }
        if !city.country.isEmpty {
            text.append(", \(city.country)")
        }
        cell.textLabel?.text = text
 
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true)
        updateWeather?(filteredCities[indexPath.row])
    }
    
}

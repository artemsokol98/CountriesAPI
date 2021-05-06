//
//  CountryListTableViewController.swift
//  CountriesAPI
//
//  Created by Артем Соколовский on 02.05.2021.
//

import UIKit
import Alamofire

class CountryListTableViewController: UITableViewController {
    
    private var dictCountries: [Dictionary<String, String>.Element] = []
    
    private var spinnerView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinnerView = showSpinner(in: tableView)
        sendRequest(countryAPI: URLS.countryAPI.rawValue)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dictCountries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let item = Array(dictCountries)[indexPath.row].value
        
        content.text = item
        cell.contentConfiguration = content
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let countryDetailVC = segue.destination as! CountryDetailViewController
            countryDetailVC.shortName = Array(dictCountries)[indexPath.row].key
            countryDetailVC.nameOfCountry = Array(dictCountries)[indexPath.row].value
        }
    }
    
    private func sendRequest(countryAPI: String) {
        NetworkManager.shared.fetchAlamofireCountryList(countryAPI: countryAPI) { countryList in
            DispatchQueue.main.async {
                self.spinnerView.stopAnimating()
                self.dictCountries = countryList
                self.tableView.reloadData()
            }
        }
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    
    
    
    
}

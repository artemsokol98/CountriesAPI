//
//  CountryDetailViewController.swift
//  CountriesAPI
//
//  Created by Артем Соколовский on 03.05.2021.
//

import UIKit
import SVGKit

class CountryDetailViewController: UIViewController {

    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var shortName: String!
    var countryDetail: CountryDetail!
    var nameOfCountry: String!
    
    private var spinnerView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinnerView = showSpinner(in: view)
        self.title = self.nameOfCountry
        sendRequest(countryAPI: URLS.countryAPI.rawValue, shortName: shortName)
    }
    
    private func sendRequest(countryAPI: String, shortName: String) {
        NetworkManager.shared.fetchAlamofireCountryDetails(countryAPI: countryAPI, shortName: shortName) { countryDetail, imageData in
            DispatchQueue.main.async {
                self.spinnerView.stopAnimating()
                let anSVGImage: SVGKImage = SVGKImage(data: imageData)
                self.flagImage.image = anSVGImage.uiImage
                self.descriptionLabel.text = countryDetail.description
            }
            
        }
    }
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }
    

}

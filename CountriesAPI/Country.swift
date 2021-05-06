//
//  Country.swift
//  CountriesAPI
//
//  Created by Артем Соколовский on 02.05.2021.
//

// MARK: - CountryList
struct CountryList: Codable {
    let countries: [String: String]
    let status: String
}

// MARK: - CountryDetail
struct CountryDetail: Codable {
    let capital: Capital
    let areaSize: String
    let population: Int
    let flag: Flag
    let currency: Currency
    let continent: Continent
    let status: String

    enum CodingKeys: String, CodingKey {
        case capital
        case areaSize = "area_size"
        case population
        case flag
        case currency, continent, status
        
    }
    
    var description: String {
        """
        Total Area: \(areaSize)
        Capital: \(capital.name)
        Population: \(String(population))
        Currency: \(currency.code) (\(currency.name))
        Continent: \(continent.name)
        """
    }
}

// MARK: - Capital
struct Capital: Codable {
    let name: String
    let geonameid: Int
}

// MARK: - Continent
struct Continent: Codable {
    let geonameid: Int
    let name, code: String
}

// MARK: - Currency
struct Currency: Codable {
    let code, name: String
}

// MARK: - Flag
struct Flag: Codable {
    let file: String
    let emoji, unicode: String
}

enum URLS: String {
    case countryAPI = "https://countries-cities.p.rapidapi.com/location/country/"
}

// CityManager.swift
// Manages the list of cities and user selections

import Foundation
import Combine

class CityManager: ObservableObject {
    static let shared = CityManager()
    
    @Published var cities: [City] = []
    
    private let userDefaultsKey = "selectedCities"
    
    private init() {
        // Load cities and selections
        loadCities()
        loadSelectedCities()
    }
    
    func loadCities() {
        cities = [
            // Japan
            City(name: "Tokyo", shortName: "TKY", timezone: "Asia/Tokyo", flag: "🇯🇵", region: "Japan"),
            City(name: "Osaka", shortName: "OSA", timezone: "Asia/Tokyo", flag: "🇯🇵", region: "Japan"),
            City(name: "Sapporo", shortName: "SAP", timezone: "Asia/Tokyo", flag: "🇯🇵", region: "Japan"),
            City(name: "Fukuoka", shortName: "FUK", timezone: "Asia/Tokyo", flag: "🇯🇵", region: "Japan"),
            
            // United States
            City(name: "New York", shortName: "NY", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "Los Angeles", shortName: "LA", timezone: "America/Los_Angeles", flag: "🇺🇸", region: "United States"),
            City(name: "Chicago", shortName: "CHI", timezone: "America/Chicago", flag: "🇺🇸", region: "United States"),
            City(name: "Houston", shortName: "HOU", timezone: "America/Chicago", flag: "🇺🇸", region: "United States"),
            City(name: "Phoenix", shortName: "PHX", timezone: "America/Phoenix", flag: "🇺🇸", region: "United States"),
            City(name: "Philadelphia", shortName: "PHI", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "San Antonio", shortName: "SA", timezone: "America/Chicago", flag: "🇺🇸", region: "United States"),
            City(name: "San Diego", shortName: "SD", timezone: "America/Los_Angeles", flag: "🇺🇸", region: "United States"),
            City(name: "Dallas", shortName: "DAL", timezone: "America/Chicago", flag: "🇺🇸", region: "United States"),
            City(name: "San Jose", shortName: "SJ", timezone: "America/Los_Angeles", flag: "🇺🇸", region: "United States"),
            City(name: "Austin", shortName: "AUS", timezone: "America/Chicago", flag: "🇺🇸", region: "United States"),
            City(name: "Jacksonville", shortName: "JAX", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "Fort Worth", shortName: "FW", timezone: "America/Chicago", flag: "🇺🇸", region: "United States"),
            City(name: "Columbus", shortName: "COL", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "Charlotte", shortName: "CHA", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "San Francisco", shortName: "SF", timezone: "America/Los_Angeles", flag: "🇺🇸", region: "United States"),
            City(name: "Indianapolis", shortName: "IND", timezone: "America/Indiana/Indianapolis", flag: "🇺🇸", region: "United States"),
            City(name: "Seattle", shortName: "SEA", timezone: "America/Los_Angeles", flag: "🇺🇸", region: "United States"),
            City(name: "Denver", shortName: "DEN", timezone: "America/Denver", flag: "🇺🇸", region: "United States"),
            City(name: "Boston", shortName: "BOS", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "Portland", shortName: "POR", timezone: "America/Los_Angeles", flag: "🇺🇸", region: "United States"),
            City(name: "Las Vegas", shortName: "LV", timezone: "America/Los_Angeles", flag: "🇺🇸", region: "United States"),
            City(name: "Detroit", shortName: "DET", timezone: "America/Detroit", flag: "🇺🇸", region: "United States"),
            City(name: "Miami", shortName: "MIA", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "Boise", shortName: "BOI", timezone: "America/Boise", flag: "🇺🇸", region: "United States"),
            
            // Canada
            City(name: "Toronto", shortName: "TOR", timezone: "America/Toronto", flag: "🇨🇦", region: "Canada"),
            City(name: "Vancouver", shortName: "VAN", timezone: "America/Vancouver", flag: "🇨🇦", region: "Canada"),
            City(name: "Montreal", shortName: "MTL", timezone: "America/Montreal", flag: "🇨🇦", region: "Canada"),
            City(name: "Calgary", shortName: "CAL", timezone: "America/Edmonton", flag: "🇨🇦", region: "Canada"),
            City(name: "Ottawa", shortName: "OTT", timezone: "America/Toronto", flag: "🇨🇦", region: "Canada"),
            City(name: "Edmonton", shortName: "EDM", timezone: "America/Edmonton", flag: "🇨🇦", region: "Canada"),
            
            // Philippines
            City(name: "Manila", shortName: "MAN", timezone: "Asia/Manila", flag: "🇵🇭", region: "Philippines"),
            City(name: "Cebu", shortName: "CEB", timezone: "Asia/Manila", flag: "🇵🇭", region: "Philippines"),
            City(name: "Davao", shortName: "DAV", timezone: "Asia/Manila", flag: "🇵🇭", region: "Philippines"),
            City(name: "Quezon City", shortName: "QC", timezone: "Asia/Manila", flag: "🇵🇭", region: "Philippines"),
            
            // Mexico
            City(name: "Mexico City", shortName: "MEX", timezone: "America/Mexico_City", flag: "🇲🇽", region: "Mexico"),
            City(name: "Guadalajara", shortName: "GDL", timezone: "America/Mexico_City", flag: "🇲🇽", region: "Mexico"),
            City(name: "Monterrey", shortName: "MTY", timezone: "America/Monterrey", flag: "🇲🇽", region: "Mexico"),
            City(name: "Cancún", shortName: "CUN", timezone: "America/Cancun", flag: "🇲🇽", region: "Mexico"),
            
            // Europe
            City(name: "London", shortName: "LON", timezone: "Europe/London", flag: "🇬🇧", region: "Europe"),
            City(name: "Paris", shortName: "PAR", timezone: "Europe/Paris", flag: "🇫🇷", region: "Europe"),
            City(name: "Berlin", shortName: "BER", timezone: "Europe/Berlin", flag: "🇩🇪", region: "Europe"),
            City(name: "Rome", shortName: "ROM", timezone: "Europe/Rome", flag: "🇮🇹", region: "Europe"),
            City(name: "Madrid", shortName: "MAD", timezone: "Europe/Madrid", flag: "🇪🇸", region: "Europe"),
            City(name: "Barcelona", shortName: "BCN", timezone: "Europe/Madrid", flag: "🇪🇸", region: "Europe"),
            City(name: "Amsterdam", shortName: "AMS", timezone: "Europe/Amsterdam", flag: "🇳🇱", region: "Europe"),
            City(name: "Vienna", shortName: "VIE", timezone: "Europe/Vienna", flag: "🇦🇹", region: "Europe"),
            City(name: "Prague", shortName: "PRG", timezone: "Europe/Prague", flag: "🇨🇿", region: "Europe"),
            City(name: "Lisbon", shortName: "LIS", timezone: "Europe/Lisbon", flag: "🇵🇹", region: "Europe"),
            City(name: "Athens", shortName: "ATH", timezone: "Europe/Athens", flag: "🇬🇷", region: "Europe"),
            City(name: "Venice", shortName: "VCE", timezone: "Europe/Rome", flag: "🇮🇹", region: "Europe"),
            City(name: "Florence", shortName: "FLR", timezone: "Europe/Rome", flag: "🇮🇹", region: "Europe"),
            City(name: "Dublin", shortName: "DUB", timezone: "Europe/Dublin", flag: "🇮🇪", region: "Europe"),
            City(name: "Copenhagen", shortName: "CPH", timezone: "Europe/Copenhagen", flag: "🇩🇰", region: "Europe"),
            City(name: "Stockholm", shortName: "STO", timezone: "Europe/Stockholm", flag: "🇸🇪", region: "Europe"),
            City(name: "Zurich", shortName: "ZRH", timezone: "Europe/Zurich", flag: "🇨🇭", region: "Europe"),
            City(name: "Brussels", shortName: "BRU", timezone: "Europe/Brussels", flag: "🇧🇪", region: "Europe"),
            City(name: "Edinburgh", shortName: "EDI", timezone: "Europe/London", flag: "🏴󠁧󠁢󠁳󠁣󠁴󠁿", region: "Europe"),
            City(name: "Istanbul", shortName: "IST", timezone: "Europe/Istanbul", flag: "🇹🇷", region: "Europe"),
            
            // Asia
            City(name: "Dubai", shortName: "DXB", timezone: "Asia/Dubai", flag: "🇦🇪", region: "Asia"),
            City(name: "Singapore", shortName: "SIN", timezone: "Asia/Singapore", flag: "🇸🇬", region: "Asia"),
            City(name: "Hong Kong", shortName: "HKG", timezone: "Asia/Hong_Kong", flag: "🇭🇰", region: "Asia"),
            City(name: "Bangkok", shortName: "BKK", timezone: "Asia/Bangkok", flag: "🇹🇭", region: "Asia"),
            City(name: "Seoul", shortName: "SEL", timezone: "Asia/Seoul", flag: "🇰🇷", region: "Asia"),
            City(name: "Shanghai", shortName: "SHA", timezone: "Asia/Shanghai", flag: "🇨🇳", region: "Asia"),
            City(name: "Beijing", shortName: "BJS", timezone: "Asia/Shanghai", flag: "🇨🇳", region: "Asia"),
            City(name: "Mumbai", shortName: "BOM", timezone: "Asia/Kolkata", flag: "🇮🇳", region: "Asia"),
            City(name: "Delhi", shortName: "DEL", timezone: "Asia/Kolkata", flag: "🇮🇳", region: "Asia"),
            City(name: "Taipei", shortName: "TPE", timezone: "Asia/Taipei", flag: "🇹🇼", region: "Asia"),
            City(name: "Kuala Lumpur", shortName: "KUL", timezone: "Asia/Kuala_Lumpur", flag: "🇲🇾", region: "Asia"),
            City(name: "Jakarta", shortName: "JKT", timezone: "Asia/Jakarta", flag: "🇮🇩", region: "Asia"),
            City(name: "Bali", shortName: "DPS", timezone: "Asia/Makassar", flag: "🇮🇩", region: "Asia"),
            City(name: "Hanoi", shortName: "HAN", timezone: "Asia/Bangkok", flag: "🇻🇳", region: "Asia"),
            City(name: "Ho Chi Minh City", shortName: "SGN", timezone: "Asia/Bangkok", flag: "🇻🇳", region: "Asia"),
            City(name: "Phuket", shortName: "HKT", timezone: "Asia/Bangkok", flag: "🇹🇭", region: "Asia"),
            City(name: "Kyoto", shortName: "KYO", timezone: "Asia/Tokyo", flag: "🇯🇵", region: "Asia"),
            
            // Oceania
            City(name: "Sydney", shortName: "SYD", timezone: "Australia/Sydney", flag: "🇦🇺", region: "Oceania"),
            City(name: "Melbourne", shortName: "MEL", timezone: "Australia/Melbourne", flag: "🇦🇺", region: "Oceania"),
            City(name: "Brisbane", shortName: "BNE", timezone: "Australia/Brisbane", flag: "🇦🇺", region: "Oceania"),
            City(name: "Perth", shortName: "PER", timezone: "Australia/Perth", flag: "🇦🇺", region: "Oceania"),
            City(name: "Auckland", shortName: "AKL", timezone: "Pacific/Auckland", flag: "🇳🇿", region: "Oceania"),
            City(name: "Wellington", shortName: "WLG", timezone: "Pacific/Auckland", flag: "🇳🇿", region: "Oceania"),
            City(name: "Gold Coast", shortName: "OOL", timezone: "Australia/Brisbane", flag: "🇦🇺", region: "Oceania"),
            City(name: "Queenstown", shortName: "ZQN", timezone: "Pacific/Auckland", flag: "🇳🇿", region: "Oceania"),
            
            // Middle East & Africa
            City(name: "Tel Aviv", shortName: "TLV", timezone: "Asia/Jerusalem", flag: "🇮🇱", region: "Middle East"),
            City(name: "Jerusalem", shortName: "JRS", timezone: "Asia/Jerusalem", flag: "🇮🇱", region: "Middle East"),
            City(name: "Abu Dhabi", shortName: "AUH", timezone: "Asia/Dubai", flag: "🇦🇪", region: "Middle East"),
            City(name: "Doha", shortName: "DOH", timezone: "Asia/Qatar", flag: "🇶🇦", region: "Middle East"),
            City(name: "Riyadh", shortName: "RUH", timezone: "Asia/Riyadh", flag: "🇸🇦", region: "Middle East"),
            City(name: "Cairo", shortName: "CAI", timezone: "Africa/Cairo", flag: "🇪🇬", region: "Africa"),
            City(name: "Marrakech", shortName: "RAK", timezone: "Africa/Casablanca", flag: "🇲🇦", region: "Africa"),
            City(name: "Cape Town", shortName: "CPT", timezone: "Africa/Johannesburg", flag: "🇿🇦", region: "Africa"),
            City(name: "Nairobi", shortName: "NBO", timezone: "Africa/Nairobi", flag: "🇰🇪", region: "Africa"),
            
            // South America
            City(name: "São Paulo", shortName: "SAO", timezone: "America/Sao_Paulo", flag: "🇧🇷", region: "South America"),
            City(name: "Rio de Janeiro", shortName: "RIO", timezone: "America/Sao_Paulo", flag: "🇧🇷", region: "South America"),
            City(name: "Buenos Aires", shortName: "BUE", timezone: "America/Argentina/Buenos_Aires", flag: "🇦🇷", region: "South America"),
            City(name: "Lima", shortName: "LIM", timezone: "America/Lima", flag: "🇵🇪", region: "South America"),
            City(name: "Bogotá", shortName: "BOG", timezone: "America/Bogota", flag: "🇨🇴", region: "South America"),
            City(name: "Santiago", shortName: "SCL", timezone: "America/Santiago", flag: "🇨🇱", region: "South America"),
            City(name: "Cusco", shortName: "CUZ", timezone: "America/Lima", flag: "🇵🇪", region: "South America"),
            
            // Caribbean & Central America
            City(name: "Havana", shortName: "HAV", timezone: "America/Havana", flag: "🇨🇺", region: "Caribbean"),
            City(name: "San Juan", shortName: "SJU", timezone: "America/Puerto_Rico", flag: "🇵🇷", region: "Caribbean"),
            City(name: "Nassau", shortName: "NAS", timezone: "America/Nassau", flag: "🇧🇸", region: "Caribbean"),
            City(name: "Panama City", shortName: "PTY", timezone: "America/Panama", flag: "🇵🇦", region: "Central America"),
            City(name: "San José", shortName: "SJO", timezone: "America/Costa_Rica", flag: "🇨🇷", region: "Central America"),
        ]
    }
    
    func toggleCity(_ city: City) {
        if let index = cities.firstIndex(where: { $0.id == city.id }) {
            let selectedCount = cities.filter { $0.isSelected }.count
            
            // Check if trying to select more than 5 cities
            if !cities[index].isSelected && selectedCount >= 5 {
                return
            }
            
            cities[index].isSelected.toggle()
            saveSelectedCities()
            
            // Notify AppDelegate to update menu bar
            NotificationCenter.default.post(name: NSNotification.Name("UpdateMenuBar"), object: nil)
        }
    }
    
    func getSelectedCities() -> [City] {
        return cities.filter { $0.isSelected }
    }
    
    func saveSelectedCities() {
        let selectedNames = cities.filter { $0.isSelected }.map { $0.name }
        UserDefaults.standard.set(selectedNames, forKey: userDefaultsKey)
    }
    
    func loadSelectedCities() {
        guard let selectedNames = UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] else { return }
        
        for i in 0..<cities.count {
            if selectedNames.contains(cities[i].name) {
                cities[i].isSelected = true
            }
        }
    }
}

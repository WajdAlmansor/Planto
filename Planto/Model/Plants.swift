import Foundation
import SwiftData

@Model
final class Plants {
    var id: UUID = UUID() // Unique identifier for each plant
    var plantName: String
    var selectedRoom: roomOptions
    var selectedLight: LightCondition
    var selectedWateringDay: WateringDaysOptions
    var selectedWaterAmount: WaterOptions
    var isCompleted: Bool = false // New property to track completion status
    
    init(plantName: String, selectedRoom: roomOptions, selectedLight: LightCondition, selectedWateringDay: WateringDaysOptions, selectedWaterAmount: WaterOptions, isCompleted: Bool = false) {
        self.plantName = plantName
        self.selectedRoom = selectedRoom
        self.selectedLight = selectedLight
        self.selectedWateringDay = selectedWateringDay
        self.selectedWaterAmount = selectedWaterAmount
        self.isCompleted = isCompleted
    }
}

enum roomOptions: String, Codable, CaseIterable {
    case bedroom = "Bedroom"
    case livingroom = "Living Room"
    case kitchen = "Kitchen"
    case balcony = "Balcony"
    case bathroom = "Bathroom"
}

enum LightCondition: String, Codable, CaseIterable {
    case fullSun = "Full Sun"
    case partialSun = "Partial Sun"
    case lowLight = "Low Light"

    var icon: String {
        switch self {
        case .fullSun:
            return "sun.max"
        case .partialSun:
            return "cloud.sun"
        case .lowLight:
            return "moon"
        }
    }
}

enum WateringDaysOptions: String, Codable, CaseIterable {
    case daily = "Every day"
    case twodaily = "Every 2 days"
    case threedaily = "Every 3 days"
    case weekly = "Once a week"
    case tendays = "Every 10 days"
    case twoweek = "Every 2 weeks"
}

enum WaterOptions: String, Codable, CaseIterable {
    case one = "20-50 ml"
    case two = "50-100 ml"
    case three = "100-200 ml"
    case four = "200-300 ml"
}

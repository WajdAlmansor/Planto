import Foundation
import SwiftData

class ReminderViewModel: ObservableObject {
    @Published var items: [Plants] = []
    
    func loadPlants(context: ModelContext) {
          do {
              // Fetch all Plants objects from Swift Data
              let fetchedItems: [Plants] = try context.fetch(FetchDescriptor<Plants>())
              self.items = fetchedItems
          } catch {
              print("Failed to fetch plants: \(error)")
              self.items = []
          }
      }
    
    
    func addNewPlant(
        plantName: String,
        selectedRoom: roomOptions,
        selectedLight: LightCondition,
        selectedWateringDay: WateringDaysOptions,
        selectedWaterAmount: WaterOptions,
        context: ModelContext
    ) {
        let newPlant = Plants(
            plantName: plantName.isEmpty ? "Pothos" : plantName,
            selectedRoom: selectedRoom,
            selectedLight: selectedLight,
            selectedWateringDay: selectedWateringDay,
            selectedWaterAmount: selectedWaterAmount
        )
        
        context.insert(newPlant)
        self.items.append(newPlant)
    }
    
    
    func deleteReminder(_ reminder: Plants, context: ModelContext) {
        context.delete(reminder)
        self.items.removeAll { $0.id == reminder.id }
    }
}

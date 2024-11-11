import SwiftUI
import SwiftData

struct EditPlant: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ReminderViewModel
    @Environment(\.modelContext) private var context
    
    @State private var plantName: String = ""
    @State private var selectedRoom: roomOptions = .bedroom
    @State private var selectedLight: LightCondition = .fullSun
    @State private var selectedWateringDay: WateringDaysOptions = .daily
    @State private var selectedWaterAmount: WaterOptions = .one
    
    var cancelButtonColor: Color {
        Color(red: 41/255, green: 223/255, blue: 168/255)
    }

    private func addNewPlant() {
        viewModel.addNewPlant(
            plantName: plantName,
            selectedRoom: selectedRoom,
            selectedLight: selectedLight,
            selectedWateringDay: selectedWateringDay,
            selectedWaterAmount: selectedWaterAmount,
            context: context
        )
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button(action: { dismiss() }) {
                        Text("Cancel")
                            .foregroundColor(cancelButtonColor)
                            .padding(0.0)
                            .frame(width: 55.0)
                    }
                    
                    Spacer()
                    
                    Text("Set Reminder")
                        .fontWeight(.bold)
                        .padding(-5.0)
                        .frame(width: 106.0)
                    
                    Spacer()
                    
                    Button(action: {
                        addNewPlant()
                        dismiss()
                    }) {
                        Text("Save")
                            .foregroundColor(cancelButtonColor)
                    }
                }
                .padding()
                
                VStack {
                    HStack {
                        Text("Plant Name ")
                        TextField("Pothos", text: $plantName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
                
                VStack {
                    HStack {
                        Label("Room", systemImage: "location")
                        Spacer()
                        Picker("Room", selection: $selectedRoom) {
                            ForEach(roomOptions.allCases, id: \.self) { room in
                                Text(room.rawValue)
                                    .tag(room)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    HStack {
                        Label("Light", systemImage: selectedLight.icon)
                        Spacer()
                        Picker("Light", selection: $selectedLight) {
                            ForEach(LightCondition.allCases, id: \.self) { light in
                                Text(light.rawValue)
                                    .tag(light)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
                
                VStack {
                    HStack {
                        Label("Watering Days", systemImage: "drop")
                        Spacer()
                        Picker("waterDays", selection: $selectedWateringDay) {
                            ForEach(WateringDaysOptions.allCases, id: \.self) { waterDays in
                                Text(waterDays.rawValue).tag(waterDays)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    HStack {
                        Label("Water", systemImage: "drop")
                        Spacer()
                        Picker("water", selection: $selectedWaterAmount) {
                            ForEach(WaterOptions.allCases, id: \.self) { water in
                                Text(water.rawValue).tag(water)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top)
        }
    }
}

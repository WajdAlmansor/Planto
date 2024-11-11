import SwiftUI
import SwiftData

struct EditReminder: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ReminderViewModel
    @Environment(\.modelContext) private var context
    
    @State var reminder: Plants
    
    var body: some View {
        NavigationStack {
            Spacer()
            VStack {
                HStack {
                    Button(action: { dismiss() }) {
                        Text("Cancel")
                            .foregroundColor(Color(red: 41/255, green: 223/255, blue: 168/255))
                            .padding(0.0)
                            .frame(width: 55.0)
                    }
                    
                    Spacer()
                    
                    Text("Edit Reminder")
                        .fontWeight(.bold)
                        .padding(-5.0)
                        .frame(width: 106.0)
                    
                    Spacer()
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Save")
                            .foregroundColor(Color(red: 41/255, green: 223/255, blue: 168/255))
                    }
                }
                .padding()
                
                VStack {
                    HStack {
                        Text("Plant Name ")
                        TextField("Pothos", text: $reminder.plantName)
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
                        Picker("Room", selection: $reminder.selectedRoom) {
                            ForEach(roomOptions.allCases, id: \.self) { room in
                                Text(room.rawValue)
                                    .tag(room)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    HStack {
                        Label("Light", systemImage: reminder.selectedLight.icon)
                        Spacer()
                        Picker("Light", selection: $reminder.selectedLight) {
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
                        Picker("waterDays", selection: $reminder.selectedWateringDay) {
                            ForEach(WateringDaysOptions.allCases, id: \.self) { waterDays in
                                Text(waterDays.rawValue).tag(waterDays)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                    }
                    
                    HStack {
                        Label("Water", systemImage: "drop")
                        Spacer()
                        Picker("water", selection: $reminder.selectedWaterAmount) {
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
                
                VStack {
                    Button(action: {
                        viewModel.deleteReminder(reminder, context: context)
                        dismiss()
                    }) {
                        Text("Delete Reminder")
                            .bold()
                            .foregroundColor(.red)
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding(.horizontal)
            }
            Spacer()
            .padding(.top)
            
           
        }
    }
}


              


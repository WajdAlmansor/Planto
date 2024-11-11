import SwiftUI
import SwiftData

struct StartApp: View {
    @State private var showSheet = false
    @State private var selectedReminder: Plants? = nil
    @ObservedObject var viewModel = ReminderViewModel()
    @Environment(\.modelContext) private var context

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("My Plant 🌱")
                        .bold()
                        .font(.largeTitle)
                    Spacer()
                }
                Divider().background(Color.white)
                
                if viewModel.items.isEmpty {
                    // Display when no reminders exist
                    Image("plant")
                        .padding(.top, 50)
                    Text("Start your plant journey!")
                        .bold()
                        .font(.title)
                        .padding(.top, 20)
                    Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                        .font(.body)
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 15)
                        .padding(.top, 20)
                    
                    Button(action: {
                        showSheet.toggle()
                    }) {
                        Text("Set a plant Reminder")
                            .bold()
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 41/255, green: 223/255, blue: 168/255))
                            .cornerRadius(10)
                            .padding(.top, 50)
                    }
                    .sheet(isPresented: $showSheet) {
                        EditPlant(viewModel: viewModel)
                    }
                    
                } else {
                    VStack {
                        Text("Today")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    
                    ScrollView {
                        ForEach(viewModel.items, id: \.id) { reminder in
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Image(systemName: "location")
                                    Text("in \(reminder.selectedRoom.rawValue)")
                                }
                                .foregroundColor(.gray)
                                .font(.subheadline)
                                
                                HStack {
                                    Button(action: {
                                        reminder.isCompleted.toggle()
                                    }) {
                                        if reminder.isCompleted {
                                            Circle()
                                                .fill(Color(red: 40/255, green: 224/255, blue: 168/255))
                                                .frame(width: 30, height: 30)
                                        } else {
                                            Circle()
                                                .stroke(Color.gray, lineWidth: 2)
                                                .frame(width: 30, height: 30)
                                        }
                                    }
                                    
                                    // Button to trigger the sheet for editing the reminder
                                    Button(action: {
                                        selectedReminder = reminder
                                        showSheet.toggle()
                                    }) {
                                        Text(reminder.plantName)
                                            .font(.title)
                                            .tint(.white)
                                    }
                                }
                                
                                HStack {
                                    HStack {
                                        Image(systemName: "sun.max")
                                            .foregroundColor(Color(red: 204/255, green: 199/255, blue: 133/255))
                                        Text("\(reminder.selectedLight.rawValue)")
                                            .foregroundColor(Color(red: 204/255, green: 199/255, blue: 133/255))
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 3)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                    .frame(maxWidth: 109)
                                    
                                    HStack {
                                        Image(systemName: "drop")
                                            .foregroundColor(Color(red: 202/255, green: 243/255, blue: 251/255))
                                        Text("\(reminder.selectedWaterAmount.rawValue)")
                                            .foregroundColor(Color(red: 202/255, green: 243/255, blue: 251/255))
                                    }
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 3)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                    .frame(maxWidth: 113)
                                }
                            }
                        }
                        .padding()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color(red: 40/255, green: 224/255, blue: 168/255))
                            .font(.system(size: 25))
                        
                        NavigationLink(destination: EditPlant(viewModel: viewModel)) {
                            Text("New Reminder")
                                .font(.title3)
                                .foregroundColor(Color(red: 40/255, green: 224/255, blue: 168/255))
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                Spacer()
            }
            .padding()
            .onAppear {
                viewModel.loadPlants(context: context)
            }
            .sheet(item: $selectedReminder) { reminder in
                EditReminder(viewModel: viewModel, reminder: reminder)
            }
        }
    }
}


#Preview {
    StartApp()
}

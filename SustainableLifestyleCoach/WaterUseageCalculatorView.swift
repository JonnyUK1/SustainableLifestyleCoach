//
//  WaterUseageCalculatorView.swift
//  SustainableLifestyleCoach
//
//  Created by Jonny Walker on 18/01/2024.
//

import SwiftUI

struct WaterUseageCalculatorView: View {
    
    @State private var householdMembers: Double = 1.0
    @State private var showerPerWeek: Double = 0.0
    @State private var washingMachinePerWeek: Double = 0.0
    @State private var dishwasherPerWeek: Double = 0.0
    
    @State private var calculatedTotalWaterUseage: String = ""
    @State private var calculatedTotalWaterUsagePerPerson: String = ""
    
    
    var body: some View {
        VStack {
            // Creating a Form for the users to interact
            Form {
                Section(header: Text("Household Members")) {
                    Slider(value: $householdMembers, in: 1...8)
                    Text("\(householdMembers, specifier: "%.0f")")
                }
                Section(header: Text("Showers/Baths per Week")) {
                    Slider(value: $showerPerWeek, in: 0...60)
                    Text("\(showerPerWeek, specifier: "%.0f")")
                }
                Section(header: Text("Washing Machine Usage per Week")) {
                    Slider(value: $washingMachinePerWeek, in: 0...15)
                    Text("\(washingMachinePerWeek, specifier: "%.0f")")
                }
                Section(header: Text("Dishwasher Usage per Week")) {
                    Slider(value: $dishwasherPerWeek, in: 0...15)
                    Text("\(dishwasherPerWeek, specifier: "%.0f")")
                }
                Section {
                    Button(action: calculateWaterUsage) {
                        Text("Calculate")
                    }
                }
                
                // Print out the results of total water useage per year and per person per day
                if !calculatedTotalWaterUseage.isEmpty {
                    Text("Total Water Usage (Annually): " + calculatedTotalWaterUseage)
                        .foregroundColor(.green)
                        .font(.headline)
                        .padding(.bottom, 20) // Add some bottom padding
                    
                    Text("Total Water Per Person Per Day: " + calculatedTotalWaterUsagePerPerson)
                        .foregroundColor(.green)
                        .font(.headline)
                        .padding(.bottom, 20) // Add some bottom padding
                }
            }
        }
    }
    func calculateWaterUsage() {
        
        // All of the below values are based upon an averag
        let waterPerWashingMachineCycle: Double = 50.0
        //This is based upon a 10 minute shower
        let waterPerShower: Double = 150
        //This is based upon the average bath
        //let waterPerBath: Double = 80
        let waterPerDishwasherCycle: Double = 7.5
        
        //Calculating the total water useage
        let totalWaterUseage = (showerPerWeek * waterPerShower +
                                washingMachinePerWeek * waterPerWashingMachineCycle +
                                dishwasherPerWeek * waterPerDishwasherCycle) * householdMembers
        
        //Calculating the water useage per person
        let waterPerPersonPerDay = totalWaterUseage / (householdMembers * 7)
        
        
        calculatedTotalWaterUseage = String(format: "%.2f liters ", totalWaterUseage)
        calculatedTotalWaterUsagePerPerson = String(format: "%.2f liters ", waterPerPersonPerDay)
    }
}

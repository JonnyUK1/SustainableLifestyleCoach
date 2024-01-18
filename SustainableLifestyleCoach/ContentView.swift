// ContentView.swift
// SustainableLifestyleCoach
//
// Created by Jonny Walker on 16/01/2024.
// ContentView.swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Main Text of Homepage
                Text("Welcome to Your Sustainable Lifestyle")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 20)
                    .foregroundColor(.primary)

                // Description of the App
                Text("Empowering you to live a more sustainable life with tips, product recommendations .................")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .foregroundColor(.secondary)

                // Horizontal ScrollView for Buttons
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        NavigationLink(destination: CarbonFootprintView()) {
                            Text("Carbon Footprint\nTracker")
                                .foregroundColor(.white)
                                .font(.system(size: 16)) // Adjust font size
                                .frame(width: 135, height: 160) // Set fixed size
                                .background(Color.green.opacity(0.7)) // Light gray background
                                .cornerRadius(15)
                                .multilineTextAlignment(.center) // Center align the text
                        }

                        NavigationLink(destination: EcoFriendlyProducts()) {
                            Text("Product\nRecommendations")
                                .foregroundColor(.white)
                                .font(.system(size: 16)) // Adjust font size
                                .frame(width: 135, height: 160) // Set fixed size
                                .background(Color.green.opacity(0.7)) // Light gray background
                                .cornerRadius(15)
                                .multilineTextAlignment(.center) // Center align the text
                        }

                        NavigationLink(destination: GreenLivingTips()) {
                            Text("Green Living\nTips")
                                .foregroundColor(.white)
                                .font(.system(size: 16)) // Adjust font size
                                .frame(width: 135, height: 160) // Set fixed size
                                .background(Color.green.opacity(0.7)) // Light gray background
                                .cornerRadius(15)
                                .multilineTextAlignment(.center) // Center align the text
                        }
                    }
                    .padding()
                }

                Spacer()
            }
            // Top navigation title
            .navigationBarTitle("EcoLife Coach", displayMode: .inline)
            .navigationBarItems(trailing: Image(systemName: "leaf.fill").font(.title).foregroundColor(.green)) // Add a leaf icon to the navigation bar
            .background(Color(UIColor.systemBackground))
        }
    }
}

struct CarbonFootprintView: View {
    @State private var selectedTransportationType: CarbonFootprintCalculatorView.TransportationType = .electric
    @State private var mileage = ""
    @State private var electricityUsage = ""
    @State private var naturalGasUsage = ""
    @State private var wasteGenerated = ""

    var body: some View {
        VStack {
            Text("Carbon Footprint Calculator")
                .font(.title)
                .padding()

            CarbonFootprintCalculatorView(selectedTransportationType: $selectedTransportationType,
                                           mileage: $mileage,
                                           electricityUsage: $electricityUsage,
                                           naturalGasUsage: $naturalGasUsage,
                                           wasteGenerated: $wasteGenerated)
        }
        .navigationBarTitle("Your Carbon Footprint", displayMode: .inline)
    }
}

// Clicking button will bring the user to a page to get eco-friendly product recommendations
struct EcoFriendlyProducts: View {
    var body: some View {
        Text("Eco-Friendly Product Recommendations")
            .padding()
            .navigationBarTitle("Product Recommendations", displayMode: .inline)
    }
}

// Clicking button will bring the user to a page with tips for green living
struct GreenLivingTips: View {
    var body: some View {
        Text("Tips for Green Living")
            .padding()
            .navigationBarTitle("Green Living Tips", displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

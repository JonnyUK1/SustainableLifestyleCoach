//  ContentView.swift
//  SustainableLifestyleCoach
//
//  Created by Jonny Walker on 16/01/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                //This is a container that provides navigation interface for all of the content inside it
                NavigationView {
                    // This means Vertical stack so that the container stacks the child views vertically
                    VStack {
                        // Main app text for the home page with styling
                        Text("Welcome to Your Sustainable Lifestyle")
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 20)
                            .foregroundColor(.primary)
                        
                        // Headline text for the homepage with styling
                        Text("Empowering you to live a more sustainable life")
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                            .foregroundColor(.secondary)
                        
                        // This means horizontal stack so that the buttons are stacked horizontally
                        HStack(spacing: 20) {
                            // Navigation links are used for the buttons to bring the user to the correct destination when the button is clicked
                            NavigationLink(destination: CarbonFootprintView()) {
                                ButtonCardView(title: "Carbon Footprint Tracker", imageName: "leaf.fill")
                            }
                            NavigationLink(destination: WaterUseageTracker()) {
                                ButtonCardView(title: "Water Usage Tracker", imageName: "drop.fill")
                            }
                        }
                        .padding()
                        
                        HStack(spacing: 20) {
                            NavigationLink(destination: EcoFriendlyProducts()) {
                                ButtonCardView(title: "Product Recommendations", imageName: "cart.fill")
                            }
                            NavigationLink(destination: GreenLivingTips()) {
                                ButtonCardView(title: "Green Living Tips", imageName: "leaf.arrow.triangle.circlepath")
                            }
                        }
                        .padding()
                        
                        Spacer()
                    }
                    // The text that will be at the very top of the app in the navigation bar
                    .navigationBarTitle("EcoLife Coach", displayMode: .inline)
                    .background(Color(UIColor.systemBackground))
                    .navigationBarItems(trailing:
                                            HStack {
                        NavigationLink(destination: profileView()) {
                            Image(systemName: "person.circle")
                                .font(.system(size: 24))
                                .foregroundColor(.primary)
                                .padding()
                        }
                    })
                }
            } else {
                LoginView()
            }
        }
    }
}

//Custom Swift UI View that constates of an image using 'systemName' and a text level
struct ButtonCardView: View {
    var title: String
    var imageName: String
    
    var body: some View {
        VStack {
            //The formatting for the images on the buttons
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .foregroundColor(.white)
                .padding(15)
            //The Formating for the text on the buttons
            Text(title)
                .font(.system(size: 14, weight: .semibold, design: .rounded)) // Adjusted font size and style
                .multilineTextAlignment(.center)
                .foregroundColor(.white) // Set text color
                .padding(.horizontal, 10) // Adjusted padding
                .lineLimit(2) // Limit the number of lines for better appearance
                .shadow(color: Color.black.opacity(0.3), radius: 1, x: 0, y: 1) // Add a subtle shadow
        }
        //The formatting for the buttons background colour etc
        .frame(width: 160, height: 180) // Adjusted size
        .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
        .opacity(0.9)
        .scaleEffect(1.0)
    }
}

struct CarbonFootprintView: View {
    
    //State is usedd as a property wrapper so that the framework can manage the state of a value
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
            
            //This takes several @binding properties as paramaters, and allows carbonFoorprintView to pass its state to the view. Allows for two way communication between the views
            CarbonFootprintCalculatorView(selectedTransportationType: $selectedTransportationType,
                                          mileage: $mileage,
                                          electricityUsage: $electricityUsage,
                                          naturalGasUsage: $naturalGasUsage,
                                          wasteGenerated: $wasteGenerated)
        }
        .navigationBarTitle("Your Carbon Footprint", displayMode: .inline)
    }
}

struct WaterUseageTracker: View {
    var body: some View {
        VStack {
            
            Text("Water Useage Calculator")
                .font(.title)
                .padding()
            
            WaterUseageCalculatorView()
                .navigationBarTitle("Water Useage Tracker", displayMode: .inline)
            
        }
        
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
            .environmentObject(AuthViewModel())
    }
}

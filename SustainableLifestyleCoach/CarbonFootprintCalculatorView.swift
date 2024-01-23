import SwiftUI
import SwiftUICharts

struct CarbonFootprintCalculatorView: View {
    enum TransportationType: Int, CaseIterable {
        //Defining the cases for different transportaion types.
        case electric, hybrid, diesel, petrol, bus, train, bicycle, walk
        
        // Defines a computed property 'label' for each case. Returns a human readable label
        var label: String {
            switch self {
            case .electric: return "Electric Car"
            case .hybrid: return "Hybrid Car"
            case .diesel: return "Diesel Car"
            case .petrol: return "Petrol Car"
            case .bus: return "Bus"
            case .train: return "Train"
            case .bicycle: return "Bicycle"
            case .walk: return "Walk"
            }
        }
        //Defining the emissionFactor for each case
        var emissionFactor: Double {
            switch self {
            case .electric: return 0.0 // Assuming electric cars have zero emissions
            case .hybrid: return 0.5
            case .diesel: return 2.0
            case .petrol: return 2.0
            case .bus: return 0.5
            case .train: return 0.1
            case .bicycle, .walk: return 0.0
            }
        }
    }
    
    //Binding is used as they are used to pass data between views or components, Bound to external source of trith allwing the changes made in other parts of the application to be reflected in the view
    @Binding var selectedTransportationType: TransportationType
    @Binding var mileage: String
    @Binding var electricityUsage: String
    @Binding var naturalGasUsage: String
    @Binding var wasteGenerated: String
    
    //State is used to store the intersal stare of the view. They are private as they are not meant to be accessed from outside of the view.
    // These states will hold the calculated results
    @State private var calculatedResult: String = ""
    @State private var transportationEmission: Double = 0.0
    @State private var electricityEmission: Double = 0.0
    @State private var wasteEmission: Double = 0.0
    
    @State private var updateChart = false // State variable to trigger chart update
    
    var body: some View {
        VStack {
            //Form is used to group related controles and provide a visual for the grouping of the controles
            Form {
                Section(header: Text("Transportation")) {
                    Picker("Select Transportation", selection: $selectedTransportationType) {
                        //For loop that loop to go through the different transportation types in the enum
                        //id:\.self: How SwiftUI wiill identify each element in the loop
                        //type in: Closure to define the contented for each iteration of the loop. It takes an individial type from the transportationType.allCases array.
                        ForEach(TransportationType.allCases, id: \.self) { type in
                            //Create a text view displaying the label associated with that transportation type
                            //.tag: associated a tag with each 'text' view using the 'type' itself. These are used to uniquely identify elements when working with 'picker'
                            Text(type.label).tag(type)
                        }
                    }
                    // This is used for a dropdown list
                    .pickerStyle(MenuPickerStyle())
                    
                    TextField("Mileage", text: $mileage)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Energy Usage")) {
                    TextField("Electricity Usage (kWh)", text: $electricityUsage)
                        .keyboardType(.numberPad)
                    
                    TextField("Natural Gas Usage (Therms)", text: $naturalGasUsage)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Waste")) {
                    TextField("Waste Generated (lbs)", text: $wasteGenerated)
                        .keyboardType(.numberPad)
                }
                
                Section {
                    Button(action: calculateCarbonFootprint) {
                        Text("Calculate")
                    }
                }
            }
            
            if !calculatedResult.isEmpty {
                VStack {
                    // Extracted chart view for better organization
                    CarbonFootprintChartView(transportationEmission: $transportationEmission,
                                             electricityEmission: $electricityEmission,
                                             wasteEmission: $wasteEmission,
                                             updateChart: $updateChart)
                    
                    Text("Total Carbon Footprint " + calculatedResult)
                        .foregroundColor(.green)
                        .font(.footnote)
                        .padding(.bottom, 20) // Add some bottom padding
                    
                }
            }
        }
    }
    
    struct CarbonFootprintChartView: View {
        @Binding var transportationEmission: Double
        @Binding var electricityEmission: Double
        @Binding var wasteEmission: Double
        @Binding var updateChart: Bool
        
        var body: some View {
            BarChartView(data: ChartData(values: [
                ("Transportation", transportationEmission),
                ("Electricity", electricityEmission),
                ("Waste", wasteEmission),
            ]), title: "Emissions Breakdown", legend: "kg CO2", form: ChartForm.extraLarge)
            .padding()
            .id(updateChart)
            .background(Color(UIColor.systemBackground)) // Set background color to match Form
        }
    }
    
    
    func calculateCarbonFootprint() {
        // Conversion factors
        let milesToKilometersConversionFactor = 1.60934
        let poundsToKilogramsConversionFactor = 0.453592
        
        // Convert user inputs
        guard let mileageValue = Double(mileage),
              let electricityUsageValue = Double(electricityUsage),
              let _ = Double(naturalGasUsage), // Use underscore to indicate it's intentionally unused
              let wasteGeneratedValue = Double(wasteGenerated) else {
            print("Invalid input values")
            return
        }
        
        // Convert mileage to kilometers
        let mileageInKilometers = mileageValue * milesToKilometersConversionFactor
        
        // Calculate transportation emissions
        transportationEmission = mileageInKilometers * selectedTransportationType.emissionFactor
        
        // Calculate electricity emissions
        electricityEmission = electricityUsageValue * 0.4
        
        // Calculate waste emissions
        let wasteInKilograms = wasteGeneratedValue * poundsToKilogramsConversionFactor
        wasteEmission = wasteInKilograms * 0.25
        
        // Sum up the emissions
        let totalEmission = transportationEmission + electricityEmission + wasteEmission
        
        // Update the calculatedResult
        calculatedResult = String(format: "%.2f kg CO2", totalEmission)
        
        updateChart.toggle()
    }
}

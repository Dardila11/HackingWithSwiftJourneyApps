//
//  ContentView.swift
//  UnitConversion
//
//  Created by Daniel Ardila on 9/10/23.
//

import SwiftUI

enum Temperature : String, CaseIterable, Identifiable {
    
    case fahrenheit
    case celsius
    case kelvin
    
    var id: String { self.rawValue }
}

struct ContentView: View {
    
    @State var tempInput : Temperature = .fahrenheit
    @State var tempOutput : Temperature = .fahrenheit
    @State var tempValue = ""
    
    /// function to standarize any temperature to celsius
    /// - Parameters:
    ///   - temp: Input temperature Value
    ///   - input: Input temperature Type
    /// - Returns: temperature in Celsius
    func convertToCelsius(temp: Double, input: Temperature) -> Double {
        var value = temp
        switch input {
        case .fahrenheit:
            value = (temp - 32) / 1.8
            break
        case .kelvin:
            value = temp - 273.15
            break
        default:
            value = temp
        }
        return value
    }
    
    /// Converts celsius temperature to desired value
    /// - Parameters:
    ///   - tempInCelsius: temperature in celsius
    ///   - output: desired temperature
    /// - Returns: temperature of desired type
    func convertToTemperature(tempInCelsius: Double, output: Temperature) -> Double {
        var value = tempInCelsius
        switch output {
        case .fahrenheit:
            value = (tempInCelsius * 1.8) + 32
            break
        case .kelvin:
            value = tempInCelsius + 273.15
            break
        default:
            value = tempInCelsius
        }
        return value
    }
    
    var result : Double {
        let value = Double(tempValue) ?? 0
        let tempInCelsius =  convertToCelsius(temp: value, input: tempInput)
        
        return convertToTemperature(tempInCelsius: tempInCelsius, output: tempOutput)

    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Temperature Input", selection: $tempInput) {
                        ForEach(Temperature.allCases) { temp in
                            Text(temp.rawValue).tag(temp)
                           
                        }
                    }
                    Picker("Temperature Input", selection: $tempOutput) {
                        ForEach(Temperature.allCases) { temp in
                            Text(temp.rawValue).tag(temp)
                           
                        }
                    }
                    
                } header: {
                    Text("Choose Temperature Conversion")
                        .bold()
                }
                
                Section {
                    TextField("Temperature", text:$tempValue )
                    
                } header: {
                    Text("temperature input")
                }
                
                Section {
                    Text("\(result.formatted())")
                } header: {
                    Text("temperature output")
                }
                
                
            }
            .navigationTitle("Unit Conversion")
            
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

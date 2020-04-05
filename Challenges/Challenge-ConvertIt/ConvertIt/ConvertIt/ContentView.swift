//
//  ContentView.swift
//  ConvertIt
//
//  Created by Mikhail Medvedev on 12.10.2019.
//  Copyright © 2019 Mikhail Medvedev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var valueForConverting = ""
    @State private var unitForConverting = 0
    @State private var convertedUnit = 2
    
    let unitNames = ["mm", "cm", "m", "km", "yd", "ft", "mi"]
      let units: Array<UnitLength> = [.millimeters, .centimeters, .meters, .kilometers, .yards, .feet, .miles]
    
    var convertedValue: Double {
        let value = Double(valueForConverting) ?? 0
        let unit = Measurement(value: value, unit: units[unitForConverting])
        let unitToConvert = units[convertedUnit]
        let converted = unit.converted(to: unitToConvert)
        
        return converted.value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Value")) {
                    TextField("0", text: $valueForConverting).keyboardType(.decimalPad).onTapGesture {
                        //dismiss keyboard on tap
                        UIApplication.shared.windows[0].endEditing(true)
                    }
                    Picker("Unit", selection: $unitForConverting) {
                        ForEach(0..<unitNames.count) {
                            Text("\(self.unitNames[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("To")) {
                    Picker("Unit", selection: $convertedUnit) {
                        ForEach(0..<unitNames.count) {
                            Text("\(self.unitNames[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    Text(convertedValue == 0 ? "0" : "\(convertedValue, specifier: "%.5f")")
                }
            }
            .navigationBarTitle("Convert It!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

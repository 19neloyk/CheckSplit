//
//  ContentView.swift
//  AddictionCounter
//
//  Created by Brown Jawn on 5/22/20.
//  Copyright © 2020 Brown Jawn. All rights reserved.
//

import SwiftUI
import Foundation


struct ContentView: View {
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }

    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    @State private var dateOfMatters = Date()
    let tipPercentages = [0,10,15,20,25]
    
    let today = Date()
    let dayInFuture = Calendar.current.date(byAdding: .day, value: 30, to: Date())!
    
    var personalContribution: Double {
        let numPeopleFinal = Double(numberOfPeople + 2)
        let tipActualFinal = Double(tipPercentages[tipPercentage])
        let costOfOrder = Double(checkAmount) ?? 0 // If checkamount is not a valid double, then 0 is used for the total cost of the order instead
        
        let personalCost = (costOfOrder * (1 + (0.01 * tipActualFinal)))/numPeopleFinal
        return personalCost
        return 0
    }
    
    var body: some View {
            NavigationView{
                Form{
                    Section{
                        DatePicker("What is/was the date?", selection: $dateOfMatters, in: ...today,displayedComponents: .date)
                        }
                    Section(header: Text("Pricing Information").font(.headline)){
                        TextField("How much money are we talking?",text: $checkAmount)
                        .keyboardType(.decimalPad)
                        Text("How much tip?")
                        Picker("Tip Percentage", selection: $tipPercentage) {
                            ForEach(0 ..< 5) {
                                Text("\(self.tipPercentages[$0]) %")
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    Section(header: Text("How many people are involved?").font(.headline)){
                        Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2 ..< 10) {
                                Text("\($0) people")
                            }
                        }
                    }
                    Section{
                        Text("The contribution from each person should be...")
                        Text("$\(personalContribution,specifier: "%.2f")").font(.largeTitle).multilineTextAlignment(.center)
                    }
                    
                }
                .navigationBarTitle("Check Split")
            }
        }
    }
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

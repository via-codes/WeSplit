//
//  ContentView.swift
//  WeSplit
//
//  Created by Alivia Fairchild on 2/4/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = ViewModel()
    var totalPerPerson: Double {

        let peopleCount = Double(vm.numberOfPeople + 2)
        let tipSelection = Double(vm.tipPercentage)
        
        let tipValue = vm.checkAmount / 100 * tipSelection
        let grandTotal = vm.checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var grandTotal: Double {
        let tipSelection = Double(vm.tipPercentage)
        
        let tipValue = vm.checkAmount / 100 * tipSelection
        let grandTotal = vm.checkAmount + tipValue
        
        return grandTotal
        
    }
    
    
    var body: some View {
            NavigationView{
            Form {
                AmountSection(vm: vm)
                
                TipSection(vm: vm)
                
                Section (header: Text("Bill Total Including Tip")) {
                    
                    Text(grandTotal, format: .currency(code: "USD"))
                    
                }
                
                Section (header: Text("Amount Per Person")) {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }

            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                      //  amountIsFocused = false
                    }
                }
            }
            }
        }
    }
}


struct AmountSection: View {
    @StateObject var vm = ViewModel()
    var body: some View {
        TextField("Amount", value: $vm.checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
            .keyboardType(.decimalPad)
        //      .focused($amountIsFocused)
        
        Picker("Number of people", selection: $vm.numberOfPeople) {
            ForEach(2..<100) {
                Text("\($0) people")
            }
        }
    }
}

struct TipSection: View {
    @StateObject var vm = ViewModel()
    let tipPercentages = [10, 15, 20, 25, 0]
    var body: some View {
        Section{
            Picker("Tip percentage", selection: $vm.tipPercentage){
                ForEach(tipPercentages, id: \.self) {
                    Text($0, format: .percent)
                    }
                }
            .pickerStyle(.segmented)
        } header: {
            Text("How much tip do you want to leave?")
        }
    }
}


class ViewModel: ObservableObject {
    @Published var tipPercentage: Int = 20
    @Published var numberOfPeople: Int = 2
    @Published var checkAmount: Double = 0.0
}














struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


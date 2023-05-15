//
//  ContentView.swift
//  AppStorage01
//
//  Created by R. Kukuh on 12/05/23.
//

import SwiftUI

struct CurrencyView: View {
    
    @AppStorage("currencyStorage") var currencyStorage: Data = Data()
    @State private var currencies: [Currency] = [Currency]()
    
    @State private var newCurrencyCode: String = ""
    @State private var newCurrencyName: String = ""
    
    @State private var showEditCurrency: Bool = false
    @State private var choosenCurrency = Currency.emptyCurrency
    
    var body: some View {
        NavigationStack {
            VStack {
                List(currencies) { currency in
                    HStack {
                        Text(currency.code.uppercased())
                            .frame(width: 40)
                        Text(currency.name)
                        
                        Spacer()
                        
                        Button {
                            showEditCurrency = true
                            choosenCurrency = currency
                        } label: {
                            Label("", systemImage: "square.and.pencil")
                        }
                    }
                }
                
                VStack {
                    TextField("New currency code", text: $newCurrencyCode)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("New currency name", text: $newCurrencyName)
                        .textFieldStyle(.roundedBorder)
                    
                    Button {
                        addNewCurrency(code: newCurrencyCode, name: newCurrencyName)
                        
                        newCurrencyCode = ""
                        newCurrencyName = ""
                    } label: {
                        Text("Add New")
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Spacer()
                }
                .padding()
                
            } //: VStack
            .navigationTitle("Currencies")
            .onAppear {
                initData()
                
                guard let decodedSavedCurrencies = try? JSONDecoder().decode([Currency].self, from: currencyStorage) else {
                    return
                }
                
                currencies = decodedSavedCurrencies
            }
            .sheet(isPresented: $showEditCurrency) {
                EditCurrencyView(currency: $choosenCurrency)
            }
        } //: NavigationStack
    }
    
    func initData() {
        let currencies = [
            Currency(code: "idr", name: "Indonesian Rupiah"),
            Currency(code: "usd", name: "US Dollar"),
            Currency(code: "jpy", name: "Japan Yen")
        ]
        
        guard let encodedCurrencies = try? JSONEncoder().encode(currencies) else {
            return
        }
        
        self.currencyStorage = encodedCurrencies
    }
    
    func addNewCurrency(code: String, name: String) {
        let newCurrency = Currency(code: code, name: name)
        
        currencies.append(newCurrency)
        
        guard let encodedCurrencies = try? JSONEncoder().encode(currencyStorage) else { return }
        
        self.currencyStorage = encodedCurrencies
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyView()
    }
}

//
//  EditCurrency.swift
//  AppStorage01
//
//  Created by R. Kukuh on 12/05/23.
//

import SwiftUI

struct EditCurrencyView: View {
    
    @Binding var currency: Currency
    
    var body: some View {
        VStack {
            TextField("Edit currency code", text: $currency.code)
                .textFieldStyle(.roundedBorder)
            
            TextField("Edit currency name", text: $currency.name)
                .textFieldStyle(.roundedBorder)
            
            Button {
                //
            } label: {
                Text("Update")
            }
        }
        .padding()
    }
}

struct EditCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        EditCurrencyView(currency: .constant(Currency(code: "test", name: "TEST")))
    }
}

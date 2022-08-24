//
//  NasaDetailView.swift
//  NasaImComb
//
//  Created by CHRISTIAN BEYNIS on 8/23/22.
//

import SwiftUI

struct NasaDetailView<T: NasaViewModelType>: View {
    @ObservedObject var vm: T
    let index: Int
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            NasaImageView(vm: self.vm, index: index)
            Text(self.vm.models[index].explanation)
                .padding()
            Spacer()
            Button("Back") {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
            .navigationBarBackButtonHidden(true)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NasaDetailView(vm: NasaViewModel(), index: 0)
    }
}


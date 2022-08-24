//
//  ContentView.swift
//  NasaImComb
//
//  Created by CHRISTIAN BEYNIS on 8/22/22.
//

import SwiftUI

struct ContentView<T: NasaViewModel>: View {

    @State var str: String = ""
    @ObservedObject var vm: T
    

    var body: some View {
        VStack {

            Text("Nasa Images")
                .padding()

                List {
                    ForEach(0..<self.vm.models.count, id: \.self) { index in
                        NavigationLink(destination: NasaDetailView(vm: self.vm, index: index)) {
                            NasaImageView(vm: self.vm, index: index)
                                .onAppear {
                                    self.vm.loadNasaPics()
                                }
                        }
                    }
                }
            }
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(vm: NasaViewModel())

    }
}

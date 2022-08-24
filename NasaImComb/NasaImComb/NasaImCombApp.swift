//
//  NasaImCombApp.swift
//  NasaImComb
//
//  Created by CHRISTIAN BEYNIS on 8/22/22.
//

import SwiftUI

@main
struct NasaImCombApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(vm: NasaViewModel())
            
        }
    }
}

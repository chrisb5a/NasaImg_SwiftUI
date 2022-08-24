//
//  NasaImageView.swift
//  NasaImComb
//
//  Created by CHRISTIAN BEYNIS on 8/22/22.
//

import SwiftUI
//
//struct NasaImageView: View {
//    @ObservedObject var vm: NasaViewModel
//    let index: Int
//    @State var hdurl: String
//
//    init(vm: NasaViewModel, index: Int = 0) {
//        self.vm = vm
//
//
//
//        self.hdurl = vm.models[index].hdurl ?? "VidAv"
//        self.index = index
//
//    }
//
//    var body: some View {
//
//            VStack {
//                HStack {
//                    Image("VidAv")
//                    //Image(vm.models[index].hdurl ?? "VidAv")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 150, height: 150, alignment: .leading)
//                        .padding()
//                    VStack {
//
//                        Text(vm.models[index].explanation)
//                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
////
//                        Spacer()
//                    }
//                }
//                .frame(minHeight: 150, idealHeight: 150, maxHeight: 200, alignment: .center)
//            }
//        }
//
//
//
//
//}
//
//struct NasaView_Previews: PreviewProvider {
//    static var previews: some View {
//        NasaImageView(vm: NasaViewModel(), index: 0)
//            .previewLayout(.sizeThatFits)
//    }
//}


struct NasaImageView<T:NasaViewModelType>: View {
    
    @ObservedObject var vm: T
    let index: Int
    
    var body: some View {
        HStack {
            AsyncImage(url: NetworkParams.NasaImage(path: self.vm.models[index].url ?? "VidAv" ).url) { realImage in
                realImage
                    .resizable()
                    .frame(width: 150, height: 200, alignment: .center)
            } placeholder: {
                ProgressView()
                    .frame(width: 150, height: 200, alignment: .center)
            }
                .padding([.top, .bottom, .trailing], 8)
            Text(vm.models[index].title)
                .padding([.top, .bottom, .trailing], 8)
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 0))
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
       // AlbumView(albumListVM: AlbumListViewModel(), index: 0)
        NasaImageView(vm: NasaViewModel(), index: 0)
    }
}

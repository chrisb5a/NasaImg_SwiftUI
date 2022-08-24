//
//  NasaViewModel.swift
//  NasaImComb
//
//  Created by CHRISTIAN BEYNIS on 8/22/22.
//

import Foundation
import Combine


protocol NasaViewModelType: ObservableObject {
    var models: MyModel { get }
    //var isLoading: Bool { get }
    func loadNasaPics()
}

class NasaViewModel: NasaViewModelType {
    
    private let networkService: NetworkService
    private var currentPage = 0
    //@Published
    
    var subs = Set<AnyCancellable>()
    var date = [["2022-01-01", "2022-03-01"], ["2022-03-02", "2022-06-01"], ["2022-06-02", "2022-08-22"]]
    let imageCache = ImageCache()
    @Published var rowRequested = 0
    @Published var models: MyModel = []
    
    init(network: NetworkService = NetworkManager()) {
        self.networkService = network
        self.loadNasaPics()
    }
    
    func loadNasaPics() {
        self.networkService.getModel(url: NetworkParams.NasaList(start_date:date[self.currentPage][0] , end_date:date[self.currentPage][1] ).url)
            .sink { completion in
                print(completion)
            } receiveValue: { (page: MyModel) in
                //self.models.append(page)
                self.models.append(contentsOf: page)
                if self.currentPage < 2 {
                    self.currentPage = self.currentPage + 1}
                print(self.models[0].title)
            }.store(in: &self.subs)
    }
    
    func requestImageData(for row: Int) -> Data? {
        guard let path = self.models[row].url else { return nil }
        if let data = self.imageCache.get(url: path) {
            return data
        }
        
        self.networkService.getRawData(url: NetworkParams.NasaImage(path: path).url)
            .sink { completion in
                print(completion)
                print("ok")
            } receiveValue: { data in
                self.imageCache.set(data: data, url: path)
                self.rowRequested = row
            }.store(in: &self.subs)

        return nil
    }
    
    
    
    
    
    
    
    
    
    
//    private var imageArr: [String] = ["BlueEyes", "DarkMagician", "Sample"]
//    @Published var models: [MyModel] = [MyModel(NasaImgName: "Peter", description: "Spot", imageName: "BlueEyes"),
//                                        MyModel(NasaImgName: "Cleopatra", description: "Reign", imageName: "DarkMagician"),
//                                        MyModel(NasaImgName: "Charmaigne", description: "Dante", imageName: "Sample")]
//    @Published var selectedModel: MyModel = MyModel(NasaImgName: "Peter", description: "Spot", imageName: "BlueEyes")
//    
//    func createNewModel(with str: String) {
//        models.append(MyModel(NasaImgName: str, description: "kjasbdjasbdjasb", imageName: imageArr.randomElement() ?? ""))
//    }
//    
//    func updateModelName(str: String, index: Int) {
//        guard index < self.models.count else { return }
//        self.models[index].NasaImgName = str
//    }
//    
//    func updateSelectedModel(with index: Int) {
//        guard index < self.models.count else { return }
//        self.selectedModel = self.models[index]
//    }
//    
    
}




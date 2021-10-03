//
//  HomeViewModel.swift
//  InfoCorona
//
//  Created by Sendo Tjiam on 11/09/21.
//

import Foundation

// MARK: - API MODEL
/*
 [
    IndonesiaDataApiModel --> name, positif, sembuh, meninggal, dirawat
 ]
 
 --> [IndonesiaDataApiModel]
 */
struct IndonesiaDataApiModel : Codable{
    let name : String
    let positif : String
    let sembuh : String
    let meninggal : String
    let dirawat : String
}

struct ProvinceDataApiModel : Codable {
    let attributes : ProvinceDataDetail
}

struct ProvinceDataDetail : Codable {
    let FID : Int
    let Kode_Provi : Int
    let Provinsi : String
    let Kasus_Posi : Int
    let Kasus_Semb : Int
    let Kasus_Meni : Int
}

// MARK: - HOME VIEW MODEL
protocol HomeViewModelDelegate {
    func didUpdateIndonesiaOVRData(_ viewModel : HomeViewModel, _ data : IndonesiaDataModel)
    func didUpdateIndonesiaProvinceData(_ viewModel : HomeViewModel, _ data : [ProvinceDataModel])
    func didFailWithError(_ error : Error)
}

struct HomeViewModel {
    let BASE_URL = "https://api.kawalcorona.com"
    
    var delegate : HomeViewModelDelegate?
    
    func fetchIndonesiaOVRData() {
        let indonesiaUrl = "\(BASE_URL)/indonesia/"
        if let url = URL(string: indonesiaUrl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, res, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let safeData = data {
                    if let parsedData = parseJSON(safeData, returnType: IndonesiaDataModel.self) {
                        self.delegate?.didUpdateIndonesiaOVRData(self, parsedData)
                    }
                }
            }
            task.resume()
        }
    }
    
    func fetchIndonesiaProvinceData() {
        let indonesiaUrl = "\(BASE_URL)/indonesia/provinsi/"
        if let url = URL(string: indonesiaUrl) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, res, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let safeData = data {
                    if let parsedData = parseJSON(safeData, returnType: [ProvinceDataModel].self) {
                        self.delegate?.didUpdateIndonesiaProvinceData(self, parsedData)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON<T>(_ data : Data, returnType: T.Type) -> T? {
        let decoder = JSONDecoder()
        do {
            if returnType == IndonesiaDataModel.self {
                let decodedData = try decoder.decode([IndonesiaDataApiModel].self, from: data)
                let dataValue = IndonesiaDataModel(name: decodedData[0].name, positif: decodedData[0].positif, sembuh: decodedData[0].sembuh, meninggal: decodedData[0].meninggal, dirawat: decodedData[0].dirawat) as! T
                return dataValue
            } else if returnType == [ProvinceDataModel].self {
                let decodedData = try decoder.decode([ProvinceDataApiModel].self, from: data)
                var dataValue : [ProvinceDataModel] = []
                for item in decodedData {
                    let attributes = item.attributes
                    let province = ProvinceDataModel(
                        fid: attributes.FID,
                        kodeProvinsi: attributes.Kode_Provi,
                        provinsi: attributes.Provinsi,
                        kasusPositif: attributes.Kasus_Posi,
                        kasusSembuh: attributes.Kasus_Semb,
                        kasusMeninggal: attributes.Kasus_Meni
                    )
                    dataValue.append(province)
                }
                return dataValue as? T
            }
        } catch {
            print(error)
            return nil
        }
        return nil
    }
}

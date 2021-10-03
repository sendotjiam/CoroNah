//
//  ViewController.swift
//  InfoCorona
//
//  Created by Sendo Tjiam on 11/09/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var positiveLabel: UILabel!
    @IBOutlet weak var treatedLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    @IBOutlet weak var mainCard: UIView!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var virusIcon: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var homeViewModel = HomeViewModel()
    var provinceData : [ProvinceDataModel] = []
    
    @IBOutlet weak var height: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        homeViewModel.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(with: ProvinceCell.self)
        homeViewModel.fetchIndonesiaOVRData()
        homeViewModel.fetchIndonesiaProvinceData()
        
    }
    
    func setupUI() {
        loadingSpinner.backgroundColor = UIColor.systemGray3
        loadingSpinner.makeRoundedCorner(radius: 8)
        loadingSpinner.startAnimating()

        virusIcon.animateRotate()

        mainCard.makeRoundedCorner(radius: 8)
        mainCard.dropShadow()
    }
    
}

// MARK: - HomeViewController with PROTOCOLS
extension HomeViewController: HomeViewModelDelegate {
    func didUpdateIndonesiaProvinceData(_ viewModel: HomeViewModel, _ data: [ProvinceDataModel]) {
        DispatchQueue.main.async {
            self.provinceData = data
            self.tableView.reloadData()
            self.height.constant = CGFloat(Double(data.count) * 136)
        }
    }
    
    func didUpdateIndonesiaOVRData(_ viewModel: HomeViewModel, _ data: IndonesiaDataModel) {
        DispatchQueue.main.async {
            self.positiveLabel.text = data.positif
            self.treatedLabel.text = data.dirawat
            self.recoveredLabel.text = data.sembuh
            self.deathLabel.text = data.meninggal
            self.loadingSpinner.stopAnimating()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provinceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: ProvinceCell.self)
        cell?.provinceName.text = provinceData[indexPath.row].provinsi
        cell?.positiveCase.text = String(provinceData[indexPath.row].kasusPositif)
        cell?.recoveredCase.text = String(provinceData[indexPath.row].kasusSembuh)
        cell?.deathCase.text = String(provinceData[indexPath.row].kasusMeninggal)
        return cell!
    }
    
    
}

//
//  MatchDetailsVC.swift
//  GameOn
//
//  Created by mac on 19/05/23.
//

import UIKit
import Alamofire

class MatchDetailsVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var matchesList: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var matchDetailData : [MatchDetailModel]? = []

    override func viewDidLoad() {
        super.viewDidLoad()

        matchesList.delegate = self
        matchesList.dataSource = self
        matchesList.isHidden = true
        
        DispatchQueue.global().async {
            self.callApi(from: "https://demo.sportz.io/nzin01312019187360.json")
            self.callApi(from: "https://demo.sportz.io/sapk01222019186652.json")
        }
        
    }
    
    //Mark: -API Call
    func callApi(from url: String) {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        AF.request(url, method: .get).responseDecodable(of: MatchDetailModel.self) {response in
            if let data = response.value{
                //self.matchDetailData = data
                self.matchDetailData?.append(data)
            }else{
                self.showAlert(title: "Error", message: "Something went wrong, Please try again later.")
            }
            
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.matchesList.reloadData()
            self.matchesList.isHidden = false
        }
        
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    //Mark:- Table view Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return matchDetailData?.count ?? 0
        return matchDetailData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchDetailsCell", for: indexPath) as! MatchDetailsCell
        
        cell.backView.layer.cornerRadius = 10.0
        cell.backView.layer.shadowColor = UIColor.lightGray.cgColor
        cell.backView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.backView.layer.shadowRadius = 5.0
        cell.backView.layer.shadowOpacity = 1.0
        cell.backView.layer.masksToBounds = false
        
        var data : MatchDetailModel?
        if matchDetailData?.count ?? 0 > 0{
            data = matchDetailData?[indexPath.row]
        }

        if matchDetailData?.count ?? 0 > 0 {
            let stausString = data?.matchdetail?.series?.status?.suffix(3)
            cell.WinnerPoints.text = "\(String(stausString!.prefix(1)))" + " : " + "\(String(stausString!.suffix(1)))"
        }
        if indexPath.row == 0 {
            cell.teamA.text = data?.teams?["4"]?.nameShort
            cell.teamB.text = data?.teams?["5"]?.nameShort
        }else{
            cell.teamA.text = data?.teams?["6"]?.nameShort
            cell.teamB.text = data?.teams?["7"]?.nameShort
        }


        cell.date.text = "Date: " + "\(data?.matchdetail?.match?.date ?? "")"
        cell.time.text = "Time: " + "\(data?.matchdetail?.match?.time ?? "")"
        cell.currentMatch.text = data?.matchdetail?.match?.number
        cell.vanue.text = data?.matchdetail?.venue?.name
        cell.matchStatus.text = "Match status: " + "\(data?.matchdetail?.status ?? "")"
        cell.result.text = data?.matchdetail?.result
        cell.OverallStatus.text = data?.matchdetail?.series?.status

        if ((data?.matchdetail?.match?.livecoverage) != nil) == true{
            cell.liveCoverage.text = "LIVE"
        }else{
            cell.liveCoverage.text = "LIVE:NO"
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchDetailsCell", for: indexPath) as! MatchDetailsCell
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let playerListVC = storyBoard.instantiateViewController(withIdentifier: "PlayersListVC") as! PlayersListVC
        playerListVC.playersData = matchDetailData?[indexPath.row]
        self.navigationController?.pushViewController(playerListVC, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

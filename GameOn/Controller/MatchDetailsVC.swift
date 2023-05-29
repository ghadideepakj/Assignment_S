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
    
    var matchDetailData : Matchdetail?
    var playingteam : [String: Team]?

    override func viewDidLoad() {
        super.viewDidLoad()

        matchesList.delegate = self
        matchesList.dataSource = self
        CallApi()
    }
    
    //Mark: -API Call
    func CallApi() {
        AF.request("https://demo.sportz.io/nzin01312019187360.json", method: .get).responseDecodable(of: MatchDetailModel.self) {response in
            debugPrint(response)
            if let data = response.value{
                self.matchDetailData = data.matchdetail
                self.playingteam = data.teams
            }
            
            self.matchesList.reloadData()
        }
    }
    
    //Mark:- Table view Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchDetailsCell", for: indexPath) as! MatchDetailsCell
        
        if(matchDetailData != nil){
            let stausString = matchDetailData?.series?.status?.suffix(3)
            cell.WinnerPoints.text = String(stausString!.prefix(1))
            cell.losersPoints.text = String(stausString!.suffix(1))
        }
        
        cell.teamA.text = playingteam?["4"]?.nameShort
        cell.teamB.text = playingteam?["5"]?.nameShort
        cell.date.text = "Date: " + "\(matchDetailData?.match?.date ?? "")"
        cell.time.text = "Time: " + "\(matchDetailData?.match?.time ?? "")"
        cell.currentMatch.text = matchDetailData?.match?.number
        cell.vanue.text = matchDetailData?.venue?.name
        cell.matchStatus.text = "Match status: " + "\(matchDetailData?.status ?? "")"
        cell.result.text = matchDetailData?.result
        cell.OverallStatus.text = matchDetailData?.series?.status
        
        return cell
        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt
//                   indexPath: IndexPath) {
//
//    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//
//  PlayersListVC.swift
//  GameOn
//
//  Created by mac on 27/05/23.
//

import UIKit

class PlayersListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var playersList: UITableView!
    
    var playersData : MatchDetailModel?
    
    @IBOutlet weak var inningStackView: UIStackView!
    
    
    var firstInning : Inning?
    var secondInning : Inning?
    var showFilter = false
    var totalPlayers : [InningBatsman]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playersList.delegate = self
        playersList.dataSource = self
        
        inningStackView.layer.borderWidth = 1.0
        inningStackView.layer.borderColor = UIColor.black.cgColor
        
        firstInning = playersData?.innings?.first
        secondInning = playersData?.innings?.last
        
        inningStackView.isHidden = true
        
        firstLoadData()
    }
    
    func firstLoadData() {
        let firstInningBats = firstInning?.batsmen
        let firstInningBowls = firstInning?.bowlers
        totalPlayers = firstInningBats
        playersList.reloadData()
        inningStackView.isHidden = true
    }
    
    @IBAction func filterButtonTapped(_ sender: UIButton) {
        
        showFilter.toggle()
        if showFilter{
            inningStackView.isHidden = false
        }else{
            inningStackView.isHidden = true
        }
        
    }
    
    
    @IBAction func firstInningSelected(_ sender: UIButton) {
        
        let firstInningBats = firstInning?.batsmen
        let firstInningBowls = firstInning?.bowlers
        totalPlayers = firstInningBats
        playersList.reloadData()
        inningStackView.isHidden = true
//        if firstInningBats != nil, firstInningBowls != nil{
//            totalPlayers.append(contentsOf: firstInningBats!)
//            totalPlayers.append(contentsOf: firstInningBowls!)
//        }
    }
    
    @IBAction func secondInningSelected(_ sender: UIButton) {
        let secondInningBats = secondInning?.batsmen
        let secondInningBowls = secondInning?.bowlers
        totalPlayers = secondInningBats
        playersList.reloadData()
        inningStackView.isHidden = true
//        if secondInningBats != nil, secondInningBowls != nil{
//            totalPlayers.append(contentsOf: secondInningBats!)
//            totalPlayers.append(contentsOf: secondInningBats!)
//        }
        
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    //MARK:- Table view methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalPlayers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playersListCell", for: indexPath) as! playersListCell
//        var data : InningBatsman?
//        data = totalPlayers?[indexPath.row]
        cell.mainLabel.text = totalPlayers?[indexPath.row].batsman
        return cell
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var data = totalPlayers![indexPath.row]
        var message = "Runs: " + (data.runs ?? "") + "\n" + "Fours: " +  (data.fours ?? "") + "\n" + "Sixes: " + (data.sixes ?? "") +  "\n" + "Balls: " + (data.balls ?? "")
        //String(format: "Runs: " , (data.runs ?? "") , "\n" , "Fours: ", (data.fours ?? ""), "\n" , "Sixes: " , (data.sixes ?? ""), "\n", "Balls: ", (data.balls ?? ""))
        tableView.deselectRow(at: indexPath, animated: true)
        showAlert(title: "\(data.batsman ?? "")", message: message)
        
    }
    
}

class playersListCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    
}

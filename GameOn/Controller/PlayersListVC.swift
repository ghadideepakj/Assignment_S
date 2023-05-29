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
    var selectedString = ""
    var showFilter = false
//    var totalPlayers = [ : ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        playersList.delegate = self
        playersList.dataSource = self
        
        firstInning = playersData?.innings?.first
        secondInning = playersData?.innings?.last
        
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
        selectedString = "firstInning"
        var firstInningBats = firstInning?.batsmen
        var firstInningBowls = firstInning?.bowlers
//        if firstInningBats != nil, firstInningBowls != nil{
//            totalPlayers = firstInningBats? + firstInningBowls?
//        }
//        totalPlayers = firstInningBats?.append(contentsOf: firstInningBowls)
        
        
    }
    
    @IBAction func secondInningSelected(_ sender: UIButton) {
        selectedString = "SecondInning"
        
    }
    
    
    
    //MARK:- Table view methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playersListCell", for: indexPath) as! playersListCell
        
        return cell
    }
    
}

class playersListCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    
}

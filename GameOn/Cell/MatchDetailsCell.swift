//
//  MatchDetailsCell.swift
//  GameOn
//
//  Created by mac on 19/05/23.
//

import UIKit

class MatchDetailsCell: UITableViewCell {
    
    @IBOutlet weak var WinnerPoints: UILabel!
    @IBOutlet weak var losersPoints: UILabel!
    @IBOutlet weak var teamA: UILabel!
    @IBOutlet weak var teamB: UILabel!
    
    @IBOutlet weak var currentMatch: UILabel!
    @IBOutlet weak var liveCoverage: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var vanue: UILabel!
    @IBOutlet weak var matchStatus: UILabel!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var OverallStatus: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

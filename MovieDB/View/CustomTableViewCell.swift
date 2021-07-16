//
//  CustomTableViewCell.swift
//  MovieDB
//
//  Created by Joe Leung on 7/16/21.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with viewModel:ViewModel?, on rowNumber: Int) {
        guard let viewModel = viewModel else {
            return
        }
        self.textLabel!.text = viewModel.modelData[rowNumber].0
    }
}

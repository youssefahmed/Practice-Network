//
//  RepositoryCell.swift
//  Github Project
//
//  Created by youssef on 14/11/2022.
//

import UIKit

class RepositoryCell: UITableViewCell {

    @IBOutlet weak var repositoryNameLabel: UILabel!
   

    func configareCell (with repository : Repository){
        repositoryNameLabel.text = repository.name
    }
    
}

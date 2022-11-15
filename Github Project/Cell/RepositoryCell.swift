//
//  RepositoryCell.swift
//  Github Project
//
//  Created by youssef on 14/11/2022.
//

import UIKit

class RepositoryCell: UITableViewCell {

    @IBOutlet weak var repositoryNameLabel: UILabel!
   
    @IBOutlet weak var repositoryImage: UIImageView!
    
    func configareCell (with repository : Repository){
        repositoryNameLabel.text = repository.name
        guard let image = repository.owner?.avatar_url else {return}
        repositoryImage.Load(urlString: image)
       
        
    }
    
}

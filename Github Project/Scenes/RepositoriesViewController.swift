//
//  RepositoriesViewController.swift
//  Github Project
//
//  Created by youssef on 14/11/2022.
//

import UIKit


protocol RepositorieyView : AnyObject{
    
    func repositorieyTableView()
}

class RepositoriesViewController: UIViewController {
    
    @IBOutlet weak var repositoriesTableView: UITableView!
    
    private var  presenter :  RepositoriesPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = RepositoriesPresenter(self)
        presenter.getRepository()
        setupUi()
        self.title = "Home"
    }
    
    func setupUi(){
        repositoriesTableView.dataSource = self
        repositoriesTableView.delegate = self
        repositoriesTableView.register(UINib(nibName: String(describing:RepositoryCell.self), bundle: nil), forCellReuseIdentifier: String(describing:RepositoryCell.self))
    }
}
    
    
    
    
    extension RepositoriesViewController : UITableViewDataSource , UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            presenter.repositoriesCount()
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            guard let cell =
                    repositoriesTableView.dequeueReusableCell(withIdentifier: String(describing:RepositoryCell.self),for: indexPath) as? RepositoryCell
            else{return UITableViewCell()}
            
            cell.configareCell(with: presenter.getUsedrepositoriey(at: indexPath.row))
            
            return cell
            
        }
        
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            presenter.wellDisplayrepositoriey(at: indexPath.row)
        }
        
    }

extension RepositoriesViewController: RepositorieyView {
    func repositorieyTableView() {
        DispatchQueue.main.async { [weak self] in
            
            self?.repositoriesTableView.reloadData()
        }
    }
    
    
}



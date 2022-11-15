//
//  RepositoriesViewController.swift
//  Github Project
//
//  Created by youssef on 14/11/2022.
//

import UIKit

class RepositoriesViewController: UIViewController {

    @IBOutlet weak var repositoriesTableView: UITableView!
    var repository : [Repository] = []
    var numberOfPage = 10
    var limit = 10
    var paginationRepository : [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRepository()
        setupUi()
    }
    
    func setupUi(){
        repositoriesTableView.register(UINib(nibName: String(describing:RepositoryCell.self), bundle: nil), forCellReuseIdentifier: String(describing:RepositoryCell.self))
    }
    
    func getRepository() {
        APIService.sharedServeice.getRespository { (respositories : [Repository]?, erorr) in
            guard let respositories = respositories else{
                return
            }
            self.repository = respositories
            self.limit = self.repository.count
            for i in 0 ..< 10{
                self.paginationRepository.append(respositories[i])
            }

            DispatchQueue.main.async {
                self.repositoriesTableView.reloadData()
            }
        }
        
    }
    
    func setPagination(numberOfPage : Int){
        
        if numberOfPage >= limit {
            return
        }else if numberOfPage >= limit - 10 {
            for i in numberOfPage ..< limit{
                paginationRepository.append(repository[i])
            }
            self.numberOfPage += 10
        }else {
            for i in numberOfPage ..< numberOfPage + 10 {
                paginationRepository.append(repository[i])
            }
            self.numberOfPage += 10
        }
        DispatchQueue.main.async {
            self.repositoriesTableView.reloadData()
        }
    }
}

extension RepositoriesViewController : UITableViewDataSource , UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        paginationRepository.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell =
        repositoriesTableView.dequeueReusableCell(withIdentifier: String(describing:RepositoryCell.self),for: indexPath) as? RepositoryCell
       else{return UITableViewCell()}
          
        cell.configareCell(with: paginationRepository[indexPath.row])
        
        return cell
            
        }
        
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == repositoriesTableView {
            
            if (scrollView.contentOffset.y + scrollView.frame.size.height
                >= scrollView.contentSize.height){
                setPagination(numberOfPage: numberOfPage)
            }
        }
    }
    
}

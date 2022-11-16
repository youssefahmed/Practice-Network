//
//  RepositoriesPresenter.swift
//  Github Project
//
//  Created by youssef on 16/11/2022.
//

import Foundation

class RepositoriesPresenter {
    
    // Mark - var
    private weak var view: RepositorieyView?
    var repository : [Repository] = []
    
    // Mark Pagination
    var numberOfPage = 10
    var limit = 10
    var paginationRepository : [Repository] = []
    
    // Mark - init
    init(_ view : RepositorieyView) {
        self.view = view
    }
    
    //  Mark - Pubick Func
    
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
            
            DispatchQueue.main.async { [weak self] in
                self?.view?.repositorieyTableView()
            }
        }
        
    }
    
    func repositoriesCount () -> Int {
        return paginationRepository.count
    }
    
    func getUsedrepositoriey (at row: Int) -> Repository{
        return paginationRepository[row]
    }
    
    func wellDisplayrepositoriey(at row: Int){
        
        if row == paginationRepository.count - 1 {
            addNewrepositoriey()
        }
        
    }
    
}

//Mark - Private Func

extension RepositoriesPresenter {
    
    private func addNewrepositoriey(){
        
        
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
        DispatchQueue.main.async { [weak self] in
            self?.view?.repositorieyTableView()
        }
    }
}

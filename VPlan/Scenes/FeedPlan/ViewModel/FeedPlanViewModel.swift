//
//  FeedPlanViewModel.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 17/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import RxSwift
import RxCocoa

struct FeedPlanViewModel {
    var isOpen = true
    
    let plansSubject = PublishSubject<[Plan]>()
    
    let errorSubject = PublishSubject<Error>()
    
    let updatePlanSubject = PublishSubject<Void>()
    
    let firebaseFireStoreService: CreatableFirebaseFireStoreService
    
    init(firebaseFireStoreService: CreatableFirebaseFireStoreService) {
        self.firebaseFireStoreService = firebaseFireStoreService
    }
    
    func fetchPlans() {
        firebaseFireStoreService.fetchPlans { (result) in
            switch result {
            case .failure(let error):
                self.errorSubject.onNext(error)
            case .success(let plans):
                self.plansSubject.onNext(plans.filter { $0.isOpen == self.isOpen})
            }
        }
    }
    
    func updateStatus(status: Bool, uuid: String) {
        firebaseFireStoreService.updateStatePlan(isOpen: status, uuid: uuid, onSuccess: {
            self.updatePlanSubject.onNext(())
        }) { (error) in
            self.updatePlanSubject.onError(error)
        }
    }
}

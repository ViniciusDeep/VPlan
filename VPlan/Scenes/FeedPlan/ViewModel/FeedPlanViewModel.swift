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
    let plansSubject = PublishSubject<[Plan]>()
    
    let errorSubject = PublishSubject<Error>()
    
    let firebaseFireStoreService: CreatableFirebaseFireStoreService
    
    init(firebaseFireStoreService: CreatableFirebaseFireStoreService) {
        self.firebaseFireStoreService = firebaseFireStoreService
    }
    
    func fetchPlans(isOpen: Bool = true) {
        firebaseFireStoreService.fetchPlans { (result) in
            switch result {
            case .failure(let error):
                self.errorSubject.onNext(error)
            case .success(let plans):
                self.plansSubject.onNext(plans.filter { $0.isOpen == isOpen})
            }
        }
    }
}

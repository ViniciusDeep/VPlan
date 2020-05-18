//
//  CreatePlanViewModel.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 17/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import RxCocoa
import RxSwift

struct CreatePlanViewModel {
    
    let title = BehaviorRelay<String>(value: "")
    let description = BehaviorRelay<String>(value: "")
    let details = BehaviorRelay<String>(value: "")
    let firebaseFireStoreService: CreatableFirebaseFireStoreService
    var isValid: Observable<Bool>
    
    let errorCreatePlanSubject = PublishSubject<Error>()
    let successCreatePlanSubject = PublishSubject<Void>()
  
    func isChecked(title: Observable<String>, description: Observable<String>, details: Observable<String>) -> Observable<PlanField> {
        return Observable.combineLatest(self.title.asObservable(), self.description.asObservable(), self.details.asObservable()) { (title, description, details) in
            if title.count <= 3 {return .title}
            if description.count <= 5 {return .description}
            if details.count <= 5 {return .detail}
            return .none
        }
    }

    init(firebaseFireStoreService: CreatableFirebaseFireStoreService) {
        self.firebaseFireStoreService = firebaseFireStoreService
        isValid = Observable.combineLatest(self.title.asObservable(), self.description.asObservable(), self.details.asObservable()) { (title, description, details) in
        return title == ""
        && description == "" && details == ""
        }
    }
    
    func didCreatePlan() {
        firebaseFireStoreService.createPlan(plan: Plan(description: description.value, title: title.value, isOpen: true, details: details.value, uuid: UUID().uuidString), onSuccess: {
            self.successCreatePlanSubject.onNext(())
        }) { (error) in
            self.errorCreatePlanSubject.onNext(error )
        }
    }
}

enum PlanField {
    case title
    case description
    case detail
    case none
}

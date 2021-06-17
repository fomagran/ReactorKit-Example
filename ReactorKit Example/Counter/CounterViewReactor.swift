//
//  CounterViewReactor.swift
//  ReactorKit Example
//
//  Created by Fomagran on 2021/06/17.
//

import ReactorKit

class CounterViewReactor:Reactor {

    //유저에게 받은 액션
    enum Action {
        case plus
        case minus
    }
    
    //액션을 받은 어떠한 변화
    enum Mutation {
        case increaseValue
        case decreaseValue
        case setLoading(Bool)
    }
    
    //어떠한 변화를 받은 상태
    struct State {
        var number:Int
        var isLoading:Bool
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(number: 0, isLoading: false)
    }
    
    //액션에 맞게 변화해
    func mutate(action:Action) -> Observable<Mutation> {
        switch action {
        case .plus:
            return Observable.concat([
            Observable.just(Mutation.setLoading(true)),
            Observable.just(Mutation.increaseValue).delay(.milliseconds(500), scheduler: MainScheduler.instance),
            Observable.just(Mutation.setLoading(false))
            ])
        case .minus:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                Observable.just(Mutation.decreaseValue).delay(.milliseconds(500), scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(false))
            ])
        }
    }
    
    //변화에 맞게 값이 설정해
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .increaseValue:
            state.number += 1
        case .decreaseValue:
            state.number -= 1
        case let .setLoading(isLoading):
            state.isLoading = isLoading
        }
        return state
    }
}

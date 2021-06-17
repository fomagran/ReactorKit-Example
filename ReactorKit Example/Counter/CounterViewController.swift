//
//  ViewController.swift
//  ReactorKit Example
//
//  Created by Fomagran on 2021/06/17.
//

import UIKit
import ReactorKit
import RxCocoa

class CounterViewController: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    
    let disposeBag:DisposeBag = DisposeBag()
    let counterViewReactor:CounterViewReactor = CounterViewReactor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(reator: counterViewReactor)
    }
    
    func bind(reator:CounterViewReactor) {
        //+버튼과 reactor의 action을 바인딩
        plusButton.rx
            .tap
            .map{CounterViewReactor.Action.plus}
            .bind(to: reator.action)
            .disposed(by: disposeBag)
        
        //-버튼과 reactor의 action을 바인딩
        minusButton.rx
            .tap
            .map{CounterViewReactor.Action.minus}
            .bind(to: reator.action)
            .disposed(by: disposeBag)
        
        //reacotor의 value와 numberLabel을 바인딩
        reator.state
            .map {"\($0.number)"}
            .distinctUntilChanged()
            .bind(to: numberLabel.rx.text)
            .disposed(by: disposeBag)
        
        //reactor의 isLoading과 loadingIndicator를 애니메이션 할지 말지 바인딩
        reator.state
            .map{$0.isLoading}
            .distinctUntilChanged()
            .bind(to: loadingIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        //reactor의 isLoading과 loadingIndicator를 숨길지 말지 바인딩
        reator.state
            .map{!$0.isLoading}
            .distinctUntilChanged()
            .bind(to: loadingIndicator.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
}


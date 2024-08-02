//
//  MainViewController.swift
//  LottoRecommendApp
//
//  Created by JJW on 8/2/24.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa
import Networking

class MainViewController: UIViewController {
    private let beforeRoundLabel = UILabel().then {
        $0.text = "이번 회차 번호"
        $0.textColor = UIColor(resource: .text)
    }
    
    private let beforeRoundNumberLabel = UILabel().then {
        $0.textColor = UIColor(resource: .text)
    }
    
    private let recommendLabel = UILabel().then {
        $0.text = "추천 번호"
        $0.textColor = UIColor(resource: .text)
    }
    
    private let recommendNumberLabel = UILabel().then {
        $0.textColor = UIColor(resource: .text)
    }
    
    private let disposeBag = DisposeBag()
    
    private let requester = NetworkRequester()
    
    private let viewModel = MainViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupUI()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(resource: .BG)
        view.addSubview(beforeRoundLabel)
        view.addSubview(beforeRoundNumberLabel)
        view.addSubview(recommendLabel)
        view.addSubview(recommendNumberLabel)
        
        beforeRoundLabel.snp.makeConstraints {
            $0.top.equalTo(70)
            $0.centerX.equalToSuperview()
        }
        
        beforeRoundNumberLabel.snp.makeConstraints {
            $0.top.equalTo(beforeRoundLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        recommendLabel.snp.makeConstraints {
            $0.top.equalTo(beforeRoundNumberLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        recommendNumberLabel.snp.makeConstraints {
            $0.top.equalTo(recommendLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        beforeRoundLabel.text = "저번주 \(viewModel.beforeRound) 회차 번호"
        
    }
    
    private func bind() {
        viewModel.errorMessage
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] msg in
                self?.showAlert(msg: msg)
            })
            .disposed(by: disposeBag)
        
        viewModel.recommendNumbers
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] numbers in
                self?.recommendNumberLabel.text = numbers.joined(separator: ", ")
            })
            .disposed(by: disposeBag)
        
        viewModel.beforeNumbers
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] numbers in
                self?.beforeRoundNumberLabel.text = numbers.joined(separator: ", ")
            })
            .disposed(by: disposeBag)
    }
}

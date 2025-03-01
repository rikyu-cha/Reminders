//
//  DateViewController.swift
//  Reminders
//
//  Created by hwanghye on 7/4/24.
//

import UIKit
import SnapKit

protocol DatePickerViewControllerDelegate: AnyObject {
    func didSelectDate(_ date: Date)
}

class DateViewController: BaseViewController {
    
    weak var delegate: DatePickerViewControllerDelegate?
    let datePicker = UIDatePicker()
    let selectButton = UIButton()
    
    let viewModel = DateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    override func configureHierarchy() {
        view.addSubview(datePicker)
        view.addSubview(selectButton)
    }
    
    override func configureLayout() {
        datePicker.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        selectButton.snp.makeConstraints { make in
            make.top.equalTo(datePicker.snp.bottom).offset(20)
            make.centerX.equalTo(view)
        }
    }
    
    override func configureView() {
        super.configureView()
        view.backgroundColor = .backgroundGray
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .darkGray.withAlphaComponent(0.3)
        selectButton.setTitle("날짜 선택 완료", for: .normal)
        selectButton.setTitleColor(.systemBlue, for: .normal)
        selectButton.addTarget(self, action: #selector(selectButtonClicked), for: .touchUpInside)
    }
    
    private func setupBindings() {
        viewModel.selectedDate.bind { [weak self] date in
            self?.datePicker.date = date
        }
        
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }
    
    @objc func selectButtonClicked() {
        //        let selectedDate = datePicker.date
        //        delegate?.didSelectDate(selectedDate)
        delegate?.didSelectDate(viewModel.selectedDate.value)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func dateChanged() {
        viewModel.updateDate(datePicker.date)
    }
}

//
//  ListTableViewCell.swift
//  Reminders
//
//  Created by hwanghye on 7/3/24.
//

import UIKit
import SnapKit

class ListTableViewCell: BaseTableViewCell {
    static let id = "ListTableViewCell"
    
    var indexPath: IndexPath!
    
//    let checkBoxButton = UIButton()
    let photoImage = UIImageView()
    let titleLabel = UILabel()
    let memoLabel = UILabel()
    let dateLabel = UILabel()
    
    var deleteAction: (() -> Void)?
    
    override func configureLayout() {
//        checkBoxButton.snp.makeConstraints { make in
//            make.leading.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
//            make.width.equalTo(80)
//        }
        photoImage.snp.makeConstraints { make in
            make.leading.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.width.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.trailing.top.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(photoImage.snp.trailing).offset(8)
            make.height.equalTo(18)
        }
        
        memoLabel.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(photoImage.snp.trailing).offset(8)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(18)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(photoImage.snp.trailing).offset(8)
            make.top.equalTo(memoLabel.snp.bottom)
        }
    }
    
    override func configureHierarchy() {
        contentView.addSubview(photoImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(memoLabel)
        contentView.addSubview(dateLabel)
    }
    
    override func configureView() {
        memoLabel.numberOfLines = 0
//        setupCheckBoxButton()
        
        
    }
    
//    func setupCheckBoxButton() {
//        checkBoxButton.setImage(UIImage(systemName: "square"), for: .normal)
//        checkBoxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
//        
//        checkBoxButton.addTarget(self, action: #selector(checkBoxToggle), for: .touchUpInside)
//    }
    
//    @objc func checkBoxToggle() {
//        checkBoxButton.isSelected.toggle()
//        if checkBoxButton.isSelected {
//            print("CheckBox is checked.")
//        }
//    }
}

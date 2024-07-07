//
//  MainViewController.swift
//  Reminders
//
//  Created by hwanghye on 7/5/24.
//

import UIKit
import SnapKit

enum FilterType {
    case today
    case upcoming
    case all
    case flagged
    case completed
}

class MainViewController: BaseViewController {
    
    let titleLabel = UILabel()
    let addTodoButton = UIButton()
    let addListButton = UIButton()
    lazy var collectiocView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    let icons: [UIImage?] = [
        UIImage(systemName: "pencil.circle.fill"),
        UIImage(systemName: "calendar.circle.fill"),
        UIImage(systemName: "tray.circle.fill"),
        UIImage(systemName: "flag.circle.fill"),
        UIImage(systemName: "checkmark.circle.fill")
    ]
    
    let iconColors: [UIColor] = [
        .systemBlue,
        .systemRed,
        .systemGray,
        .systemYellow,
        .systemGray
    ]
    
    let statusTexts: [String] = [
        "오늘",
        "예정",
        "전체",
        "깃발 표시",
        "완료됨"
    ]
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 14
        let cellSpacing: CGFloat = 14
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - cellSpacing
        layout.itemSize = CGSize(width: width/2, height: width/4)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = cellSpacing
        layout.minimumLineSpacing = 14
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    override func configureHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(collectiocView)
        view.addSubview(addTodoButton)
        view.addSubview(addListButton)
        
        collectiocView.delegate = self
        collectiocView.dataSource = self
        collectiocView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.id)
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
        collectiocView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
        }
        addTodoButton.snp.makeConstraints { make in
            make.leading.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        addListButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(addTodoButton.snp.bottom)

        }
    }
    
    override func configureView() {        
        titleLabel.text = "전체"
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)
        titleLabel.textColor = .darkGray
        
        collectiocView.backgroundColor = .clear
        
        addTodoButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        addTodoButton.setTitle(" 새로운 할 일", for: .normal)
        addTodoButton.setTitleColor(.systemBlue, for: .normal)
        addTodoButton.addTarget(self, action: #selector(addTodoButtonClicked), for: .touchUpInside)
        
        addListButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        addListButton.setTitle(" 목록 추가", for: .normal)
        addListButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    @objc func addTodoButtonClicked() {
        let vc = AddViewController()
        let nav = UINavigationController(rootViewController: vc)
        //navigationController?.pushViewController(vc, animated: true)
        self.present(nav, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.id, for: indexPath) as! MainCollectionViewCell
        cell.cellIcon.image = icons[indexPath.item]
        cell.cellIcon.tintColor = iconColors[indexPath.item]
        cell.statusLabel.text = statusTexts[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ReminderListViewController()
        
        switch indexPath.item {
        case 0:
            print("오늘")
            vc.filterType = .today
        case 1:
            print("예정")
            vc.filterType = .upcoming
        case 2:
            print("전체")
            vc.filterType = .all
        case 3:
            print("깃발 표시")
            vc.filterType = .flagged
        case 4:
            print("완료됨")
            vc.filterType = .completed
        default:
            vc.filterType = .all
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

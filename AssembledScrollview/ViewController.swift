//
//  ViewController.swift
//  AssembledScrollview
//
//  Created by Tango on 2023/6/6.
//

import UIKit
import Anchorage

class ViewController: UIViewController {

    var assemblyScrollView: AssembledScrollview!
    var containerView = UIView(frame: .zero)
    var tableView = GeneralSectionTableView()
    var tagsView: GeneralTagsView = GeneralTagsView(GeneralTagsViewModel())
        
    func genenateBtn() -> UIButton {
        let button = UIButton()
        button.backgroundColor = .random
        button.addTarget(self, action: #selector(tapAction(_:)), for: .touchUpInside)
        return button
    }
    
    lazy var sectionViews = {
        var views = [UIView]()
        for i in 0..<20 {
            let view = UIView()
            view.backgroundColor = .random
            view.heightAnchor == 200
            view.widthAnchor == UIScreen.main.bounds.width
            let btn = genenateBtn()
            view.addSubview(btn)
            btn.edgeAnchors == view.edgeAnchors + 20
            views.append(view)
        }
        return views
    }()
    
    @objc
    private func tapAction(_ sender: UIButton) {
        print("tapAction")
    }
    
    lazy var testView: UILabel = {
        let view = UILabel(frame: .zero)
        view.backgroundColor = .random
        view.heightAnchor == 100
        view.text = "这是测试 view"
        return view
    }()
    
    lazy var testStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [testView, tagsView, tableView])
        sv.axis = .vertical
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViews()
        sectionViews.insert(testStackView, at: 0)
        tagsView.viewModel.input.updateStyle(["这是测试1", "这是测试1", "这是测试1", "这是测试1", "这是测试1", "这是测试1", "这是测试1", "这是测试1"])
        assemblyScrollView = AssembledScrollview(sectionViews: sectionViews)
        assemblyScrollView.backgroundColor = .systemPink
        configureLayout()
    }
    
    private func setupTableViews() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44
        tableView.isScrollEnabled = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func configureLayout() {
        view.addSubview(assemblyScrollView)
        assemblyScrollView.topAnchor == view.topAnchor + 64
        assemblyScrollView.horizontalAnchors == view.horizontalAnchors
        assemblyScrollView.bottomAnchor == view.bottomAnchor - 120
        
        let btn = genenateBtn()
        view.addSubview(btn)
        btn.heightAnchor == 100
        btn.topAnchor == assemblyScrollView.bottomAnchor
        btn.leadingAnchor == assemblyScrollView.leadingAnchor + 20
        btn.trailingAnchor == assemblyScrollView.trailingAnchor - 20
        btn.bottomAnchor == view.bottomAnchor - 44
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.backgroundColor = .random
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select: \(indexPath.row)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}


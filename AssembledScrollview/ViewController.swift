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
        
    lazy var sectionViews = {
        var views = [UIView]()
        for i in 0..<20 {
            let view = UIView()
            view.backgroundColor = .random
            view.heightAnchor == 200
            view.widthAnchor == UIScreen.main.bounds.width
            views.append(view)
        }
        return views
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupTableViews()
        sectionViews.insert(tagsView, at: 0)
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
        assemblyScrollView.bottomAnchor == view.bottomAnchor
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.backgroundColor = .random
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}


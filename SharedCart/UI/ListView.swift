//
//  ListView.swift
//  BuyDevider
//
//  Created by Jeytery on 16.03.2022.
//

import UIKit
import SnapKit

protocol ListViewDataSource: AnyObject {
    
    func listView(_ listView: ListView, numberOfRowsInSection section: Int) -> Int
    
    func listView(_ listView: ListView, cellForRowAt indexPath: IndexPath) -> UITableViewCell

    func numberOfSections(in listView: UITableView) -> Int
    
    func listView(_ listView: ListView, titleForHeaderInSection section: Int) -> String?

    func listView(_ listView: ListView, titleForFooterInSection section: Int) -> String?

    func listView(_ listView: ListView, canEditRowAt indexPath: IndexPath) -> Bool

    func listView(_ listView: ListView, canMoveRowAt indexPath: IndexPath) -> Bool

    func sectionIndexTitles(for tableView: UITableView) -> [String]?

    func listView(_ listView: ListView, sectionForSectionIndexTitle title: String, at index: Int) -> Int

    func listView(_ listView: ListView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    
    func listView(_ listView: ListView, cellInsetsforIndexPathAt: IndexPath) -> UIEdgeInsets
     
}

extension ListViewDataSource {
    
    func listView(_ listView: ListView, numberOfRowsInSection section: Int) -> Int { 0 }
    
    func listView(_ listView: ListView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { return UITableViewCell() }
    
    func numberOfSections(in listView: UITableView) -> Int { 0 }
    
    func listView(_ listView: ListView, titleForHeaderInSection section: Int) -> String? { nil }
 
    func listView(_ listView: ListView, titleForFooterInSection section: Int) -> String? { nil }

    func listView(_ listView: ListView, canEditRowAt indexPath: IndexPath) -> Bool { true }

    func listView(_ listView: ListView, canMoveRowAt indexPath: IndexPath) -> Bool { true }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? { nil }

    func listView(_ listView: ListView, sectionForSectionIndexTitle title: String, at index: Int) -> Int { 0}

    func listView(_ listView: ListView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {}
    
    func listView(_ listView: ListView, cellInsetsforIndexPathAt: IndexPath) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
}

class ListView: UITableView {
    
    private(set) var views: [UIView] = []

    weak var listDataSource: ListViewDataSource?
    
    init(
        views: [UIView],
        frame: CGRect = .zero
    ) {
        self.views = views
        super.init(frame: .zero, style: .grouped)
        separatorStyle = .none
        allowsSelection = false
        super.dataSource = self
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension ListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return 1
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = ListTableCell<UIView>(
            view: views[indexPath.section],
            edges: listDataSource?.listView(
                self,
                cellInsetsforIndexPathAt: indexPath
            ) ?? .init(top: 0, left: 0, bottom: 0, right: 0)
        )
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return views.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return listDataSource?.listView(self, titleForHeaderInSection: section)
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return listDataSource?.listView(self, titleForFooterInSection: section)
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return listDataSource?.listView(self, canEditRowAt: indexPath) ?? true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return listDataSource?.listView(self, canMoveRowAt: indexPath) ?? true
    }

    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return listDataSource?.sectionIndexTitles(for: tableView)
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return listDataSource?.listView(self, sectionForSectionIndexTitle: title, at: index) ?? 0
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        listDataSource?.listView(self, moveRowAt: sourceIndexPath, to: destinationIndexPath)
    }
}

fileprivate class ListTableCell<T: UIView>: UITableViewCell {
    
    var baseView: T!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView(T())
    }
    
    init(
        view: T,
        edges: UIEdgeInsets,
        style: UITableViewCell.CellStyle = .default,
        reuseIdentifier: String? = nil
    ) {
        print("TableCell.init")
        self.baseView = view
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView(baseView, edges: edges)
        backgroundColor = .clear
    }
    
    deinit {
        print("TableCell.deinit")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView(
        _ view: T,
        edges: UIEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
    ) {
        contentView.addSubview(baseView)
        
        view.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(edges.top)
            make.left.equalToSuperview().offset(edges.left)
            make.right.equalToSuperview().offset(-edges.right)
            make.bottom.equalToSuperview().offset(edges.bottom)
        }
    }
}

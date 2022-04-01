//
//  AddProductViewController.swift
//  SharedCart
//
//  Created by Jeytery on 20.03.2022.
//

import UIKit

protocol AddProductViewControllerDelegate: AnyObject {
    func addProductViewController(_ viewController: AddProductViewController, didCreate product: Product)
}

class AddProductViewController: UIViewController {
    
    weak var delegate: AddProductViewControllerDelegate?

    private var productPrice: Double {
        let price = Double(priceTextField.text ?? "0") ?? 0.0
        return stepper.value * price
    }
    
    // ui
    private var listView: ListView!
    private let nameTextField =  TextField(insests: .init(top: 0, left: 20, bottom: 0, right: 0))
    private let priceTextField = TextField(insests: .init(top: 0, left: 20, bottom: 0, right: 0))
    private let countView = UIView()
    private let confirmButton = Button()
    private let countLabel = UILabel()
    private let stepper = UIStepper()
    private let entitiesBoardView = EntitiesBoardView()
    
    // list setup
    private lazy var views: [UIView] = [
        nameTextField,
        priceTextField,
        StepperView(),
        entitiesBoardView,
        confirmButton
    ]
    private let headerTitle: [String?] = [
        "Enter data",
        nil,
        nil,
        "Whose product is?",
        nil
    ]
    
    init(product: Product? = nil, entities: Entities = []) {
        super.init(nibName: nil, bundle: nil)
       
        configureVC()
        
        configureList()
        configureStepper()
        configureConfirmButton()
        conigureEntitiesBoardView(entities)
        conifgurePriceTextField()
        
        configureNotification()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    deinit { NotificationCenter.default.removeObserver(self) }
}

//MARK: - ui
extension AddProductViewController {
    private func configureVC() {
        nameTextField.placeholder = "Enter name"
        priceTextField.placeholder = "Enter price"
        priceTextField.keyboardType = .numberPad
        title = "New Product"
    }
    
    private func conigureEntitiesBoardView(_ entities: Entities) {
        entitiesBoardView.didSelect = { index in
            self.entitiesBoardView.select(at: index)
            self.entitiesBoardView.setPriceForSelected(self.productPrice)
        }
        
        entitiesBoardView.add(entities: entities)
        entitiesBoardView.select(at: 0)
    }
    
    private func configureConfirmButton() {
        confirmButton.didTap = {
            [unowned self] in
            guard let entity = entitiesBoardView.selectedEntity else { return }
            let product = Product(
                name: nameTextField.text ?? "Unnamed product",
                price: productPrice,
                entityId: entity.id
            )
            delegate?.addProductViewController(self, didCreate: product)
        }
        
        confirmButton.setActiveStyle(icon: Icons.plus, title: "Add")
        confirmButton.backgroundColor = .clear
    }
    
    private func configureList() {
        listView = ListView(views: views, style: .insetGrouped)
        
        view.addSubview(listView)
        listView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        listView.listDataSource = self
        listView.delegate = self
        listView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func conifgurePriceTextField() {
        priceTextField.addTarget(self, action: #selector(priceTextFieldValueDidChanged), for: .editingChanged)
    }
    
    @objc func priceTextFieldValueDidChanged() {
        entitiesBoardView.setPriceForSelected(productPrice)
    }
}

//MARK: - stepper
extension AddProductViewController {
    private func StepperView() -> UIView {
        let _view = UIView()
        
        _view.addSubview(countLabel)
        
        countLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.center.equalToSuperview()
        }
        
        _view.addSubview(stepper)
        
        stepper.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-20)
            $0.width.equalTo(100)
        }
        
        countLabel.text = "Product count: 1"
        
        return _view
    }
    
    private func configureStepper() {
        stepper.addTarget(self, action: #selector(stepperValueDidChange), for: .valueChanged)
        stepper.maximumValue = 99
        stepper.minimumValue = 1
        stepper.value = 1
    }
    
    @objc func stepperValueDidChange() {
        countLabel.text = "Product count: \(Int(stepper.value))"
        entitiesBoardView.setPriceForSelected(productPrice)
    }
}

//MARK: - keyboard events
extension AddProductViewController {
    private func configureNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidHide),
            name: UIResponder.keyboardDidHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardDidHide() {
        listView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let constant = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        listView.contentInset = .init(top: 0, left: 0, bottom: constant, right: 0)
    }
}

//MARK: - [d] list
extension AddProductViewController: ListViewDataSource, UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        if indexPath.section == 3 { return 200 }
        return 65
    }
    
    func listView(
        _ listView: ListView,
        titleForHeaderInSection section: Int
    ) -> String? {
        return headerTitle[section]
    }
    
    func listView(
        _ listView: ListView,
        didCreate cell: UITableViewCell,
        at indexPath: IndexPath
    ) {
        if indexPath.section == 3 { cell.backgroundColor = .clear }
    }
    
    func tableView(
        _ tableView: UITableView,
        willDisplayHeaderView view: UIView,
        forSection section: Int
    ) {
        let headerView = view as? UITableViewHeaderFooterView
        headerView?.textLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
    }
}

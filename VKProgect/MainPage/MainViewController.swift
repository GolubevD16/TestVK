//
//  ViewController.swift
//  VKProgect
//
//  Created by Дмитрий Голубев on 14.07.2022.
//

import UIKit
import SafariServices

class MainViewController: UIViewController {
    
    lazy var viewModel: MainViewModel = {
        viewModel = MainViewModel()
        
        return viewModel
    }()
    
    private lazy var tableView: UITableView = {
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomCell.self, forCellReuseIdentifier: "MyTable")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        viewModel.send(.viewIsReady)
        setUp()
    }
    
    private func setUp(){
        overrideUserInterfaceStyle = .dark
        navigationController?.navigationBar.barTintColor = UIColor.black
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        title = "Сервисы VK"
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setupViewModel(){
        viewModel.onStateChanged = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loaded:
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .serviceTapped(let urlString):
                guard let url = URL(string: urlString) else { return }
                let svc = SFSafariViewController(url: url)
                svc.modalPresentationStyle = .currentContext
                self.present(svc, animated: true, completion: nil)
            default: break
            }
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTable", for: indexPath) as? CustomCell else { fatalError() }
        let service: Service = viewModel.services[indexPath.row]
        cell.title.text = service.name
        cell.text.text = service.description
        NetworkManager.shared.featchImageData(with: service.iconUrl) { data in
            DispatchQueue.main.async {
                cell.image.image = UIImage(data: data)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.send(.openService(indexPath.row))
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

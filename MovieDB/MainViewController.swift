//
//  MainViewController.swift
//  MovieDB
//
//  Created by Joe Leung on 7/14/21.
//

import UIKit

class MainViewController: UITableViewController  {
    var viewModel: ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=ec7d16a4fb316b89387b26b07998c8c0"
        self.viewModel = ViewModel(withURL: urlString, withView: self.tableView)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.modelData.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell
        guard let cell = cell else {
            return UITableViewCell()
        }
        
        cell.configure(with: viewModel, on: indexPath.row)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let nextViewController = mainStoryboard.instantiateViewController(withIdentifier: "detail") as? DetailViewController {
            self.present(nextViewController, animated: true, completion: nil)
            nextViewController.configure(with: viewModel, on: indexPath.row)
        }
    }
}

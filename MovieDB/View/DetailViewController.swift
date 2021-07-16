//
//  DetailViewController.swift
//  MovieDB
//
//  Created by Joe Leung on 7/16/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var thumbNail: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var popularity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func configure(with viewModel: ViewModel?, on rowNumber: Int) {
        self.movieTitle.text = "Title: \(viewModel?.modelData[rowNumber].1 ?? "Missing Title")"
        self.popularity.text = "Popularity: \(viewModel?.modelData[rowNumber].3 ?? 0.0)"
        self.thumbNail.load(url: URL(string: "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/" + (viewModel?.modelData[rowNumber].2!)!)!)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

//
//  OverlayViewController.swift
//  MovieSelector
//
//  Created by David Rothschild on 1/16/17.
//  Copyright © 2017 Dave Rothschild. All rights reserved.
//

import UIKit

class OverlayViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var movieItem:Movie!
    
    func configureView() {
        if let movie = self.movieItem {
            self.titleLabel.text = movie.title
            self.descriptionTextView.text = movie.description
        }
    }
    /*
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.view.bounds.size = CGSize(width: UIScreen.main.bounds.size.width - 20, height: 200)
        self.view.layer.cornerRadius = 5
        
    }
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureView()
        
    }
    
//    @IBAction func closedPressed(_ sender: Any) {
//        presentingViewController?.dismiss(animated: true, completion: nil)
//    }

    }

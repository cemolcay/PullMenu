//
//  ViewController.swift
//  PullMenu
//
//  Created by Cem Olcay on 29/12/14.
//  Copyright (c) 2014 Cem Olcay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.addPullMenu(["Menu", "Detail", "Promotions", "Favorites"])
        scrollView.contentSize = CGSize (width: view.w, height: view.h + 1.0)
        
        let appeareance = PullMenuAppearance (font: UIFont.Font(.Avenir, type: .Book, size: 15), selectedFont: UIFont.HelveticaNeue(.Thin, size: 20), textColor: UIColor.redColor(), selectedTextColor: UIColor.blueColor())
        
        scrollView.pullMenu?.appeareance = appeareance
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


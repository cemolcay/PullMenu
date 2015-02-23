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
    
    override func viewDidLayoutSubviews() {
        
        let items = ["Menu", "Detail", "Promotions", "Favorites"]
        
        scrollView.addPullMenu(items)
        
        let appeareance = PullMenuAppearance (
            font: UIFont.Font(.Avenir, type: .Book, size: 15),
            selectedFont: UIFont.Font(.Avenir, type: .Roman, size: 20),
            textColor: UIColor.redColor(),
            selectedTextColor: UIColor.blueColor())
        
        scrollView.pullMenu?.appeareance = appeareance
        
        scrollView.pullMenu?.itemSelectedAction = { selectedIndex in
            println("item selected at index \(selectedIndex)")
            self.title = items[selectedIndex]
        }
        
        addItems()
    }
    
    func addItems () {
        var contentH: CGFloat = 10
        for i in 0...20 {
            let lbl = UILabel (x: 10, y: contentH, w: UIScreen.ScreenWidth-20, h: 100)
            lbl.backgroundColor = UIColor.randomColor()
            lbl.text = "item \(i)"
            lbl.textAlignment = .Center
            
            contentH += lbl.h + 10
            scrollView.addSubview(lbl)
        }
        
        scrollView.contentSize = CGSize (width: scrollView.w, height: contentH)
    }
}
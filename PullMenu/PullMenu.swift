//
//  PullMenu.swift
//  PullMenu
//
//  Created by Cem Olcay on 29/12/14.
//  Copyright (c) 2014 Cem Olcay. All rights reserved.
//

import UIKit

private var PullMenuAssosiatedObject: UInt8 = 0

extension UIScrollView {

    var pullMenu: PullMenu? {
        get {
            return objc_getAssociatedObject(self, &PullMenuAssosiatedObject) as? PullMenu
        } set (value) {
            objc_setAssociatedObject(self, &PullMenuAssosiatedObject, value, UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
        }
    }
    
    func addPullMenu (items: [String]) {
        let height: CGFloat = 60
        
        self.pullMenu = PullMenu (frame: CGRect (x: 0, y: -height, width: self.w, height: height), items: items)
        self.pullMenu!.scrollView = self
        self.addSubview(self.pullMenu!)
    }
}


class PullMenuLabel: UILabel {
    
    var selected: Bool = false
    var animation: ((CGFloat)->())?
    
    var progress: CGFloat = 0 {
        didSet {
            progressAnimation(progress)
        }
    }
    
    func progressAnimation (progress: CGFloat) {
        let s = convertNormalizedValue(progress, 0.1, 1.2)
        
        self.alpha = s
        //self.setScale(s, y: s)
    }
}


struct PullMenuAppearance {
    var font: UIFont
    var selectedFont: UIFont
    
    var textColor: UIColor
    var selectedTextColor: UIColor
    
    var textAlignment: NSTextAlignment
    var selectedTextAlignment: NSTextAlignment
    
    init (font: UIFont, textColor: UIColor) {
        self.font = font
        self.selectedFont = font
        
        self.textColor = textColor
        self.selectedTextColor = textColor
        
        self.textAlignment = .Center
        self.selectedTextAlignment = .Center
    }
    
    init (font: UIFont, selectedFont: UIFont, textColor: UIColor, selectedTextColor: UIColor) {
        self.font = font
        self.selectedFont = selectedFont
        
        self.textColor = textColor
        self.selectedTextColor = selectedTextColor
        
        self.textAlignment = .Center
        self.selectedTextAlignment = .Center
    }
}

class PullMenu: UIView, UIScrollViewDelegate {

    
    // MARK: Properties
    
    var items: [PullMenuLabel] = [] {
        didSet {
            if let max = maxPullHeight {
                pullForEachItem = max/CGFloat(items.count)
            }
        }
    }
    
    var appeareance: PullMenuAppearance {
        didSet {
            for item in items {
                updateAppeareance(item)
            }
        }
    }
    
    var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
        }
    }
    
    
    
    // Label placement
    var lastX: CGFloat = 0
    var padX: CGFloat = 10
    
    
    // Pulling constants
    var pullStartOffset: CGFloat = 40
    
    var maxPullHeight: CGFloat?
    var pullForEachItem: CGFloat = 20
    
    
    
    // MARK: Lifecylce
    
    init (frame: CGRect, items: [String]) {
        appeareance = PullMenuAppearance (font: UIFont.systemFontOfSize(15), textColor: UIColor.blackColor())
        super.init(frame: frame)
        
        for item in items {
            addItem(item)
        }
    }

    required init(coder aDecoder: NSCoder) {
        appeareance = PullMenuAppearance (font: UIFont.systemFontOfSize(15), textColor: UIColor.blackColor())
        super.init(coder: aDecoder)
    }
    
    
    
    // MARK: Label
    
    func labelFromString (string: String) -> PullMenuLabel {
        let lbl = PullMenuLabel (frame: CGRect (x: lastX, y: 0, width: 10, height: h))
        lbl.text = string
        
        return lbl
    }
    
    func calculateLabelWidths () {
        
        var totalW: CGFloat = 0
        
        for item in items {
            totalW += item.w
        }
        
        let optimizedPad = (ScreenWidth - totalW) / CGFloat (items.count + 1)
        var currentX: CGFloat = optimizedPad
    
        
        for item in items {
            item.x = currentX
            currentX += item.w + optimizedPad
        }
    }

    
    func updateAppeareance (label: PullMenuLabel) {
        
        let font = label.selected ?
            appeareance.selectedFont:appeareance.font
        
        let textColor = label.selected ?
            appeareance.selectedTextColor:appeareance.textColor
        
        let align = label.selected ?
            appeareance.selectedTextAlignment:appeareance.textAlignment
        
        label.font = font
        label.textColor = textColor
        label.textAlignment = align
        
        label.sizeToFit()
        label.h = h
        
        calculateLabelWidths()
    }
    
    
    
    // MARK: Add
    
    func addItem (item: String) {
        let label = labelFromString(item)
        addSubview(label)
        
        self.items.append(label)
        updateAppeareance(label)
    }
    
    
    
    // MARK: Remove
    
    func removeItem (atIndex: Int) {
        
    }


    
    // MARK: UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let insetTop = scrollView.contentInset.top
        let offset = offsetY + insetTop + pullStartOffset

        if offset < 0 {

            let count = items.count
            let currentIndex = Int(-offset/pullForEachItem)
            
            if currentIndex >= items.count {
                return
            }
            
            for i in 0..<items.count {
                let item = items[i]
                if i == currentIndex {
                    let o: CGFloat = -offset
                    let p: CGFloat = pullForEachItem
                    let i: CGFloat = CGFloat (currentIndex)
                    let progress: CGFloat = (o-p*i)/p
                    
                    item.progress = progress
                    
                    if !item.selected {
                        item.selected = true
                        updateAppeareance(item)
                    }
                    
                } else {
                    item.progress = 0
                    
                    if item.selected {
                        item.selected = false
                        updateAppeareance(item)
                    }
                }
            }
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView,
        willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let insetTop = scrollView.contentInset.top
        let offset = offsetY + insetTop + pullStartOffset
        
        if offset < 0 {
            
            let count = items.count
            var currentIndex = Int(-offset/pullForEachItem)
            
            if currentIndex >= items.count {
                currentIndex = items.count-1
            }
            
            let currentItem = items[currentIndex]
            println(currentItem.text)
        }
    }
}

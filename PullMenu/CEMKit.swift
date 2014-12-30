//
//  CEMKit.swift
//  CEMKit-Swift
//
//  Created by Cem Olcay on 05/11/14.
//  Copyright (c) 2014 Cem Olcay. All rights reserved.
//

import Foundation
import UIKit

// MARK: - AppDelegate

let APPDELEGATE: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate



// MARK: - UIView

let UIViewAnimationDuration: NSTimeInterval = 1
let UIViewAnimationSpringDamping: CGFloat = 0.5
let UIViewAnimationSpringVelocity: CGFloat = 0.5

extension UIView {
    
    // MARK: Custom Initilizer
    
    convenience init (x: CGFloat,
        y: CGFloat,
        w: CGFloat,
        h: CGFloat) {
        self.init (frame: CGRect (x: x, y: y, width: w, height: h))
    }
    
    
    
    // MARK: Frame Extensions
    
    var x: CGFloat {
        get {
            return self.frame.origin.x
        } set (value) {
            self.frame = CGRect (x: value, y: self.y, width: self.w, height: self.h)
        }
    }
    
    var y: CGFloat {
        get {
            return self.frame.origin.y
        } set (value) {
            self.frame = CGRect (x: self.x, y: value, width: self.w, height: self.h)
        }
    }
    
    var w: CGFloat {
        get {
            return self.frame.size.width
        } set (value) {
            self.frame = CGRect (x: self.x, y: self.y, width: value, height: self.h)
        }
    }
    
    var h: CGFloat {
        get {
            return self.frame.size.height
        } set (value) {
            self.frame = CGRect (x: self.x, y: self.y, width: self.w, height: value)
        }
    }
    
    
    var position: CGPoint {
        get {
            return self.frame.origin
        } set (value) {
            self.frame = CGRect (origin: value, size: self.frame.size)
        }
    }
    
    var size: CGSize {
        get {
            return self.frame.size
        } set (value) {
            self.frame = CGRect (origin: self.frame.origin, size: size)
        }
    }
    
    
    var left: CGFloat {
        get {
            return self.x
        } set (value) {
            self.x = value
        }
    }
    
    var right: CGFloat {
        get {
            return self.x + self.w
        } set (value) {
            self.x = value - self.w
        }
    }
    
    var top: CGFloat {
        get {
            return self.y
        } set (value) {
            self.y = value
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.y + self.h
        } set (value) {
            self.y = value - self.h
        }
    }
    
    
    func leftWithOffset (offset: CGFloat) -> CGFloat {
        return self.left - offset
    }
    
    func rightWithOffset (offset: CGFloat) -> CGFloat {
        return self.right + offset
    }
    
    func topWithOffset (offset: CGFloat) -> CGFloat {
        return self.top - offset
    }
    
    func botttomWithOffset (offset: CGFloat) -> CGFloat {
        return self.bottom + offset
    }
    
    
    
    // MARK: Transform Extensions
    
    func setRotationX (x: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, degreesToRadians(x), 1.0, 0.0, 0.0)
        
        self.layer.transform = transform
    }
    
    func setRotationY (y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, degreesToRadians(y), 0.0, 1.0, 0.0)
        
        self.layer.transform = transform
    }
    
    func setRotationZ (z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, degreesToRadians(z), 0.0, 0.0, 1.0)
        
        self.layer.transform = transform
    }
    
    func setRotation (x: CGFloat,
        y: CGFloat,
        z: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DRotate(transform, degreesToRadians(x), 1.0, 0.0, 0.0)
        transform = CATransform3DRotate(transform, degreesToRadians(y), 0.0, 1.0, 0.0)
        transform = CATransform3DRotate(transform, degreesToRadians(z), 0.0, 0.0, 1.0)
        
        self.layer.transform = transform
    }
    
    
    func setScale (x: CGFloat, y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DScale(transform, x, y, 1)
        
        self.layer.transform = transform
    }
    
    
    // MARK: Anchor Extensions
    
    func setAnchorPosition (anchorPosition: AnchorPosition) {
        println(anchorPosition.rawValue)
        self.layer.anchorPoint = anchorPosition.rawValue
    }
    
    
    
    // MARK: Layer Extensions
    
    func addShadow (offset: CGSize,
        radius: CGFloat,
        color: UIColor,
        opacity: Float) {
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.CGColor
    }
    
    func addBorder (width: CGFloat,
        color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.CGColor
        self.layer.masksToBounds = true
    }
    
    
    func setCornerRadius (radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    
    func drawCircle (fillColor: UIColor,
        strokeColor: UIColor,
        strokeWidth: CGFloat) {
        let path = UIBezierPath (roundedRect: CGRect (x: 0, y: 0, width: self.w, height: self.w), cornerRadius: self.w/2)
        
        let shapeLayer = CAShapeLayer ()
        shapeLayer.path = path.CGPath
        shapeLayer.fillColor = fillColor.CGColor
        shapeLayer.strokeColor = strokeColor.CGColor
        shapeLayer.lineWidth = strokeWidth
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func drawStroke (width: CGFloat,
        color: UIColor) {
        let path = UIBezierPath (roundedRect: CGRect (x: 0, y: 0, width: self.w, height: self.w), cornerRadius: self.w/2)
        
        let shapeLayer = CAShapeLayer ()
        shapeLayer.path = path.CGPath
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = color.CGColor
        shapeLayer.lineWidth = width
        
        self.layer.addSublayer(shapeLayer)
    }
    
    func drawArc (from: CGFloat,
        to: CGFloat,
        clockwise: Bool,
        width: CGFloat,
        fillColor: UIColor,
        strokeColor: UIColor,
        lineCap: String) {
        let path = UIBezierPath (arcCenter: self.center, radius: self.w/2, startAngle: degreesToRadians(from), endAngle: degreesToRadians(to), clockwise: clockwise)
        
        let shapeLayer = CAShapeLayer ()
        shapeLayer.path = path.CGPath
        shapeLayer.fillColor = fillColor.CGColor
        shapeLayer.strokeColor = strokeColor.CGColor
        shapeLayer.lineWidth = width
        
        self.layer.addSublayer(shapeLayer)
    }
    


    // MARK: Animation Extensions
    
    func spring (animations: (()->Void)!,
        completion: ((Bool)->Void)? = nil) {
        UIView.animateWithDuration(UIViewAnimationDuration,
            delay: 0,
            usingSpringWithDamping: UIViewAnimationSpringDamping,
            initialSpringVelocity: UIViewAnimationSpringVelocity,
            options: UIViewAnimationOptions.AllowAnimatedContent,
            animations: animations,
            completion: completion)
    }

    func animate (animations: (()->Void)!,
        completion: ((Bool)->Void)? = nil) {
        UIView.animateWithDuration(UIViewAnimationDuration,
            animations: animations,
            completion: completion)
    }

    
    
    // MARK: Gesture Extensions
    
    func addTapGesture (tapNumber: NSInteger,
        target: AnyObject, action: Selector) {
        let tap = UITapGestureRecognizer (target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        self.addGestureRecognizer(tap)
    }
    
    func addSwipeGesture (direction: UISwipeGestureRecognizerDirection,
        numberOfTouches: Int,
        target: AnyObject,
        action: Selector) {
        let swipe = UISwipeGestureRecognizer (target: target, action: action)
        swipe.direction = direction
        swipe.numberOfTouchesRequired = numberOfTouches
        self.addGestureRecognizer(swipe)
    }
    
    func addPanGesture (target: AnyObject,
        action: Selector) {
        let pan = UIPanGestureRecognizer (target: target, action: action)
        self.addGestureRecognizer(pan)
    }
}



// MARK: - UIViewController

extension UIViewController {
    
    var top: CGFloat {
        get {
            if let nav = self.navigationController {
                if nav.navigationBarHidden {
                    return view.top
                } else {
                    return nav.navigationBar.bottom
                }
            } else {
                return view.top
            }
        }
    }
    
    var bottom: CGFloat {
        get {
            if let tab = tabBarController {
                if tab.tabBar.hidden {
                    return view.bottom
                } else {
                    return tab.tabBar.top
                }
            } else {
                return view.bottom
            }
        }
    }
    
    var navigationBarHeight: CGFloat {
        get {
            if let nav = self.navigationController {
                return nav.navigationBar.h
            }
            
            return 0
        }
    }
    
    var applicationFrame: CGRect {
        get {
            return CGRect (x: view.x, y: top, width: view.w, height: bottom - top)
        }
    }
}



// MARK: - UIFont

extension UIFont {
    
    enum FontType: String {
        case Regular = "Regular"
        case Bold = "Bold"
        case Light = "Light"
        case UltraLight = "UltraLight"
        case Italic = "Italic"
        case Thin = "Thin"
        case Book = "Book"
        case Roman = "Roman"
        case Medium = "Medium"
        case MediumItalic = "MediumItalic"
        case CondensedMedium = "CondensedMedium"
        case CondensedExtraBold = "CondensedExtraBold"
        case SemiBold = "SemiBold"
        case BoldItalic = "BoldItalic"
        case Heavy = "Heavy"
    }
    
    enum FontName: String {
        case HelveticaNeue = "HelveticaNeue"
        case Helvetica = "Helvetica"
        case Futura = "Futura"
        case Menlo = "Menlo"
        case Avenir = "Avenir"
        case AvenirNext = "AvenirNext"
        case Didot = "Didot"
        case AmericanTypewriter = "AmericanTypewriter"
        case Baskerville = "Baskerville"
        case Geneva = "Geneva"
        case GillSans = "GillSans"
        case SanFranciscoDisplay = "SanFranciscoDisplay"
        case Seravek = "Seravek"
    }
    
    class func PrintFontFamily (font: FontName) {
        let arr = UIFont.fontNamesForFamilyName(font.rawValue)
        for name in arr {
            println(name)
        }
    }
    
    class func Font (name: FontName, type: FontType, size: CGFloat) -> UIFont {
        return UIFont (name: name.rawValue + "-" + type.rawValue, size: size)!
    }
    
    class func HelveticaNeue (type: FontType, size: CGFloat) -> UIFont {
        return Font(.HelveticaNeue, type: type, size: size)
    }
}



// MARK: - CGPoint

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint (x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint (x: left.x - right.x, y: left.y - right.y)
}


enum AnchorPosition: CGPoint {
    case TopLeft        = "{0, 0}"
    case TopCenter      = "{0.5, 0}"
    case TopRight       = "{1, 0}"
    
    case MidLeft        = "{0, 0.5}"
    case MidCenter      = "{0.5, 0.5}"
    case MidRight       = "{1, 0.5}"
    
    case BottomLeft     = "{0, 1}"
    case BottomCenter   = "{0.5, 1}"
    case BottomRight    = "{1, 1}"
}

extension CGPoint: StringLiteralConvertible {
    
    public init(stringLiteral value: StringLiteralType) {
        self = CGPointFromString(value)
    }
    
    public init(extendedGraphemeClusterLiteral value: StringLiteralType) {
        self = CGPointFromString(value)
    }
    
    public init(unicodeScalarLiteral value: StringLiteralType) {
        self = CGPointFromString(value)
    }
}



// MARK: - CGSize

func + (left: CGSize, right: CGSize) -> CGSize {
    return CGSize (width: left.width + right.width, height: left.height + right.height)
}

func - (left: CGSize, right: CGSize) -> CGSize {
    return CGSize (width: left.width - right.width, height: left.width - right.width)
}



// MARK: - CGFloat

var ScreenWidth: CGFloat {
    get {
        return UIScreen.mainScreen().bounds.size.width
    }
}

var ScreenHeight: CGFloat {
    get {
        return UIScreen.mainScreen().bounds.size.height
    }
}

var StatusBarHeight: CGFloat {
    get {
        return UIApplication.sharedApplication().statusBarFrame.height
    }
}


func degreesToRadians (angle: CGFloat) -> CGFloat {
    return (CGFloat (M_PI) * angle) / 180.0
}

func normalizeValue (value: CGFloat,
    min: CGFloat,
    max: CGFloat) -> CGFloat {
        return (max - min) / value
}


func convertNormalizedValue (value: CGFloat,
    min: CGFloat,
    max: CGFloat) -> CGFloat {
        return ((max - min) * value) + min
}



// MARK: - UILabel

func setHeightOfLabel (label: UILabel) {
    label.h = heightForLabel(label.text!, label.font, label.w)
}


func heightForLabel (text: String,
    font: UIFont,
    width: CGFloat) -> CGFloat {
    let att = NSAttributedString (string: text, attributes: NSDictionary (object: font, forKey: NSFontAttributeName))
    let rect = att.boundingRectWithSize(CGSize (width: width, height: CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
    return rect.height
}


func getAspectHeightForImage (image: UIImage,
    aspectWidth: CGFloat) -> CGFloat {
    let aspectHeight = (aspectWidth * image.size.height) / image.size.width
    return aspectHeight
}



// MARK: - UIColor

func randomColor () -> UIColor {
    var randomRed:CGFloat = CGFloat(drand48())
    
    var randomGreen:CGFloat = CGFloat(drand48())
    
    var randomBlue:CGFloat = CGFloat(drand48())
    
    return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
}


func RGBColor (r: CGFloat,
    g: CGFloat,
    b: CGFloat) -> UIColor {
    return UIColor (red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
}


func RGBAColor (r: CGFloat,
    g: CGFloat,
    b: CGFloat,
    a: CGFloat) -> UIColor {
    return UIColor (red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}



// MARK: - UIAlertController

func alert (title: String,
    message: String,
    cancelAction: ((UIAlertAction!)->Void)? = nil,
    okAction: ((UIAlertAction!)->Void)? = nil) -> UIAlertController {
    let a = UIAlertController (title: title, message: message, preferredStyle: .Alert)
    
    if let ok = okAction {
        a.addAction(UIAlertAction(title: "OK", style: .Default, handler: ok))
        a.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelAction))
    } else {
        a.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: cancelAction))
    }
    
    return a
}



// MARK: - UIBarButtonItem

func barButtonItem (imageName: String,
    action: (AnyObject)->()) -> UIBarButtonItem {
    let button = BlockButton (frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    button.setImage(UIImage(named: imageName), forState: .Normal)
    button.actionBlock = action
    
    return UIBarButtonItem (customView: button)
}

func barButtonItem (title: String,
    color: UIColor,
    action: (AnyObject)->()) -> UIBarButtonItem {
    let button = BlockButton (frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    button.setTitle(title, forState: .Normal)
    button.setTitleColor(color, forState: .Normal)
    button.actionBlock = action
    button.sizeToFit()
    
    return UIBarButtonItem (customView: button)
}



// MARK: - BlockButton

class BlockButton: UIButton {
    
    override init (frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var actionBlock: ((sender: BlockButton) -> ())? {
        didSet {
            self.addTarget(self, action: "action:", forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    func action (sender: BlockButton) {
        actionBlock! (sender: sender)
    }
}



// MARK: - BlockWebView

class BlockWebView: UIWebView, UIWebViewDelegate {
    
    var didStartLoad: ((NSURLRequest) -> ())?
    var didFinishLoad: ((NSURLRequest) -> ())?
    var didFailLoad: ((NSURLRequest, NSError) -> ())?
    
    var shouldStartLoadingRequest: ((NSURLRequest) -> (Bool))?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func webViewDidStartLoad(webView: UIWebView) {
        didStartLoad? (webView.request!)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        didFinishLoad? (webView.request!)
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        didFailLoad? (webView.request!, error)
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        if let should = shouldStartLoadingRequest {
            return should (request)
        } else {
            return true
        }
    }
    
}

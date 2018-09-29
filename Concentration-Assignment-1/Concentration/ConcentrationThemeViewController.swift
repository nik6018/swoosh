//
//  ConcentrationThemeViewController.swift
//  Concentration
//
//  Created by Nikhil Muskur on 05/05/18.
//  Copyright © 2018 Nikhil Muskur. All rights reserved.
//

import UIKit

class ConcentrationThemeViewController: UIViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         Guide for NavControllers Ultimate.
         =================================
         
         NC contains Navbar which intern contains NavItems
         
         NC (Navigation Controller) (Optional, so always "if let" if in doubt)
         ---
            |-> NB (Navigation Bar)
                ---
                   |-> NI (Navigation Items)
         
         Although standalone VC w/o NC can have NB and NI
         So be careful when accessing these properties as they may not exist
         
         In a view hierarchy with NC, NB is only available on the ROOT VC and not on any other VC which
         may be pushed or poped on the NC stack (IMP, wasted so many hours coz of this)
         
         For a custom back button: Consider this situation where A,B,C are VC in NC and A is the Root VC of NC
         
         A -> B -> C
         
         If you want to set a custom back button in B to A then you have to set that custom image or
         view in A (completely fucked up)
         The properties are :
         
         navigationController?.navigationBar.backIndicatorImage = Your Image
         navigationController?.navigationBar.backIndicatorTransitionMaskImage = Same Image
         
         
         Properties
         ----------
         Navigation Bar Properties and Funcs
         +++++++++++++++++++++++++++++++++++
         
         *) NB Style => 1) Default
                            BackGround: White (can be ovveridden)
                            Text Color: Black (can be ovveridden)
                            Transluent: True  (can be ovveridden)
                     2) Black
                            BackGround: Black (can be ovveridden)
                            Text Color: White (can be ovveridden)
                            Transluent: False (can be ovveridden)
         
         *) Bar Tint: Change the Backgrnd Color of the NB
                        (is applied to all the VC in the NC stack)
         
         *) Shadow Image : Set Image for shadow
         *) Back Image
         *) Back Mask
         *) prefersLargeTitles: For iOS 11 and UP Large NB titles
         *) setBackgroundImage(UIImage(), for: .default) :
                If we want a clear background for our NB Set this to an empty value of UIImage,
                setting Clear color on Bar Tint will not work for clear background.
         
         
         Text and Title Properties
         +++++++++++++++++++++++++
         
         *) Title Color: Change the Title in the NB
         *) Title Shadow: Change the Shadow to the Title (Default None)
         
         Navigation Item Properties
         ++++++++++++++++++++++++++
         
         *) Title: Add the Title for the for the page on the NB
         *) TitleView: Add custom View for the title (overrides the above property, by default is set to nil)
         *) LeftBarButton: Left UIBarButtonItem (for going back or for editing action) (can contain Custom view which is set on the BarButton)
         *) RightBarButton: Right UIBarButtonItem (can contain Custom view which is set on the BarButton)
         
         
         View
         ++++
         *) Tint Color: Change the color of the Left or Right NI button (eg: The back button Color) or any actionable button on the VC
         
         Large Titles
         ++++++++++++
         *) Set self.navigationController?.navigationBar.prefersLargeTitles to true so that large NB title is shown.
         *) If self.navigationItem.largeTitleDisplayMode is set to .always then the NB title may be derived from
            previous NB so if you want to set the large title for only the root NB then set this property to
            .never for all the VC which may pushed on the Navigation stack.
        */
        
        //Make Large Titles
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        let label = UILabel()
        label.text = "Choose Theme"
        label.textColor = #colorLiteral(red: 0.8746629124, green: 0.7200440478, blue: 0.1403496321, alpha: 1)
        label.font = UIFont(name: "Menlo", size: 30)
        label.sizeToFit()
        
        self.navigationItem.titleView = label
        
        let stringAttributes: [NSAttributedStringKey:Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        ]
        
        /*
         Layer Animation (For BackGorund Color) to the Navigation Bar Layer ;)
         All animation Possible
        */
        self.navigationController?.navigationBar.largeTitleTextAttributes = stringAttributes
        let largeNavigationTitleLayer = self.navigationController?.navigationBar.layer
        largeNavigationTitleLayer?.backgroundColor = UIColor.darkGray.cgColor
        
        let scaleAnimation =  CABasicAnimation(keyPath: "backgroundColor")
        scaleAnimation.toValue = UIColor.red.cgColor
        scaleAnimation.duration = 3.0
        scaleAnimation.autoreverses = true
        scaleAnimation.repeatCount = .infinity
        scaleAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        largeNavigationTitleLayer?.add(scaleAnimation, forKey: "scale")
        
        
//        let customView = BackArrowView()
//        customView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        let renderer = UIGraphicsImageRenderer(size: customView.bounds.size)
//        let image = renderer.image { ctx in
//            customView.drawHierarchy(in: customView.bounds, afterScreenUpdates: true)
//        }
        
        let arrImage = UIImageView(image: #imageLiteral(resourceName: "arrow"))
        arrImage.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        arrImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
//
//        //Set the Custom Back Bar Button
        self.navigationController?.navigationBar.backIndicatorImage = arrImage.image
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = arrImage.image
        
//        UINavigationBar.appearance().backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "A")
//        UINavigationBar.appearance().backIndicatorImage = #imageLiteral(resourceName: "A")
//
//        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "BB", style: .plain, target: nil, action: nil)
        
    }
        
    
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController) -> Bool {
        
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.currentTheme == nil {
                return true
            }
        }
        
        return false
    }
    
    let emojiThemeCollection = [
        "Face"   : ("😨🤩😈🤢😇😛😍😎😚😛😄🤣😢😡🤮🤕", UIColor.red),
        "People" : ("👶🏽🧛🏽‍♂️🎅🏽🙆🏼‍♀️👸🏽💆🏽‍♂️👮🏿‍♀️🕵🏽‍♀️👨‍🔧👩‍🚀👨🏽‍💻🧛‍♀️👩🏽‍⚖️🤷🏻‍♂️💇🏻‍♂️🧜🏻‍♂️", UIColor.blue),
        "Animal" : ("🐶🐹🐰🦁🐷🐥🐍🦋🦊🐌🕷🦖🦀🐡🐫🐓", UIColor.green),
        "Food"   : ("🍎🍑🍋🥦🍞🍓🍗🍠🥥🥗🥖🍬🍪🌰🍿🍩", UIColor.orange),
        "Sport"  : ("⚽️🏈🥊🏓🏑🏏⛳️🏂⚾️🎾🏀🏐🎱🎽⛸🎮", UIColor.purple)
    ]
    
    
    @IBAction func chooseTheme(_ sender: Any) {
        
        if let cvc = splitViewConcentrationController {
            if let buttonTitle = (sender as? UIButton)?.currentTitle, let theme = emojiThemeCollection[buttonTitle] {
                cvc.currentTheme = theme
            }
        } else if let cvc = myConcentrationController {
            if let buttonTitle = (sender as? UIButton)?.currentTitle, let theme = emojiThemeCollection[buttonTitle] {
                cvc.currentTheme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        }else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewConcentrationController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    private var myConcentrationController: ConcentrationViewController?
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let buttonTitle = (sender as? UIButton)?.currentTitle, let theme = emojiThemeCollection[buttonTitle],
                let cvc = segue.destination as? ConcentrationViewController {
                cvc.currentTheme = theme
                myConcentrationController = cvc
            }
        }
    }

}


class BackArrowView: UIView {
    
    override func draw(_ rect: CGRect) {
        let arrowPath = UIBezierPath()
        let topPoint = CGPoint(x: bounds.width/2 , y: bounds.maxY * 0.1)
        arrowPath.lineCapStyle = .round
        
        
        arrowPath.move(to: CGPoint(x: bounds.width/2, y: bounds.height * 0.9))
        arrowPath.addLine(to: topPoint)
        arrowPath.move(to: CGPoint(x: bounds.width * 0.9, y: bounds.height/2))
        arrowPath.addLine(to: topPoint)
        arrowPath.move(to: CGPoint(x: bounds.width * 0.1, y: bounds.height/2))
        arrowPath.addLine(to: topPoint)
        
        arrowPath.lineWidth = 1.0
        
        UIColor.blue.setStroke()
        arrowPath.stroke()
    }
}











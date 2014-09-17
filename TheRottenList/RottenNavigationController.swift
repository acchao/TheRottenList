//
//  RottenNavigationController.swift
//  TheRottenList
//
//  Created by Andrew Chao on 9/16/14.
//  Copyright (c) 2014 Andrew Chao. All rights reserved.
//

import UIKit

class RottenNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = UIColor(
            red: CGFloat(50) / 255.0,
            green: CGFloat(143) / 255.0,
            blue: CGFloat(0) / 255.0,
            alpha: CGFloat(1)
        )
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor(
                red: CGFloat(249) / 255.0,
                green: CGFloat(238) / 255.0,
                blue: CGFloat(2) / 255.0,
                alpha: CGFloat(1)
            )
        ]
        navigationBar.titleTextAttributes = titleDict

        //TODO (Andrew): change the navigation bar button colors.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ViewController.swift
//  ios15test
//
//  Created by Alexander v. Below on 30.06.21.
//

import UIKit

class ViewController: UIViewController {
    var featureKey: UIFontDescriptor.FeatureKey {
        #if swift(>=5.5)
        return .type
        #else
        return .featureIdentifier
        #endif
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        let test = self.featureKey

    }


}


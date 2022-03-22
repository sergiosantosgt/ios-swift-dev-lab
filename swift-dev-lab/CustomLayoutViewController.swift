//
//  CustomLayoutViewController.swift
//  swift-dev-lab
//
//  Created by Sergio Santos on 21/03/22.
//

import Foundation
import UIKit

class CustomLayoutViewController: UIViewController {
    
    @IBOutlet weak var noRecordViewStory: NoRecordView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use .xib Programatically
        let noRecordView = NoRecordView(frame: CGRect(x: 20.0, y: 100.0, width: 350.0, height: 200.0))
        noRecordView.lblNoRecord.text = "Programatically"
        self.view.addSubview(noRecordView)
        
        // Use .xib Storyboard
        noRecordViewStory.lblNoRecord.text = "Storyboard"
    }
    
}

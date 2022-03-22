//
//  NoRecordView.swift
//  swift-dev-lab
//
//  Created by Sergio Santos on 21/03/22.
//

import UIKit

class NoRecordView: UIView {


    @IBOutlet weak var lblNoRecord: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed("NoRecordView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
}

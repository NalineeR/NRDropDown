//
//  ViewController.swift
//  NRDropDown
//
//  Created by NalineeR on 03/04/2023.
//  Copyright (c) 2023 NalineeR. All rights reserved.
//

import UIKit
import NRDropDown

class ViewController: UIViewController {
    @IBOutlet weak var btn:UIButton!
    var selectedIndex:Int? = nil
    var dropDownObj:NRDropDownHelper? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnTapped(sender:UIButton){
        dropDownObj = NRDropDownHelper(delegateObj: self, dataSource: ["a","s"], anchorV: btn, selectedIndex: selectedIndex, selectionHandler: { [weak self] index in
            self?.selectedIndex = index
        })
        dropDownObj?.cellProperties.cellType = .selectedBackground
        dropDownObj?.cellProperties.selectedBGColor = .lightText
        dropDownObj?.cellHeight = 30
        dropDownObj?.show()
    }

}


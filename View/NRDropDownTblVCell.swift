//
//  NRDropDownTblVCell.swift
//  DropDown
//
//  NRaj on 27/02/2023.
//

import UIKit

class NRDropDownTblVCell:UITableViewCell{
    @IBOutlet weak var viewContainer:UIView!
    @IBOutlet weak var viewLeftCheck:UIView!
    @IBOutlet weak var viewRightCheck:UIView!
    @IBOutlet weak var lblTitle:UILabel!
    
    @IBOutlet weak var imgVLeft:UIImageView!
    @IBOutlet weak var imgVRight:UIImageView!
    
    var properties = CellModal()
    var isCellSelected = false
    
    func loadCell(obj:CellModal,title:String,isChosen:Bool){
        properties = obj
        isCellSelected = isChosen
        
        lblTitle.text = title
        let cellType = obj.cellType
        //handle visibility based on cell type
        viewLeftCheck.isHidden = cellType != .leftCheck
        viewRightCheck.isHidden = cellType != .rightCheck
        //apply properties
        setupProperties()
        //update ui based on selection
        updateSelection()
        
    }
    
    func updateSelection(){
        //handle visibility based on selection
        switch properties.cellType{
        case .rightCheck:
            viewRightCheck.alpha = isCellSelected ? 1 : 0
        case .leftCheck:
            viewLeftCheck.alpha = isCellSelected ? 1 : 0
        case .selectedBackground:
            viewContainer.backgroundColor = isCellSelected ? properties.selectedBGColor : properties.bgColor
        }
    }
    
    private func setupProperties(){
        lblTitle.textColor = properties.textColor
        lblTitle.font = properties.textFont
        imgVLeft.image = properties.icon
        imgVRight.image = properties.icon
        viewContainer.backgroundColor = properties.bgColor
    }
}

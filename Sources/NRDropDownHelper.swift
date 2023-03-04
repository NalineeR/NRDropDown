//
//  NRDropDownHelper.swift
//  NRDropDown
//
//  Created by NalineeR on 03/04/2023.
//

import UIKit


enum SelectionType{
    
    case leftCheck
    case rightCheck
    case selectedBackground
}

class DropDownHelper:NSObject{
    ///Holds the identifier for DropDown TableView Cell
    private let strCellID = "NRDropDownTblVCell"
    ///holds the anchor view
    private var anchorView : UIView
    ///holds the anchor converted frame
    private var anchorFrame : CGRect
    ///holds the delegate ref to viewcontroller
    private var delegate : UIViewController?
    ///holds the parent view controller
    private var parentVC : UIViewController?
    ///holds the datasource as [String]()
    private var arrDataSource = [String]()
    ///Holds the padding from anchor view. Default is 2
    private var paddingFromAnchorV = CGFloat(5)
    ///Holds the width of table view. By default holds the width of anchor view
    private var tableWidth = CGFloat.zero
    ///Holds the row index of selected item. Default is nil
    private var selectedRow:Int? = nil
    ///holds the ref to drop down tableView
    private var tblVDropDown = UITableView()
    private var transparentView = UIView()
    
    //MARK: Customizable properties
    ///handler called on did select from table
    var didSelectHandler:((Int)->())? = nil
    ///Use this to customize the cell properties
    var cellProperties = CellModal()
    ///return the max height for drop down table view
    var dropDownHeight:CGFloat{
        var count = arrDataSource.count
        count = count > 6 ? 6 : count
        return (CGFloat(count) * cellHeight)
    }
    ///returns the yorigin value for drop down to show
    private var yOrigin:CGFloat{
        return anchorFrame.origin.y + anchorFrame.height + paddingFromAnchorV
    }
    ///true -> if drop down table is visible , else false
    var isDropDownVisible = false
    ///holds the animation duration for show-hide the DropDown. Default is 0.8
    var animationDuration = CGFloat(0.6)
    ///Holds the cell height for DropDown. Default is 30.
    var cellHeight = CGFloat(30)
    
    //MARK:- init
    /// - Parameters:
    /// - dataSource: holds dataSource in array of string format
    /// - selectionHandler: completion handler returning selected index
    /// - achorVFrame: holds frame value of anchor view
    /// - yValue: y origin value
    /// - selectedIndex -> holds the index of selected item
    init(delegateObj:UIViewController,
                    dataSource:[String],
                    anchorV:UIView,
                    padding:CGFloat = CGFloat(5),
                    width:CGFloat? = nil,
                    selectedIndex:Int?,
                    selectionHandler:@escaping ((Int)->())) {
        
        
        delegate = delegateObj
        parentVC = delegateObj
        arrDataSource = dataSource
        anchorView = anchorV
        paddingFromAnchorV = padding
        selectedRow = selectedIndex
        
        anchorFrame = anchorView.convert(anchorView.bounds, to: delegateObj.view)
        tableWidth  = width ?? anchorFrame.width

        didSelectHandler = selectionHandler
        super.init()
        initialSetup()
    }
    
    private func initialSetup(){
        
        tblVDropDown.register(UINib.init(nibName: strCellID, bundle: nil), forCellReuseIdentifier: strCellID)
        tblVDropDown.delegate = self
        tblVDropDown.dataSource = self
        
        tblVDropDown.bounces = false
        tblVDropDown.separatorStyle = .none
        tblVDropDown.backgroundColor = .clear
    }
    
    /// reload table view with new datasource
    /// - Parameters:
    func reloadDataSource(dataSource:[String]){
        showDropDown()
        arrDataSource = dataSource
        tblVDropDown.reloadData()
    }
    
    func show(){
        showDropDown()
    }
    func hide(){
        removeTransparentView(shouldRemove: false)
    }
    
    //MARK:-
    //Add drop down table
    private func addDropDownToScreen() {
        
        guard let window = UIApplication.shared.windows.first else{return}
        
        isDropDownVisible = true
        transparentView.frame = window.frame
        transparentView.tag = 1001
        transparentView.isUserInteractionEnabled = true
        
        //add table view to transparent view
        tblVDropDown.frame = CGRect(x: getUpdatexXPosition(), y: yOrigin, width: tableWidth, height: 0)
        tblVDropDown.layer.cornerRadius = 5
        transparentView.addSubview(tblVDropDown)
        //add transparent view to parent view
        parentVC?.view.addSubview(transparentView)
        
        tblVDropDown.reloadData()
        if let index = selectedRow{
            tblVDropDown.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .none)
            tblVDropDown.delegate?.tableView?(tblVDropDown, didSelectRowAt: IndexPath(row: index, section: 0))
        }
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        transparentView.alpha = 0
        addTapGesture()
        animateToShowDropDown()
        
    }
    func updateYOrigin(yValue:CGFloat){
        anchorFrame.origin.y = yValue + paddingFromAnchorV
        UIView.animate(withDuration: 0.2) {[weak self] in
            guard let ws = self else {return}
            ws.tblVDropDown.frame = CGRect(x: ws.getUpdatexXPosition(),
                                           y:ws.yOrigin,
                                           width: ws.tableWidth,
                                           height: ws.dropDownHeight)
        }
        
    }
    
    ///Returns the new x position if the based on current values the right part is getting out of screen
    private func getUpdatexXPosition()->CGFloat{
        let xVal = anchorFrame.origin.x
        let screenWidth = UIScreen.main.bounds.width
        let widthPosition = anchorFrame.origin.x + tableWidth
        let isOverlapping = widthPosition > screenWidth
        let newX = isOverlapping ? xVal - abs(widthPosition-screenWidth) : xVal
        return newX
    }
    
    private func animateToShowDropDown(){
        UIView.animate(withDuration: animationDuration, delay: 0.0) {[weak self] in
            guard let weakSelf = self else{return}
            
            weakSelf.transparentView.alpha = 1
            weakSelf.tblVDropDown.frame = CGRect(x: weakSelf.getUpdatexXPosition(),
                                                 y:weakSelf.yOrigin,
                                                 width: weakSelf.tableWidth,
                                                 height: weakSelf.dropDownHeight)
        }
    }
    
    ///Show drowp down view. If already added to view controller then just show else just handle the alpha to show
    private func showDropDown(){
        if isDropDownVisible{
            animateToShowDropDown()
        }else{
            addDropDownToScreen()
        }
    }
    
    ///adds the tap gesture to the parent controller
    private func addTapGesture(){
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        tapgesture.delegate = self
        transparentView.addGestureRecognizer(tapgesture)
    }
    ///removes the drop down view from screen
    /// - shouldRemove: true -> then remove from superview else only hide
    @objc func removeTransparentView(shouldRemove:Bool) {
        isDropDownVisible = false
        UIView.animate(withDuration: animationDuration) {[weak self] in
            
            guard let weakSelf = self else{return}

            weakSelf.transparentView.alpha = 0
            var updatedFrame = weakSelf.tblVDropDown.frame
            updatedFrame.size.height = 0
            weakSelf.tblVDropDown.frame = updatedFrame
            
        } completion: {[weak self] finished in
            if shouldRemove && finished{
                self?.transparentView.removeFromSuperview()
            }
        }
    }
}


extension DropDownHelper:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblVDropDown.dequeueReusableCell(withIdentifier: strCellID, for: indexPath) as! NRDropDownTblVCell
        let row = indexPath.row
        //let isLastItem = (row == arrDataSource.count-1)
        let strTitle = arrDataSource[row]
        cell.loadCell(obj: cellProperties,
                      title: strTitle,
                      isChosen: (row == selectedRow))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? NRDropDownTblVCell{
            cell.isCellSelected = true
            cell.updateSelection()
        }
        didSelectHandler?(indexPath.row)
        removeTransparentView(shouldRemove: true)
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? NRDropDownTblVCell{
            cell.isCellSelected = false
            cell.updateSelection()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

extension DropDownHelper:UIGestureRecognizerDelegate{
    // UIGestureRecognizerDelegate method
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: tblVDropDown) == true {
            return false
        }
        return true
    }
}

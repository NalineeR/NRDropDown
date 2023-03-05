//
//  CellModal.swift
//  NRDropDown
//
//  NRaj on 27/02/2023.
//
import UIKit


public enum SelectionType{
    case leftCheck
    case rightCheck
    case selectedBackground
}

public struct CellModal{
    public var cellType:SelectionType = .leftCheck
    public var selectedBGColor = UIColor.lightGray
    public var bgColor = UIColor.white
    public var textColor = UIColor.black
    public var textFont = UIFont.systemFont(ofSize: 12)
    public var icon = UIImage(named: "icCheck")
}


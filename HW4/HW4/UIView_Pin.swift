//
//  IUView_Pin.swift
//  HW4
//
//  Created by qqtati on 22.11.2022.
//
import Foundation
import UIKit
extension UIView {
    enum PinSide {
        case top, bottom, left, right
    }
    
    func pin(to superview: UIView, _ sides: [PinSide : Int]) {
        for side in sides {
            switch side.key {
            case .top:
                pinTop(to: superview, side.value)
            case .bottom:
                pinBottom(to: superview, side.value)
            case .left:
                pinLeft(to: superview, side.value)
            case .right:
                pinRight(to: superview, side.value)
            }
        }
    }
    
    func pin(to superview: UIView, _ sides: [PinSide], _ const : Int = 0) {
        for side in sides {
            switch side {
            case .top:
                pinTop(to: superview, const)
            case .bottom:
                pinBottom(to: superview, const)
            case .left:
                pinLeft(to: superview, const)
            case .right:
                pinRight(to: superview, const)
            }
        }
    }
    
    
    
    func pin(to superView: UIView, _ sides: PinSide...) {
        translatesAutoresizingMaskIntoConstraints = false
        for side in sides {
            switch side {
            case .top:
                pinTop(to: superView)
            case .left:
                pinLeft(to: superView)
            case .right:
                pinRight(to: superView)
            case .bottom:
                pinBottom(to: superView)
            }
        }
    }
    
    func pin(to superView: UIView) {
        pinTop(to: superView)
        pinLeft(to: superView)
        pinRight(to: superView)
        pinBottom(to: superView)
    }
    
    
    @discardableResult
    func pinLeft(to superview: UIView, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = leadingAnchor.constraint(
            equalTo: superview.leadingAnchor,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinLeft(to side: NSLayoutXAxisAnchor, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = leadingAnchor.constraint(
            equalTo: side,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func pinRight(to superview: UIView, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = trailingAnchor.constraint(
            equalTo: superview.trailingAnchor,
            constant: CGFloat(const * -1)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinRight(to side: NSLayoutXAxisAnchor, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = trailingAnchor.constraint(
            equalTo: side,
            constant: CGFloat(const * -1)
        )
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func pinTop(to superview: UIView, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = topAnchor.constraint(
            equalTo: superview.topAnchor,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinTop(to side: NSLayoutYAxisAnchor, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = topAnchor.constraint(
            equalTo: side,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func pinBottom(to superview: UIView, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = bottomAnchor.constraint(
            equalTo: superview.bottomAnchor,
            constant: CGFloat(const * -1)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinBottom(to side: NSLayoutYAxisAnchor, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = bottomAnchor.constraint(
            equalTo: side,
            constant: CGFloat(const * -1)
        )
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func pinButton(to side: NSLayoutYAxisAnchor, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = bottomAnchor.constraint(
            equalTo: side,
            constant: CGFloat(const * -1)
        )
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func pinCenterX(to superview: UIView, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerXAnchor.constraint(
            equalTo: superview.centerXAnchor,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinCenterX(to center: NSLayoutXAxisAnchor, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerXAnchor.constraint(
            equalTo: center,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinCenterY(to superview: UIView, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerYAnchor.constraint(
            equalTo: superview.centerYAnchor,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinCenterY(to center: NSLayoutYAxisAnchor, _ const: Int = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerYAnchor.constraint(
            equalTo: center,
            constant: CGFloat(const)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinWidth(to superview: UIView, _ mult: Double = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(
            equalTo: superview.widthAnchor,
            constant: CGFloat(mult)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinWidth(to size: NSLayoutDimension, _ mult: Double = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(
            equalTo: size,
            constant: CGFloat(mult)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinHeight(to superview: UIView, _ mult: Double = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = centerYAnchor.constraint(
            equalTo: superview.centerYAnchor,
            constant: CGFloat(mult)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func pinHeight(to size: NSLayoutDimension, _ mult: Double = 1) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = heightAnchor.constraint(
            equalTo: size,
            constant: CGFloat(mult)
        )
        constraint.isActive = true
        
        return constraint
    }
    
    @discardableResult
    func setHeight(_ const: Int) -> NSLayoutConstraint {
        let constraint = heightAnchor.constraint(equalToConstant: CGFloat(const))
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func setWidth(_ const: Int) -> NSLayoutConstraint {
        let constraint = widthAnchor.constraint(equalToConstant: CGFloat(const))
        constraint.isActive = true
        return constraint
    }
    
    func pinCenter(to superview: UIView) {
        pinCenterX(to: superview)
        pinCenterY(to: superview)
    }
}


extension CALayer {
    public func applyShadow() {
        self.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        self.shadowOffset = CGSize(width: 0.0, height: 1.5)
        self.shadowOpacity = 1.0
        self.shadowRadius = 0.5
        self.cornerRadius = 3.0
    }
}


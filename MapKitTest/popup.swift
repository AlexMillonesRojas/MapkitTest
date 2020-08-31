//
//  popup.swift
//  MapKitTest
//
//  Created by Edgar Alexander on 19/08/2020.
//  Copyright © 2020 Edgar Alexander. All rights reserved.
//

import UIKit

class Popup: UIView {
    
    fileprivate let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.text = "MapKitTest"
        label.textAlignment = .center
        return label
    }()
    fileprivate let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "probando el pop up"
        label.textAlignment = .center
        return label
    }()
    fileprivate let container: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false //Si lo quitas el popUp no se ve
        v.backgroundColor = .white
        v.layer.cornerRadius = 24
        return v
    } ()
    fileprivate lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    @objc fileprivate func animateOut() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1,
            options: .curveEaseIn, animations: {
            self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        }) { (complete) in
            if complete {
                self.removeFromSuperview()
            }
        }
    }
    @objc fileprivate func animateIn() {
        self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1,
            options: .curveEaseIn, animations: {
            self.container.transform = .identity
            self.alpha = 1
        })
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        //self.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        self.frame = UIScreen.main.bounds
        self.addSubview(container)
        
        container.centerYAnchor.constraint(equalTo:self.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo:self.centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalTo:self.widthAnchor, multiplier: 0.5).isActive = true
        container.heightAnchor.constraint(equalTo:self.heightAnchor, multiplier: 0.45).isActive = true
        
        container.addSubview(stack)
        //container.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        stack.centerXAnchor.constraint(equalTo:container.centerXAnchor).isActive = true
        //container.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        stack.heightAnchor.constraint(equalTo:container.heightAnchor, multiplier: 0.6).isActive = true
        animateIn()
 }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

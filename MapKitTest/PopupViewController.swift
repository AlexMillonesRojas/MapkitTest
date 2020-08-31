//
//  PopupViewController.swift
//  MapKitTest
//
//  Created by Edgar Alexander on 21/08/2020.
//  Copyright © 2020 Edgar Alexander. All rights reserved.
//

import UIKit
import MapKit

class PopupViewController: UIViewController,MKMapViewDelegate {
   @IBOutlet weak var pop: UIView!
    @IBAction func closePopup(_ sender: Any) {
        //self.removeAnimate()
        animacionFinal()
    }
   private func bordes() {
        pop.layer.cornerRadius = 18
        //pop.layer.masksToBounds = true
    }
    private func sombras(scale: Bool = true) {
        pop.layer.shadowColor = UIColor.black.cgColor
        pop.layer.shadowOffset = .zero
        pop.layer.shadowOpacity = 0.2
        pop.layer.shadowRadius = 10
        
        pop.layer.shadowPath = UIBezierPath(rect: pop.bounds).cgPath
        pop.layer.shouldRasterize = true
        pop.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    private func moveRight(view: UIView) {
        view.center.x += 300
    }
    private func moveLeft(view: UIView) {
        view.center.x -= 300
    }
    private func animacionInicial() {
        let duration: Double = 0.5
        UIView.animate(withDuration: duration) {
            self.moveRight(view: self.pop)
        }
    }
    private func animacionFinal() {
        UIView.animate(withDuration: 0.5,animations: {
            self.moveLeft(view: self.pop)
        }, completion:{(finished: Bool) in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.showAnimate()
        bordes()
        sombras()
        animacionInicial()
    }
    
    func tocaMarcadorPopUp() {
    //Cuando toque un marcador/pin actuara como un boton y te muestre un pop up
    }
    func pinPopup() {
    //Seleccionara el pop up con la informacion segun su marcador/pin corespondiente
    }
}


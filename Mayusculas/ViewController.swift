//
//  ViewController.swift
//  Mayusculas
//
//  Created by Paulina González Dávalos on 4/18/20.
//  Copyright © 2020 Paulina González Dávalos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, protocoloSettings {

    var arrDatos: NSArray!
    var nivel: Int = 1 // 1 = principiante,  2 = intermedio,  3 = avanzado
    var modalidad: Int = 1 // 1 = por letra,  2 = por certeza (VoF),  3 = completar
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "db", ofType: "plist")
        arrDatos = NSArray(contentsOfFile: path!)
        //item 0 - 14 : niv 0
        //item 15 - 28 : niv 1
        //item 29 - 33 : niv 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "niveles" {
            let vistaNiveles = segue.destination as! SettingsViewController
            vistaNiveles.delegado = self
        } else if segue.identifier == "modalidades" {
            let vistaMod = segue.destination as! SettingsViewController
            vistaMod.delegado = self
        } else if segue.identifier == "iniciar" {
            let vistaIniciar = segue.destination as! GameModeViewController
            vistaIniciar.nivel = nivel
            vistaIniciar.modalidad = modalidad
            vistaIniciar.arrDatos = arrDatos
        }
    }
    
    
    @IBAction func aber(_ sender: Any) {
        print("nivel es ", nivel)
        print("modalidad es ", modalidad)
    }
    
    
    
    
    // MARK: - protocolos
    
    func cambiaNivel(n: Int) {
        nivel = n
    }
    
    func cambiaModalidad(m: Int) {
        modalidad = m
    }
    
}


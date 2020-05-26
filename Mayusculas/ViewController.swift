//
//  ViewController.swift
//  Mayusculas
//
//  Created by Paulina González Dávalos on 4/18/20.
//  Copyright © 2020 Paulina González Dávalos. All rights reserved.
//

import UIKit

class ViewController: UIViewController, protocoloSettings {
    @IBOutlet weak var h1: UIImageView!
    @IBOutlet weak var h2: UIImageView!
    @IBOutlet weak var h3: UIImageView!
    @IBOutlet weak var h4: UIImageView!
    @IBOutlet weak var h5: UIImageView!
    
    var arrDatos: NSArray!
    var nivel: Int = 1 // 1 = principiante,  2 = intermedio,  3 = avanzado
    var modalidad: Int = 1 // 1 = por letra,  2 = por certeza (VoF),  3 = completar
    var preguntas = Set<Int>()
    var reglas = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = Bundle.main.path(forResource: "db", ofType: "plist")
        arrDatos = NSArray(contentsOfFile: path!)
        //item 0 - 14 : niv 0
        //item 15 - 28 : niv 1
        //item 29 - 33 : niv 2
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        if screenWidth <= 320 && screenHeight <= 568 {
            h1.isHidden = true
            h2.isHidden = true
            h3.isHidden = true
            h4.isHidden = true
            h5.isHidden = true
        } else {
            h1.isHidden = false
            h2.isHidden = false
            h3.isHidden = false
            h4.isHidden = false
            h5.isHidden = false
        }
    }
    
    func getPreguntas() -> Void {
        // Esto lo quitamos cuando haya mas preguntas
        var max = 0
        if nivel == 3 {
            max = 4
        }
        else {
            max = 10
        }
        
        while preguntas.count < max {
            var value = 0
            if (nivel == 0) {
                value = Int.random(in: 0 ... 14)
            } else if (nivel == 1) {
                value = Int.random(in: 15 ... 28)
            } else {
                value = Int.random(in: 29 ... 33)
            }
            preguntas.insert(value)
        }
        print(preguntas)
        // Llenar arreglo de reglas a exportar
        for item in preguntas {
            let dic = arrDatos[item] as! NSDictionary
            reglas.append((dic["hint"] as? String)!)
        }
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
            getPreguntas()
            vistaIniciar.setPreguntas = preguntas
            vistaIniciar.nivel = nivel
            vistaIniciar.modalidad = modalidad
            vistaIniciar.arrDatos = arrDatos
            vistaIniciar.reglasExpotar = reglas
            print(reglas)
        } else if segue.identifier == "creditos" {
            let _ = segue.destination as! CreditsViewController
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


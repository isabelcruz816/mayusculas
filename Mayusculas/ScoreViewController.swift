//
//  ScoreViewController.swift
//  Mayusculas
//
//  Created by Paulina González Dávalos on 5/9/20.
//  Copyright © 2020 Paulina González Dávalos. All rights reserved.
//

import UIKit
import MessageUI

class ScoreViewController: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var lbPuntaje: UILabel!
    
    var puntos : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lbPuntaje.text = String(puntos!) + "puntos"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func sendEmail(_ sender: Any) {
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showMailError()
        }
    }
    
    func configureMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["paulinagdavalos@gmail.com"])
        mailComposerVC.setSubject("Puntaje Mayúsculas")
        mailComposerVC.setMessageBody("¡Felicidades! Obtuviste \(String(puntos)) puntos en el juego de mayúsculas", isHTML: false)
        
        return mailComposerVC
    }
    
    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Error al mandar correo", message: "Su dispositivo no pudo mandar el correo", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

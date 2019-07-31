//
//  FirstViewController.swift
//  coding
//
//  Created by Salvador Martí Solsona on 12/07/2019.
//  Copyright © 2019 Salvador Martí Solsona. All rights reserved.
//

import UIKit
//TouchID
import LocalAuthentication

//Para la clase primer controlador añadimos un delegado llamado UITextFieldDelegate
//Es como una "interfaz" de java donde yo puedo llamar a métodos suyos e implementar la funcionalidad.
class FirstViewController: UIViewController, UITextFieldDelegate {
    
    //ATRIBUTOS
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var ageSlider: UISlider!
    
    var uAge : Int = -1
    var userName : String = ""

    //Método que se ejecuta en el momento que se carga por primera vez la app.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateAgeLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //FUNCIONES DELEGATE ---------------------------
    //Funcion que se ejecuta cuando el usuario hace click en IR (intro)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Hemos pulsado la tecla Ir")
        //Cierra el teclado
        textField.resignFirstResponder()
        
        //Cambio de fuente
        //textField.font = UIFont(name: "Optima", size: 20.0)

        //Recuperamos el texto introducido
        //Codigo CASTING para asegurarnos de que una variable de tipo String? contiene algo, no nil.
        if let theText = textField.text {
            //print(theText)
            self.userName = theText
        }
        //--------------------------------------
        //indicamos la finalización de la edición del text field.
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("Borrando...")
    
        if let theText = textField.text {
            print(theText)
        }
        return true
    }
    
    //MÉTODOS - EVENTOS
    
    //NO CREO EL ATRIBUTO SLIDER PORQUE DE MOMENTO NO ME HACE FALTA,
    //sender YA es el Slider
    
    // SLIDER ------------------------------------------------
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        self.updateAgeLabel()
    }
    //--------------------------------------------------------
    
    // BUTTON ------------------------------------------------
    @IBAction func buttonTouched(_ sender: UIButton) {
        
        let context = LAContext()
        var error : NSError?
        
        let shouldEnterTheParty = (self.userName == "Salva Marti") || (self.uAge >= 18)
        if (shouldEnterTheParty) {
            self.view.backgroundColor = UIColor(displayP3Red: 49.0/255.0, green: 237.0/255.0, blue: 93.0/255.0, alpha: 0.80)
            
        }
        else {
            //Si es menor de 18, comprobamos con touch id.
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let razon = "Autenticación con Touch ID"
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: razon) { (success, error) in
                    
                    if success {
                        self.showAlertController("Autentificacion OK", v : true)
                        //self.paintBackground(variable: true)
                    }
                    else {
                        self.showAlertController("Autentificacion falló", v: false)
                        //self.paintBackground(variable: false)
                    }

                }
            }
            else {
                self.view.backgroundColor = UIColor(displayP3Red: 220.0/255.0, green: 83.0/255.0, blue: 74.0/255.0, alpha: 0.80)
            }
            
            //self.view.backgroundColor = UIColor(displayP3Red: 250.0/255.0, green: 50.0/255.0, blue: 73/255.0, alpha: 0.80)
        }
        
    }
    
    //Funciones - Metodos funcionales
    func updateAgeLabel() -> Void {
        // Actualiza etiqueta con el valor del slider
        self.uAge = Int(self.ageSlider.value)
        self.age.text = "\(self.uAge)"
    }
    
    func returnBackgroundColor() -> Void {
        self.view.backgroundColor = UIColor(displayP3Red: 239.0/255.0, green: 239.0/255.0, blue: 244/255.0, alpha: 1)
    }
    
    func showAlertController( _ message: String, v : Bool) -> Void {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default) { _ in
            self.paintBackground(variable: v)
        }
        
        alertController.addAction(ok)
        self.show(alertController, sender: nil)
    }
    
    func paintBackground(variable: Bool) -> Void {
        if(variable) {
            self.view.backgroundColor = UIColor(displayP3Red: 49.0/255.0, green: 237.0/255.0, blue: 93.0/255.0, alpha: 0.80)
        }
        else {
            self.view.backgroundColor = UIColor(displayP3Red: 250.0/255.0, green: 50.0/255.0, blue: 73/255.0, alpha: 0.80)
        }
    }

}

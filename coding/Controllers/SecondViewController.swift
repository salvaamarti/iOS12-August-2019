//
//  SecondViewController.swift
//  coding
//
//  Created by Salvador Martí Solsona on 12/07/2019.
//  Copyright © 2019 Salvador Martí Solsona. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    
    //En la segunda vista vamos a programar a partir de la sucesión de fibonacci
    //Necesitamos
    
    //ATRIBUTOS
    //----------------------------------------------
    @IBOutlet weak var fibLabel: UILabel! //Etiqueta de título
    @IBOutlet weak var countLabel: UILabel! //Etiqueta número de elementos de la sucesión
    @IBOutlet weak var stepper: UIStepper! // elemento stepper
    //@IBOutlet weak var textView: UITextView! //elemento textView
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var labelGolden: UILabel!
    
    //-----------------------------------------------
    
    // Array de enteros (por lo menos los dos primeros valores, son fijo)
    var fibonacci : [Int] = [0,1]
    //El numero de valores que queremos añadir al array
    var fibId : Int = 1
    var calculateGoldNum = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.text = ""
        // Do any additional setup after loading the view.
        self.updateCountLabel(id: Int(self.stepper.value))
    }
    
    //FUNCION generar num de fibonacci (dado fibId)
    func generateFibNumbers() {
        
        self.fibonacci = [0,1]
        
        if (self.fibId <= 1 || self.fibId > 50) {
            return
        }
        //for i in 2...<self.fibId {
        for i in 2...self.fibId {
            self.fibonacci.append(self.fibonacci[i-2]+self.fibonacci[i-1])
        }
        //print(self.fibonacci)
        //self.textView.text = "\(self.fibonacci)"
        
        //MAP FILTER Y REDUCE (TRANSFORMAR DATOS DEL ARRAY)
        
        //REPASAR ESTO (compactMap y joined)
        let fibStr : [String] = self.fibonacci.compactMap({String($0)})
        let result : String = fibStr.joined(separator: "\n")
        self.textView.text = result
        //
    }
    
    func updateCountLabel(id: Int) -> Void {
        self.fibId = id
        self.countLabel.text = "\(self.fibId)"
        self.generateFibNumbers()
        self.calculateGoldenNum()
    }
    
    func calculateGoldenNum() -> Void {
        if(self.calculateGoldNum) {
            //generar nº de oro, cociente 2 ultimos n de la sucesion
            let last = Double(self.fibonacci[self.fibonacci.count-1])
            let previous = Double(self.fibonacci[self.fibonacci.count-2])
            
            let goldNum = last / previous
            
            self.labelGolden.text = "\(goldNum)"
            
        }
        else {
            self.labelGolden.text = "Ver el Nº de oro"
        }
    }
    
    //EVENTOS
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        self.updateCountLabel(id: Int(sender.value))
    }
    
    @IBAction func switchMoved(_ sender: UISwitch) {
        self.calculateGoldNum = sender.isOn
        self.calculateGoldenNum()
    }
}

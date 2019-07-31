//
//  FontDetailViewController.swift
//  coding
//
//  Created by Salvador Martí Solsona on 30/07/2019.
//  Copyright © 2019 Salvador Martí Solsona. All rights reserved.
//

import UIKit

class FontDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //Atributos del nuevo FontDetailViewController
    @IBOutlet weak var fontTitleLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var textView: UITextView!
    
    //inicializar
    var familyName : String = ""
    var fonts : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fontTitleLabel.text = self.familyName
        self.fontTitleLabel.font = UIFont(name: self.familyName, size: 26.0)
        // Do any additional setup after loading the view.
        
        //Manera de hacer por codigo el enlace entre DataSource y Delegate del PickerViwer
        //self.picker.dataSource = self
        //self.picker.delegate = self
    
        if (self.fonts.count == 0) {
            self.picker.isHidden = true
        }
        
        self.textView.font = UIFont(name: self.familyName, size: 14.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        //DISMISS -> CERRAR / FINALIZAR y te lleva al ViewController padre
        self.dismiss(animated: true)
    }
    
    //MARK: - Métodos del UIPickerDataSource
    //Número de columnas ( en este caso 1)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Número de filas (en este caso corresponde al número de sub-fuentes de la familia de fuentes
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.fonts.count
    }
    
    //Funcion del delegate para rellenar cada una de las celdas. 
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fonts[row]
    }
    
    //SELECCIÓN DE LA FUNCION DE SELECCIÓN
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.textView.font = UIFont(name: fonts[row], size: 14.0)
    }
    
}

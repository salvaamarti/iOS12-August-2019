//
//  ThirdViewController.swift
//  coding
//
//  Created by Salvador Martí Solsona on 12/07/2019.
//  Copyright © 2019 Salvador Martí Solsona. All rights reserved.
//

import UIKit

//CATÁLOGO DE FUENTES DE iOS

//UITableViewDelegate -> se encarga de interacciones, p.e. seleccionar una celda, hacer scroll arriba o abajo
//UITableViewDataSource -> Proporciona la fuente de datos, con que vamos a rellenar la tabla.
//IMPORTANTÍSIMO.
//EN UNA TABLE VIEW CONTROLLER no haría falta.
class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var families : [String] = []
    //Diccionario [Fuente : [Array de subfuentes]]
    var font : [String : [String]] = [:]
    
    //TABLEVIEW
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        families = UIFont.familyNames
        
        families = families.sorted { (s1, s2) -> Bool in
            return s2 > s1
        }
        
        //families = UIFont.families.sortedby({ return $0 > $1 })
        
        for fam in families{
            font[fam] = UIFont.fontNames(forFamilyName: fam)
        }
        print(font)
        // Do any additional setup after loading the view.
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    //IMPORTANTISIMO
    //METODO QUE SE EJECUTA JUSTO ANTES DE LLEVAR A CABO UN SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ShowFontForFamily" {
            // Get the new view controller using segue.destination.
            //El primer destino es el navigationController, lo recupero con segue.destination
            let navController = segue.destination as! UINavigationController
            //El segundo controlador (el que me interesa) es el hijo primero (top) del navcontroller
            let destinationViewController = navController.topViewController as! FontDetailViewController
            
            //Obtener indexPath.row de la fila seleccionada
            let idx = self.tableView.indexPathForSelectedRow!.row
            
            //AQUI SE HACE EL TRANSPASO DE DATOS DE UN CONTROLLER A OTRO (IMPORTANTISIMO)
            destinationViewController.familyName = self.families[idx]
            destinationViewController.fonts = self.font[self.families[idx]]! //! es porque UIFont.fontNames(forFamilyName: fam) devuelve un [String] optional
        }
        
    }
    
    // MARK: - Métodos del protocolo UITableViewDataSource
    //POR DEFECTO UNA TABLA TIENE UNA SECCIÓN (LAS SECCIONES ESTAN SEPARADAS POR SEPARADORES) E.j. (A-B-C-D) EN CONTACTOS
    
    //Tabla devuelve 1 seccion (Quiero toda la información junta)
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //numberOfRowsInSection -> sirve para definir cuantas filas vamos a tener en cada sección
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.families.count
    }
    
    //cellForRowAt indexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //tableView.dequeueReusableCel (Desencolar la celda que desaparecen al hacer scroll) (recuperamos la celda para trabajar con ella)
        let cell = tableView.dequeueReusableCell(withIdentifier: "FontFamilyCell", for: indexPath)
        //indexPath.row (en que fila)
        //indexPath.section (en que seccion estamos)
        
        //recuperamos la familia
        let fontFamily = self.families[indexPath.row]
        //asignamos texto al elemento textLabel
        cell.textLabel?.text = fontFamily
        //Asignamos la fuente
        cell.textLabel?.font = UIFont(name: fontFamily, size: 20.0)
        return cell
    }
    
    //MARK: - Métodos del protocolo UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let fontFamily = self.families[row]
        let famfonts = self.font[fontFamily]!
        print(fontFamily)
        print(famfonts)
    }
    
}

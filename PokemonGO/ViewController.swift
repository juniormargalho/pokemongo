//
//  ViewController.swift
//  PokemonGO
//
//  Created by Nelson Antonio Barbosa Margalho Junior on 21/03/21.
//  Copyright © 2021 JuniorMargalho. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var mapa: MKMapView!
    var gerenciadorLocalizacao = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapa.delegate = self
        gerenciadorLocalizacao.delegate = self
        gerenciadorLocalizacao.requestWhenInUseAuthorization()
        gerenciadorLocalizacao.startUpdatingLocation()
        
    }
    
    //metodo que verifica se o usuario autorizou o acesso a localizacao
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse && status != .notDetermined {
            let alertController = UIAlertController(title: "Permissão de localização",
                                                    message: "Para que você possa capturar pokemons, precisamos da sua localização!",
                                                    preferredStyle: .alert)
            let acaoConfiguracoes = UIAlertAction(title: "Abrir Configurações", style: .default) { (alertaConfiguracoes) in
                if let configuracoes = NSURL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(configuracoes as URL)
                    
                }
                
            }
            let acaoCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: nil)
            alertController.addAction(acaoConfiguracoes)
            alertController.addAction(acaoCancelar)
            present(alertController, animated: true, completion: nil)
            
        }
        
    }

}


//
//  ResultsViewController.swift
//  who is that pokemon
//
//  Created by Lucas Suarez Blanco on 11/26/22.
//

import UIKit
import Kingfisher

class ResultsViewController: UIViewController {
    
    
    @IBOutlet
    var pokemonImage: UIImageView!
    
    @IBOutlet
    var pokemonLabel: UILabel!
    
    @IBOutlet
    var scoreLabel: UILabel!
    
    var pokemonName: String = ""
    var pokemonImageUrl: String = ""
    var finalScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Perdiste, tu puntaje fue de \(finalScore)."
        pokemonLabel.text = "No, es un \(pokemonName)"
        pokemonImage.kf.setImage(with: URL(string: pokemonImageUrl))
    }
    
    @IBAction
    func playAgainPress(_ sender: UIButton) {
        // volver atras
        self.dismiss(animated: true)
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

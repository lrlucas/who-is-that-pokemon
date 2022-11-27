//
//  ViewController.swift
//  who is that pokemon
//
//  Created by Alex Camacho on 01/08/22.
//

import UIKit
import Kingfisher

class PokemonViewController: UIViewController {

    @IBOutlet
    var labelScore: UILabel!
    
    @IBOutlet
    var pokemonImage: UIImageView!
    
    @IBOutlet
    var labelMessage: UILabel!
    
    @IBOutlet
    var answerButtons: [UIButton]!
    
    // agregamos el manager
    lazy var pokemonManager = PokemonManager()
    lazy var imageManager = ImageManager()
    lazy var game = GameModel()
    
    var random4Pokemon : [PokemonModel] = [] {
        didSet {
            setButtonTitles()
        }
    }
    var correctAnswer : String = ""
    var correctAnswerImage : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonManager.delegate = self
        imageManager.delegate = self
        
        
        decorationButton()
        pokemonManager.fetchPokemon()
        labelMessage.text = ""
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destination = segue.destination as! ResultsViewController
            destination.pokemonName = correctAnswer
            destination.pokemonImageUrl = correctAnswerImage
            destination.finalScore = game.score
            resetGame()
        }
    }
    
    @IBAction
    func buttonPressed(_ sender: UIButton) {
        let userAnswer = sender.title(for: .normal)!
        if game.checkAnswer(userAnswer, correctAnswer) {
            labelMessage.text = "Si es un \(userAnswer.capitalized)"
            labelScore.text = "Puntaje: \(game.score)"
            
            sender.layer.borderColor = UIColor.systemGreen.cgColor
            sender.layer.borderWidth = 2
            
            let url = URL(string: correctAnswerImage)
            pokemonImage.kf.setImage(with: url)
            
            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { timer in
                self.pokemonManager.fetchPokemon()
                self.labelMessage.text = ""
                sender.layer.borderWidth = 0
                
            }
        } else {
//            labelMessage.text = "No, es un \(correctAnswer.capitalized)"
//            sender.layer.borderColor = UIColor.systemRed.cgColor
//            sender.layer.borderWidth = 2
//            let url = URL(string: correctAnswerImage)
//            pokemonImage.kf.setImage(with: url)
//
//            Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { timer in
//                self.resetGame()
//                sender.layer.borderWidth = 0
//
//            }
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
        
    }
    
    func resetGame() {
        self.pokemonManager.fetchPokemon()
        game.setScore(score: 0)
        labelScore.text = "Puntaje: \(game.score)"
        self.labelMessage.text = ""
       
        
    }
    
    func decorationButton() {
        for button in answerButtons {
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
            button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 0
            button.layer.masksToBounds = false
            button.layer.cornerRadius = 10.0
        }
    }
    
    func setButtonTitles() {
        for (index, button) in answerButtons.enumerated() {
            DispatchQueue.main.async { [self] in
                button.setTitle(self.random4Pokemon[safe: index]?.name.capitalized, for: .normal)
            }
        }
    }
    
    
    
}


// ImageManager
extension PokemonViewController : ImageManagerDelegate {
    func didFailWithErrorImage(error: Error) {
        print(error)
    }
    
    func didUpdateImage(image: ImageModel) {
        print("IMAGEN: \(image.imageUrl)")
        correctAnswerImage = image.imageUrl
        DispatchQueue.main.async { [self] in
            let url = URL(string: image.imageUrl)
            let effect = ColorControlsProcessor(brightness: -1, contrast: 1, saturation: 1, inputEV: 0)
            pokemonImage.kf.setImage(with: url, options: [.processor(effect)])
        }
    }
    
    
}

// PokemonManager
extension PokemonViewController : PokemonManagerDelegate {
    
    func didUpdatePokemon(pokemons: [PokemonModel]) {
        random4Pokemon = pokemons.choose(4)
        let index = Int.random(in: 0...3)
        let imageData = random4Pokemon[index].imageUrl
        correctAnswer = random4Pokemon[index].name
        imageManager.fetchImage(url: imageData)
        
        print(pokemons.choose(4))
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}

extension Collection where Indices.Iterator.Element == Index {
    public subscript(safe index: Index) -> Iterator.Element? {
        return ( startIndex <= index && index < endIndex ) ? self[index] : nil
    }
}

extension Collection {
    func choose(_ n: Int) -> Array<Element> {
        Array(shuffled().prefix(n))
    }
}

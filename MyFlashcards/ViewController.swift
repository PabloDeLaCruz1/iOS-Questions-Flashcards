//
//  ViewController.swift
//  MyFlashcards
//
//  Created by Pablo De La Cruz on 3/1/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var card: FlashCard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func flipButton(_ sender: Any) {
        card.flip()
    }
    
    @IBAction func nextButton(_ sender: Any) {
        card.next()
    }
}

	

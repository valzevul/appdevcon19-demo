import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var leftButton: UIButton! {
        didSet { self.leftButton.style() }
    }
    
    @IBOutlet weak var middleButton: UIButton! {
        didSet { self.middleButton.style() }
    }
    
    @IBOutlet weak var rightButton: UIButton! {
        didSet { self.rightButton.style() }
    }

    var correctSolution: String = ""
    var failedAttempts = 0
    let fireworkController = ClassicFireworkController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.refresh()
    }
    
    let words: [String: String] = [
        "herring.jpg": "Hollandse Nieuwe",
        "stroopwafels.jpg": "Stroopwafels",
        "drop.jpg": "Drop",
        "friet.jpg": "Friet",
        "oliebollen.jpg": "Oliebollen",
        "kibbeling.jpg": "Kibbeling",
        "stamppot.png": "Stamppot",
        "speculaas.jpg": "Speculaas",
        "kapsalon.jpg": "Kapsalon",
        "kroketten.jpg": "Kroketten",
        "poffertjes.jpg": "Poffertjes"
    ]


    func refresh() {
        guard let dutchWordPair = words.randomElement() else { return }

        failedAttempts = 0
        let dutchWord = dutchWordPair.key
        let dutchWordAnswer = dutchWordPair.value
        
        self.questionImageView.image = UIImage(named: dutchWord)
        let buttons = [leftButton, middleButton, rightButton].shuffled()
        
        buttons[0]?.setTitle(dutchWordAnswer, for: UIControlState())
        buttons[1]?.setTitle(words.randomElement()?.value ?? "", for: UIControlState())
        buttons[2]?.setTitle(words.randomElement()?.value ?? "", for: UIControlState())
        correctSolution = dutchWordAnswer
    }

    @IBAction func buttonTouchedDown(_ sender: UIButton) {
        self.checkAnswer(sender: sender)
    }
    
    func checkAnswer(sender: UIButton) {
        let text = sender.titleLabel?.text ?? ""
        if words[text] != correctSolution { return }
        NSLog("Hooray")
    }

    func nextWord(button: UIButton) {
        self.fireworkController.addFireworks(count: 2, sparks: 8, around: button)
        self.refresh()
    }
}

extension UIButton {

    func style() {
        let color: UIColor = UIColor(red: 0.90, green: 0.87, blue: 0.47, alpha: 1.00)
        self.backgroundColor = color
        self.layer.cornerRadius = 8
        self.titleLabel!.font = UIFont.boldSystemFont(ofSize: 20)
    }
}

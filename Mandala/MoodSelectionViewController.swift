//
//  ViewController.swift
//  Mandala
//
//  Created by Alberto Silva on 08/06/21.
//

import UIKit

class MoodSelectionViewController: UIViewController {
    @IBOutlet var moodselector: ImageSelector!
    @IBOutlet var addMoodButton: UIButton!

    var moodsConfigurable: MoodsConfigurable!
    
    var moods: [Mood] = [] {
        didSet {
            currentMood = moods.first
            moodselector.images = moods.map{$0.image}
        }
    }
    
    var currentMood: Mood? {
        didSet {
            guard let currentMood = currentMood else {
                addMoodButton?.setTitle(nil, for: .normal)
                addMoodButton?.backgroundColor = nil
                return
            }

            addMoodButton?.setTitle("I'm \(currentMood.name)", for: .normal)
            addMoodButton?.backgroundColor = currentMood.color
        }
    }

    @IBAction private func moodSelectionChanged(_ sender: ImageSelector) {
        let selectedIndex = sender.selectedIndex
        currentMood = moods[selectedIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        moods = [.happy, .sad, .angry, .goofy, .crying, .confused, .sleepy, .meh]
        addMoodButton.layer.cornerRadius = addMoodButton.bounds.height / 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "embedContainerViewController":
            guard let moodsConfigurable = segue.destination as? MoodsConfigurable else {
                preconditionFailure("View controller expect to conform as MoodsConfigurable")
            }
            self.moodsConfigurable = moodsConfigurable
            segue.destination.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: 160, right: 0)
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    @IBAction func addMoodTapped(_ sender: Any){
        guard let currentMood = currentMood else {
            return
        }
        
        let newMoodEntry = MoodEntry(mood: currentMood, timestamp: Date())
        moodsConfigurable.add(newMoodEntry)
    }

}


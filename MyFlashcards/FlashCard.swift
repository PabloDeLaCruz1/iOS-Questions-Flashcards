//
//  FlashCard.swift
//  MyFlashcards
//
//  Created by Pablo De La Cruz on 3/1/22.
//

import UIKit


class FlashCard: UIView {

    var backView: ItemView?
    var frontView: ItemView?
    var frontText: String?
    var backText: String?
    var isFrontView_CurrentlyVisable_onTheScreen = false




    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        self.isUserInteractionEnabled = true

        setQanda()

        setupview()

        self.backView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.checkAction)))
        self.frontView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.checkAction)))

    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.clear
        self.isUserInteractionEnabled = true
        setQanda()

        setupview()
    }

    @objc func checkAction(sender: UITapGestureRecognizer) {
        flip()
    }

    func setupview() {
        loadFront()

        loadBack()

    }

    func loadFront() {
        if frontView == nil {
            frontView = ItemView.init(frame: self.bounds, imageName: "question", labelText: frontText!)
//                frontView?.label?.text?.lineRange(for: nil)
            self.addSubview(frontView!)
            frontView?.isHidden = false
        }
    }

    func loadBack() {
        if backView == nil {
            backView = ItemView.init(frame: self.bounds, imageName: "darkBackground", labelText: backText!)
            self.addSubview(backView!)
            backView?.isHidden = true
        }
    }

    func unloadBack() {
        backView?.removeFromSuperview()
        backView = nil
    }

    func flip() {

        let ObjectToDisplay: ItemView
        let currentlyVisableObjectOnScreen: ItemView

        if isFrontView_CurrentlyVisable_onTheScreen {
            ObjectToDisplay = frontView!
            currentlyVisableObjectOnScreen = backView!
            isFrontView_CurrentlyVisable_onTheScreen = false

        } else {
            ObjectToDisplay = backView!
            currentlyVisableObjectOnScreen = frontView!
            isFrontView_CurrentlyVisable_onTheScreen = true
        }

        if ObjectToDisplay.isHidden {
            ObjectToDisplay.isHidden = false
        }

        print("isFrontView_CurrentlyVisable_onTheScreen?: \(isFrontView_CurrentlyVisable_onTheScreen)")

        UIView.transition(from: currentlyVisableObjectOnScreen, to: ObjectToDisplay, duration: 1, options: UIView.AnimationOptions.transitionFlipFromRight, completion: { (done) -> () in
            if done {
                currentlyVisableObjectOnScreen.isHidden = true
            }
        })
    }

    func flipUp() {

        let ObjectToDisplay: ItemView
        let currentlyVisableObjectOnScreen: ItemView
//        print("Front view-----", frontView?.label?.text)

        if isFrontView_CurrentlyVisable_onTheScreen {
            ObjectToDisplay = frontView!
            currentlyVisableObjectOnScreen = backView!
            isFrontView_CurrentlyVisable_onTheScreen = false

        } else {
            ObjectToDisplay = backView!
            currentlyVisableObjectOnScreen = frontView!
            isFrontView_CurrentlyVisable_onTheScreen = true
        }

        if ObjectToDisplay.isHidden {
            ObjectToDisplay.isHidden = false
        }

//        print("isFrontView_CurrentlyVisable_onTheScreen?: \(isFrontView_CurrentlyVisable_onTheScreen)")

        UIView.transition(from: currentlyVisableObjectOnScreen, to: ObjectToDisplay, duration: 1, options: UIView.AnimationOptions.transitionCurlDown, completion: { (done) -> () in
            if done {
                currentlyVisableObjectOnScreen.isHidden = true
            }
        })
    }

    func next() {
        setQanda()
        flipUp()
    }

    func setQanda() {
        
        let index: Int = Int(arc4random_uniform(UInt32(Qanda.count)))
        backText = Array(Qanda.values)[index] //index is random: 2 or 1 or 8 etc
        frontText = Array(Qanda.keys)[index]
        backView?.label?.text = backText
        frontView?.label?.text = frontText

//        loadBack()
//        loadFront()
//
//        print(frontText!)
//        print(backView?.label?.text)

    }
    //Dictionary holding Question:Answer,
    var Qanda: Dictionary<String, String> =
        ["What is the difference between value and reference types?": "AValue Type — each instance keeps a unique copy of its data. A type that creates a new instance (copy) when assigned to a variable or constant, or when passed to a function. Reference Type — each instances share a single copy of the data. A type that once initialized, when assigned to a variable or constant, or when passed to a function, returns a reference to the same existing instance.",

        "What are optionals? How can you unwrap an optional in a safe way? What is forced unwrapping?": "Introduced in Swift 4, they represent the absence of a value. You can safely unwrap using 'if let', or 'guard let'. Force unwrapping is using '!' to unwrap. ",

        "What are higher order functions? Give some examples of higher order functions in Swift. Explain one of them.": "Higher order functions are functions that either take a function as a parameter or returns a function. An example is filter. you can do 'var numbersLessThanFive = numbers.filter {(a) -> Bool in return a < 5 }' Here we pass a closure to the filter method. making it a higher order function. Filter lets you return elements from a collection as specified by your closure. In my case I tell filter to look through the numbers array and return each number < 5",

        "What benefits do generics have? How can you define a generic function in Swift?": "Generic code enables you to write flexible, reusable functions and types that can work with any type, subject to requirements that you define. For example, you can create an array that holds Int, or String values. It works with both. You can write code that avoids duplication and expresses its intent in a clear, abstracted manner. ",

        "What are opaque types in Swift? Where can opaque types be useful?": "Opaque are like protocols but they preserve type identity when returning. They allow you to return ",

        "What is let and var in Swift?": "var allows you to assign mutable variables. let allows you to assign constant variables (immutable)",

        "What is Optional in Swift and nil in Swift and Objective-C?": "In Objective-C, nil is a pointer to a nonexistent object. In Swift, nil isn't a pointer—it's the absence of a value of a certain type.",

        "What is the difference between struct and class in Swift? When would you use one or the other?": "Structs and Classes are similar that they allow you to create instance variables with properties and methods. But Classes allow for inheritance since its reference type. Use struct unless you need inheritance / your file is large",

        "What are properties and instance variables in Objective-C and Swift?": "A property is an attribute that can be accessed from your object. An instance variable is property that belongs to a particular instance of an object.",

        "What is a protocol (both Obj-C and Swift)? When and how is it used?": "Swift version of interface from Java. Protocols allow you to define an object with methods. Other objects that implement this protocol must implement these methods.",

        "What is a category/extension? When is it used?": "Extensions allows the user to extend the capabilities of a built-in functions or user-defined functions",

        "What are closures/blocks and how are they used?": "a closure is a function or block of code that you can be used in your code. Like you can pass a closure into other functions as parameters or return them as a function.",

        "What is a trailing closure?": "a trailing closure allows special syntax that you can use if your function has a closure as its last parameter.",

        "What is the difference between a class and an object?": "a class is a type of object, as is a struct and enum. you can use a class to create and instance of that class object, which then gets refered to as an object.",

        "What are Design Patterns? Name one and explain.": "A proven solution to a solving a problem in your apps architecture. Its not code, its a concept/template on how you should go about writing your code. MVP is a design pattern that separates model, view controller",

        "Explain the object?": "Object is an instance of a class. Classes, enums, and structs are object types.",

        "Ways to distribute iOS App": "App Store, Local (own phone)",

        "What is Functional Programming and Functional Reactive Programming?": "Functional Programming is the idea of using first-class functions and higher order functions to write code in a more modular and declarative way. This makes more complex projects easier to manage as it scales and times passes.",
         
         "What is Cocoa and Cocoa Touch?": "Cocoa (for Mac OS) and Cocoa Touch (for iOS) sit on top of other collections of frameworks to create the API stacks. The other layers are Media, Core Services and Core OS. Main difference is the UI classes and APIs they use are different.",
         
         "What are good use cases to use extensions in Swift?": "1. When you want to implement many protocols, use extensions to implement them in separate locations. 2. To preserve you default initializer. 3. To separate state and behavior. 4. group constants, namespace constants",
         
         "What is your understanding of protocol oriented programming?": "Since structs and enums are value types. We rely on POP to allow value types to inherit, extend, and compose these object types."

    ]


}


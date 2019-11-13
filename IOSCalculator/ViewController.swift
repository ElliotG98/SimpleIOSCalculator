//
//  ViewController.swift
//  IOSCalculator
//
//  Created by Elliot Glaze on 09/11/2019.
//  Copyright © 2019 Elliot Glaze. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var runningNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation: Operation = .Null
    
    let topView:UIView = {
        let tv = UIView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .white
        return tv
    }()
    
    let inputTextView: UILabel = {
        let tv = UILabel()
        tv.text = "0"
        tv.textAlignment = .center
        tv.font = UIFont.systemFont(ofSize: 25)
        tv.textColor = .gray
        tv.backgroundColor = .white
        tv.frame.size = CGSize(width: 70, height: 60)
        return tv
    }()
    
    let buttonDictionary1 = [
        1:["AC", UIColor.red],
        2:["/", UIColor.orange]
    ]
    let buttonDictionary2 = [
        3:["7", UIColor.gray],
        4:["8", UIColor.gray],
        5:["9", UIColor.gray],
        6:["*", UIColor.orange]
    ]
    let buttonDictionary3 = [
        7:["4", UIColor.gray],
        8:["5", UIColor.gray],
        9:["6", UIColor.gray],
        10:["-", UIColor.orange]
    ]
    let buttonDictionary4 = [
        11:["1", UIColor.gray],
        12:["2", UIColor.gray],
        13:["3", UIColor.gray],
        14:["+", UIColor.orange]
    ]
    let buttonDictionary5 = [
        15:["0", UIColor.gray],
        16:[".", UIColor.gray],
        17:["=", UIColor.gray]
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    func inputButton(withColor color:UIColor, title: String, width:Int, height:Int) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: CGFloat(width)).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }
    
    
    
    func setupViews() {
        let subStackView1 = rowCreate(arr: buttonDictionary1)
        let subStackView2 = rowCreate(arr: buttonDictionary2)
        let subStackView3 = rowCreate(arr: buttonDictionary3)
        let subStackView4 = rowCreate(arr: buttonDictionary4)
        let subStackView5 = rowCreate(arr: buttonDictionary5)
        
        let stackView = UIStackView(arrangedSubviews: [inputTextView, subStackView1, subStackView2, subStackView3, subStackView4, subStackView5])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        stackView.widthAnchor.constraint(equalToConstant: width).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: height).isActive = true
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func rowCreate(arr: Dictionary<Int, Array<Any>>) -> UIStackView{
        var buttonArray = [UIButton]()
        var w = 0
        let arrSorted = arr.sorted(by: {$0.key < $1.key})
        var alphaVal = 0.4
        
        for (key,val) in arrSorted {
            if arr.count == 2 && key == 1 {
                w = Int(UIScreen.main.bounds.width / 2)
                alphaVal = 1.0
            }else if arr.count == 3 && key == 15 {
                w = Int(UIScreen.main.bounds.width / 2)
            }else {
                w = Int(UIScreen.main.bounds.width / 4)
            }
            
            if key == 2 || key == 6 || key == 10 || key == 14 || key == 17 {
                alphaVal = 1.0
            }
            
            let button = UIButton()
            button.backgroundColor = (val[1] as? UIColor)?.withAlphaComponent(CGFloat(alphaVal))
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: CGFloat(w)).isActive = true
            button.heightAnchor.constraint(equalToConstant: 100).isActive = true
            button.layer.cornerRadius = CGFloat(0.4 * Double(80))
            button.clipsToBounds = true
            if String(describing: val[0]) == "AC" {
                button.addTarget(self, action: #selector(allClearPressed), for: .touchUpInside)
            }else if String(describing: val[0]) == "/" {
                button.addTarget(self, action: #selector(dividePressed), for: .touchUpInside)
            }else if String(describing: val[0]) == "+" {
                button.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
            }else if String(describing: val[0]) == "-" {
                button.addTarget(self, action: #selector(subtractPressed), for: .touchUpInside)
            }else if String(describing: val[0]) == "*" {
                button.addTarget(self, action: #selector(multiplyPressed), for: .touchUpInside)
            }else if String(describing: val[0]) == "." {
                button.addTarget(self, action: #selector(dotPressed), for: .touchUpInside)
            }else if String(describing: val[0]) == "=" {
                button.addTarget(self, action: #selector(equalPressed), for: .touchUpInside)
            }else {
                button.addTarget(self, action: #selector(numberPressed), for: .touchUpInside)
            }
            
            button.setTitle(String(describing: val[0]), for: .normal)
            buttonArray += [button]
        }
        let subStackView = UIStackView(arrangedSubviews: buttonArray)
        subStackView.axis = .horizontal
        subStackView.distribution = .equalSpacing
        subStackView.alignment = .fill
        subStackView.translatesAutoresizingMaskIntoConstraints = false
        subStackView.spacing = 5
        return subStackView
    }
}

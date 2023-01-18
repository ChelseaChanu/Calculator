import UIKit

enum Operation:String{
    case add = "+"
    case subtract = "-"
    case divide = "/"
    case multiply = "*"
    case percent = "%"
    case null = "null"
}

class ViewController: UIViewController {
    var tag = 0
    var currentNumber = ""
    var leftOperand = ""
    var rightOperand = ""
    var result = ""
    var currentOperator:Operation = .null
    var currentString = ""
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let mainStack = UIStackView()
        createStackView(stack: mainStack, axis: .vertical, spacingCount: 0, distribute: .fillEqually, superStack: nil)
        view.addSubview(mainStack)
        mainStack.autoLayout(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: -10), size: .zero)
        
        let subStack1 = UIStackView()
        let subStack2 = UIStackView()
        createStackView(stack: subStack1, axis: nil, spacingCount: 0, distribute: .fillEqually, superStack: mainStack)
        createStackView(stack: subStack2, axis: .vertical, spacingCount: 10, distribute: .fillEqually, superStack: mainStack)
        
        label.text = "0"
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 60)
        label.contentMode = .bottom
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        subStack1.addSubview(label)
        label.autoLayout(top: subStack1.topAnchor, leading: subStack1.leadingAnchor, bottom: subStack1.bottomAnchor, trailing: subStack1.trailingAnchor,padding:.init(top: 20, left: 20, bottom: -20, right: -20), size: .zero)
        
        let stack1 = UIStackView()
        let stack2 = UIStackView()
        let stack3 = UIStackView()
        let stack4 = UIStackView()
        let stack5 = UIStackView()
        let stack6 = UIStackView()
        
        createStackView(stack: stack1, axis: .horizontal, spacingCount: 5, distribute: .equalSpacing, superStack: subStack2)
        createStackView(stack: stack2, axis: .horizontal, spacingCount: 5, distribute: .equalSpacing, superStack: subStack2)
        createStackView(stack: stack3, axis: .horizontal, spacingCount: 5, distribute: .equalSpacing, superStack: subStack2)
        createStackView(stack: stack4, axis: .horizontal, spacingCount: 5, distribute: .equalSpacing, superStack: subStack2)
        createStackView(stack: stack5, axis: .horizontal, spacingCount: 5, distribute: .fillEqually, superStack: subStack2)
        createStackView(stack: stack6, axis: .horizontal, spacingCount: 5, distribute: .equalSpacing, superStack: nil)
        
        let button0 = UIButton()
        let button1 = UIButton()
        let button2 = UIButton()
        let button3 = UIButton()
        let button4 = UIButton()
        let button5 = UIButton()
        let button6 = UIButton()
        let button7 = UIButton()
        let button8 = UIButton()
        let button9 = UIButton()
        let allClear = UIButton()
        let clear = UIButton()
        let percent = UIButton()
        let divide = UIButton()
        let multiply = UIButton()
        let plus = UIButton()
        let subtract = UIButton()
        let dot = UIButton()
        let equal = UIButton()
        
        createButton(button: button0, image: UIImage(named: "0")!, stack: stack5)
        createButton(button: button1, image: UIImage(named: "1")!, stack: stack4)
        createButton(button: button2, image: UIImage(named: "2")!, stack: stack4)
        createButton(button: button3, image: UIImage(named: "3")!, stack: stack4)
        createButton(button: button4, image: UIImage(named: "4")!, stack: stack3)
        createButton(button: button5, image: UIImage(named: "5")!, stack: stack3)
        createButton(button: button6, image: UIImage(named: "6")!, stack: stack3)
        createButton(button: button7, image: UIImage(named: "7")!, stack: stack2)
        createButton(button: button8, image: UIImage(named: "8")!, stack: stack2)
        createButton(button: button9, image: UIImage(named: "9")!, stack: stack2)
        createButton(button: dot, image: UIImage(named: "dot")!, stack: stack6)
        createButton(button: allClear, image: nil, stack: stack1)
        allClear.setTitle("AC", for: .normal)
        allClear.setTitleColor(.systemMint, for: .normal)
        createButton(button: clear, image: UIImage(named: "clear")!, stack: stack1)
        createButton(button: plus, image: UIImage(named: "plus")!, stack: stack4)
        createButton(button: subtract, image: UIImage(named: "substract")!, stack:stack3)
        createButton(button: multiply, image: UIImage(named: "multiply")!, stack: stack2)
        createButton(button: percent, image: UIImage(named: "percent")!, stack: stack1)
        createButton(button: divide, image: UIImage(named: "divide")!, stack: stack1)
        createButton(button: equal, image: UIImage(named: "equal")!, stack: stack6)
        stack5.addArrangedSubview(stack6)
    }
    
    func createStackView(stack: UIStackView, axis:NSLayoutConstraint.Axis?, spacingCount: CGFloat, distribute:UIStackView.Distribution, superStack: UIStackView?){
        stack.distribution = distribute
        if let axis = axis{
            stack.axis = axis
        }
        
        if let superStack = superStack {
            superStack.addArrangedSubview(stack)
        }
        
        stack.spacing = spacingCount
    }
    
    func createButton(button : UIButton, image:UIImage?, stack: UIStackView?){
        if let image = image{
            button.setImage(image, for: .normal)
        }
        stack?.addArrangedSubview(button)
        button.layer.cornerRadius = 10
        button.autoLayout(top: nil, leading: nil, bottom: nil, trailing: nil, padding: .zero, size: .init(width: 80, height:80))
        button.tag = tag
        if(button.tag >= 0) && (button.tag <= 9) {
            button.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
        }
        
        if button.tag == 10{
            button.addTarget(self, action: #selector(dotPressed(_:)), for: .touchUpInside)
        }
        
        if(button.tag == 11){
            button.addTarget(self, action: #selector(allClear(_:)), for: .touchUpInside)
        }
        
        if(button.tag == 12){
            button.addTarget(self, action: #selector(clear(_:)), for: .touchUpInside)
        }
        
        if(button.tag > 12){
            button.addTarget(self, action: #selector(operatorPressed(_:)), for: .touchUpInside)
        }
        
        tag += 1
    }
    
    @objc func numberPressed(_ sender:UIButton){
        if (currentNumber.count <= 9) && (!label.text!.contains("=")){
            currentNumber += "\(sender.tag)"
            currentString = currentNumber
            if(currentOperator != .null){
                currentString = label.text! + "\(sender.tag)"
            }
            
            label.text = currentString
        }
    }
    
    @objc func dotPressed(_ sender:UIButton){
        if (currentNumber.count <= 8) && !currentNumber.contains(".") {
            currentNumber += "."
            label.text = label.text! + "."
        }
    }
    
    @objc func allClear(_ sender:UIButton){
        currentNumber = ""
        leftOperand = ""
        rightOperand = ""
        currentOperator = .null
        result = ""
        label.text = "0"
    }
    
    @objc func clear(_ sender:UIButton){
        if currentNumber.count != 0{
            currentNumber.removeLast()
            label.text = String(label.text!.dropLast(1))
            if(label.text!.isEmpty){
                label.text = "0"
            }
        }
    }
    
    @objc func operatorPressed(_ sender:UIButton){
        if sender.tag == 13{
            if currentOperator == .null{
                if !(label.text?.contains("="))!{
                    label.text = label.text! + "+"
                }
                else{
                    label.text = String(label.text!.dropFirst(2)) + "+"
                }
            }
            else{
                if (label.text?.contains("="))!{
                    label.text = String(label.text!.dropFirst(2)) + "+"
                }
                else{
                    label.text = String(label.text!.dropLast(1)) + "+"
                }
            }
            calculation(operation: .add)
        }
        else if(sender.tag == 14){
            if currentOperator == .null{
                if !(label.text?.contains("="))!{
                    label.text = label.text! + "-"
                }
                else{
                    label.text = String(label.text!.dropFirst(2)) + "-"
                }
            }
            else{
                if (label.text?.contains("="))!{
                    label.text = String(label.text!.dropFirst(2)) + "-"
                }
                else{
                    label.text = String(label.text!.dropLast(1)) + "-"
                }
            }
            calculation(operation: .subtract)
        }
        else if(sender.tag == 15){
            if currentOperator == .null{
                if !(label.text?.contains("="))!{
                    label.text = label.text! + "x"
                }
                else{
                    label.text = String(label.text!.dropFirst(2)) + "x"
                }
            }
            else{
                if (label.text?.contains("="))!{
                    label.text = String(label.text!.dropFirst(2)) + "x"
                }
                else{
                    label.text = String(label.text!.dropLast(1)) + "x"
                }
            }
            calculation(operation: .multiply)
        }
        else if(sender.tag == 16){
            calculation(operation: .percent)
        }
        else if(sender.tag == 17){
            if currentOperator == .null{
                if !(label.text?.contains("="))!{
                    label.text = label.text! + "/"
                }
                else{
                    label.text = String(label.text!.dropFirst(2)) + "/"
                }
            }
            else{
                if (label.text?.contains("="))!{
                    label.text = String(label.text!.dropFirst(2)) + "/"
                }
                else{
                    label.text = String(label.text!.dropLast(1)) + "/"
                }
            }
            calculation(operation: .divide)
        }
        else if (sender.tag == 18){
            calculation(operation: currentOperator)
        }
    }
    
    func calculation(operation: Operation){
        if currentOperator != .null{
            if(currentNumber.isEmpty){
                if(operation == .percent){
                    calculatePercent(left: leftOperand)
                }
            }
            else {
                rightOperand = currentNumber
                label.text = label.text! + currentNumber
                currentNumber = ""
                if currentOperator == .add{
                    result = "\(Double(leftOperand)! + Double(rightOperand)!)"
                }
                else if currentOperator == .subtract{
                    result = "\(Double(leftOperand)! - Double(rightOperand)!)"
                }
                else if currentOperator == .multiply{
                    result = "\(Double(leftOperand)! * Double(rightOperand)!)"
                }
                else if currentOperator == .divide{
                    result = "\(Double(leftOperand)! / Double(rightOperand)!)"
                }
                leftOperand = result
                if(Double(result)!.truncatingRemainder(dividingBy: 1) == 0){
                    result = "\(Int(Double(result)!))"
                }
                
                label.text = "= \(result)"
            }
            currentOperator = operation
        }
        else{
            leftOperand = currentNumber
            currentNumber = ""
            currentOperator = operation
            if(currentOperator == .percent){
                calculatePercent(left: leftOperand)
            }
        }
    }
    
    func calculatePercent(left:String) {
        result = "\(Double(leftOperand)! / 100)"
        if(Double(result)!.truncatingRemainder(dividingBy: 1) == 0){
            result = "\(Int(Double(result)!))"
        }
        
        label.text = "= \(result)"
    }
    
}

extension UIView{
    func autoLayout(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom:NSLayoutYAxisAnchor?, trailing:NSLayoutXAxisAnchor?, padding:UIEdgeInsets = .zero, size:CGSize = .zero){
        
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top{
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading{
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
        
        if let trailing = trailing{
            trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
        }
        
        if size.width != 0{
            widthAnchor.constraint(equalToConstant: size.width).isActive = true;
        }
        
        if size.height != 0{
            heightAnchor.constraint(equalToConstant: size.height).isActive = true;
        }
    }
    
}



//
//  SwiftPage.swift
//  KesihuiDemo
//
//  Created by P on 2024/2/6.
//
// SwiftPage.swift

import UIKit
import SnapKit
import Combine

class SwiftPage: UIViewController {

    var times: [[Int]] = []
    private let numbersSubject = PassthroughSubject<[[Int]], Never>()
    private let resultSubject = PassthroughSubject<Bool, Never>()
    private var cancellables: Set<AnyCancellable> = []

    lazy var outputTextView = UITextView()
    lazy var resultLabel = UILabel()
    lazy var inputField_1 = createInputTextField()
    lazy var inputField_2 = createInputTextField()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hex: "#F4F4F4")

        setupUI()
        setupCombine()
    }

    func setupUI() {


        let label = UILabel()
        label.text =
"""
Given an array of meeting time intervals consisting of start and end times‬
 ‭[[s1,e1],[s2,e2],...]‬‭ (‬‭ si‬‭ < ei‬‭ ),
please provide a function with implementation by Swift/Kotlin‬ to determine if a person could attend all meetings.‬
"""
        label.numberOfLines = 0
        label.backgroundColor = UIColor(hex: "#C8D5BB")
        label.textColor = UIColor(hex: "#8B8B8B")
        view.addSubview(label)
        label.snp.makeConstraints {
            $0.leading.top.equalTo(10)
            $0.trailing.equalToSuperview().offset(-10)
        }

        let addButton = UIButton(type: .contactAdd)
        addButton.tintColor = UIColor(hex: "#C099A0")
        addButton.addAction(UIAction(handler: { a in
            self.didTapAddButton()
        }), for: .touchUpInside)
        view.addSubview(addButton)
        addButton.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.width.height.equalTo(30)
        }

        inputField_1.backgroundColor = UIColor(hex: "#8B8B8B")
        inputField_1.textColor = UIColor(hex: "#D3DCDA")
        view.addSubview(inputField_1)
        inputField_1.snp.makeConstraints {
            $0.top.equalTo(addButton)
            $0.left.equalTo(10)
            $0.height.equalTo(30)
        }

        inputField_2.backgroundColor = UIColor(hex: "#48595D")
        inputField_2.textColor = UIColor(hex: "##E0E0E0")
        view.addSubview(inputField_2)
        inputField_2.snp.makeConstraints {
            $0.top.equalTo(addButton)
            $0.leading.equalTo(inputField_1.snp.trailing).offset(30)
            $0.trailing.equalTo(addButton.snp.leading).offset(-30)
            $0.height.equalTo(30)
            $0.width.equalTo(inputField_1)
        }

        outputTextView.backgroundColor = UIColor(hex: "#C8D5BB")
        view.addSubview(outputTextView)
        outputTextView.snp.makeConstraints {
            $0.top.equalTo(inputField_1.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.height.equalTo(100)
        }

        let resetButton = UIButton(type: .close)
        resetButton.addAction(UIAction(handler: { a in
            self.didTapResetButton()
        }), for: .touchUpInside)
        view.addSubview(resetButton)
        resetButton.snp.makeConstraints {
            $0.bottom.trailing.equalTo(outputTextView).offset(-4)
            $0.width.height.equalTo(30)
        }

        let checkButton = UIButton(type: .roundedRect)
        checkButton.backgroundColor = UIColor(hex: "#4D80E6")
        checkButton.setTitleColor(UIColor(hex: "#C099A0"), for: .normal)
        checkButton.setTitle("Check meeting time intervals", for: .normal)
        checkButton.addAction(UIAction(handler: { a in
            self.didTapCheckButton()
        }), for: .touchUpInside)
        view.addSubview(checkButton)
        checkButton.snp.makeConstraints {
            $0.top.equalTo(outputTextView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
            $0.width.height.equalTo(30)
        }

        resultLabel.textAlignment = . center
        resultLabel.numberOfLines = 0
        resultLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        resultLabel.textColor = UIColor(hex: "#A6A5C4")
        view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(checkButton.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
    }

    private func setupCombine() {
        numbersSubject
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { numbers in
                self.outputTextView.text = numbers.map(String.init).joined(separator: ", ")
            })
            .store(in: &cancellables)

        resultSubject
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {result in
                self.resultLabel.text = result ? "YES, you cloud attend all meeting" : "NO, time intervals conflict"
            })
            .store(in: &cancellables)
    }

    private func createInputTextField() -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }

    private func didTapAddButton() {
        guard let startTime = inputField_1.text,
                let endTime = inputField_2.text else {
            return
        }
        let startTimeNum = Int(startTime) ?? 0
        let endTimeNum = Int(endTime) ?? 0
        if startTimeNum < 0
            || endTimeNum < 0
            || startTimeNum >= endTimeNum {
            view.shake()
            return
        }

        times.append([startTimeNum, endTimeNum])
        numbersSubject.send(times)

        inputField_1.text = ""
        inputField_2.text = ""
    }

    private func didTapResetButton() {
        inputField_1.text = ""
        inputField_2.text = ""
        resultLabel.text = ""
        times = []
        numbersSubject.send(times)
    }

    private func didTapCheckButton() {
        let meetings = times.sorted { $0[0] < $1[0] }
        var result = true
        for i in 0..<meetings.count - 1 {
            let currentMeeting = meetings[i]
            let nextMeeting = meetings[i+1]

            if currentMeeting[1] > nextMeeting[0] {
                result = false
                break
            }
        }

        resultSubject.send(result)
    }
}

extension UIView {
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true

        let fromPoint = CGPoint(x: self.center.x - 5.0, y: self.center.y)
        let toPoint = CGPoint(x: self.center.x + 5.0, y: self.center.y)
        animation.fromValue = NSValue(cgPoint: fromPoint)
        animation.toValue = NSValue(cgPoint: toPoint)

        layer.add(animation, forKey: "position")
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexValue.hasPrefix("#") {
            hexValue.remove(at: hexValue.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}


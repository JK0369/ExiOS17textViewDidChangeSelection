//
//  ViewController.swift
//  ExTextView
//
//  Created by 김종권 on 2023/11/11.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let stackView = {
        let v = UIStackView()
        v.axis = .vertical
        v.backgroundColor = .lightGray
        return v
    }()
    
    private let textView = {
        let v = MyTextView()
        v.text = """
                1 iOS 앱 개발 알아가기 \n 2 iOS 앱 개발 알아가기 \n 3 iOS 앱 개발 알아가기 \n 4 iOS 앱 개발 알아가기 \n
                5 iOS 앱 개발 알아가기 \n 6 iOS 앱 개발 알아가기 \n 7 iOS 앱 개발 알아가기 \n 8 iOS 앱 개발 알아가기 \n
                9 iOS 앱 개발 알아가기 \n 10 iOS 앱 개발 알아가기 \n 11 iOS 앱 개발 알아가기 \n 12 iOS 앱 개발 알아가기 \n
                """
        v.textColor = .black
        v.font = .systemFont(ofSize: 40)
        v.isScrollEnabled = false
        return v
    }()
    private let button = {
        let b = UIButton()
        b.setTitle("button", for: .normal)
        b.setTitleColor(.systemBlue, for: .normal)
        b.setTitleColor(.blue, for: .highlighted)
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(textView)
        stackView.addArrangedSubview(button)
        
        scrollView.snp.makeConstraints {
            $0.horizontalEdges.width.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(100)
        }
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        textView.delegate = self
        textView.selectionCursorBlock = { cursor in
            print(cursor.isOverraped)
            print(cursor.startCursorRect)
            print(cursor.endCursorRect)
        }
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
//        print("range>", textView.selectedRange)
    }
}

class MyTextView: UITextView {
    var selectionCursorBlock: ((CursorEntity) -> ())?
    
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        let ret = super.selectionRects(for: range)
        guard let cursorEntity = CursorEntity(textView: self, range: range) else { return ret }
        selectionCursorBlock?(cursorEntity)
        return ret
    }
}

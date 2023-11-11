//
//  CursorEntity.swift
//  ExTextView
//
//  Created by 김종권 on 2023/11/11.
//

import UIKit

struct CursorEntity {
    let startCursorRect: CGRect
    let endCursorRect: CGRect
    
    init?(textView: UITextView, range: UITextRange) {
        let beginningOfDocument = textView.beginningOfDocument
        
        let start = textView.offset(from: beginningOfDocument, to: range.start)
        let end = textView.offset(from: beginningOfDocument, to: range.end)
        
        guard
            let startPosition = textView.position(from: beginningOfDocument, offset: start),
            let endPosition = textView.position(from: beginningOfDocument, offset: end)
        else { return nil }
        
        startCursorRect = textView.caretRect(for: startPosition)
        endCursorRect = textView.caretRect(for: endPosition)
    }
    
    var isOverraped: Bool {
        startCursorRect == endCursorRect
    }
}

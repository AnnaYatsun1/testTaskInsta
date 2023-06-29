//
//  PlaceholderTextView.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 28.06.2023.
//

import UIKit

class PlaceholderTextView: UITextView, UITextViewDelegate {
    let placeholderText = "Добавте коментарий"

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        text = placeholderText
        textColor = UIColor.lightGray
        delegate = self
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = placeholderText
            textView.textColor = UIColor.lightGray
        }
    }
}

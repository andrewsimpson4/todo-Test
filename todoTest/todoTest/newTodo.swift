//
//  newTodo.swift
//  todoTest
//
//  Created by Andrew Simpson on 4/22/17.
//  Copyright © 2017 Andrew Simpson. All rights reserved.
//

import Foundation
import UIKit


class newTodo
{
    let view = UIView()
    let todoView = UIView()
    let textView = UITextField()
    let addButton = UIButton(type: UIButtonType.custom) as UIButton
    
    let dateView = UIView()
    var dateString = String()
    let datePicker: UIDatePicker = UIDatePicker()
    let segmentedControl = UISegmentedControl()
    let doneButton = UIButton(type: UIButtonType.custom) as UIButton
    
    
    
   
    init(frame:CGRect) {
        self.view.frame = frame
        self.todoView.frame = frame
        self.dateView.frame = frame
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = self.view.frame
        self.view.addSubview(blurView)
        
        
        textView.frame = CGRect(x: 20, y: 70, width: frame.width-40, height: 40)
        textView.borderStyle = .none
        let placeString = "what would you like to do?"
        var placeHolder = NSMutableAttributedString()
        placeHolder = NSMutableAttributedString(string:placeString, attributes: [NSFontAttributeName:UIFont(name: "Helvetica", size: 15.0)!])
        placeHolder.addAttribute(NSForegroundColorAttributeName, value: UIColor.white, range:NSRange(location:0,length:placeString.characters.count))
        textView.attributedPlaceholder = placeHolder
        textView.textAlignment = .center
        textView.textColor = UIColor.white
        textView.becomeFirstResponder()
        
        self.todoView.addSubview(textView)
        self.view.addSubview(todoView)
        
        addButton.frame.size = CGSize(width: self.view.frame.width, height: 50)
        addButton.frame.origin = CGPoint(x: (self.view.frame.width/2)-(addButton.frame.width/2), y: 0)
        addButton.setTitle("next", for: UIControlState.normal)
        addButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        addButton.backgroundColor = UIColor.white
        addButton.addTarget(self, action: #selector(self.addNextButtonPushed(sender:)), for: UIControlEvents.touchUpInside)
        addButton.alpha = 1
        
        self.textView.inputAccessoryView = addButton
       

        
        
    }
    
  
    
    @objc func addNextButtonPushed(sender:UIButton)
    {
        print("pushed in")
        getDate()
    }
    
    
    
    
    
    func getDate()
    {
        
        
        datePicker.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: 200)
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
        datePicker.addTarget(self, action: #selector(self.onDidChangeDate(sender:)), for: .valueChanged)
        self.dateView.addSubview(datePicker)
        
        self.todoView.removeFromSuperview()
        self.view.addSubview(dateView)
        
        
        segmentedControl.insertSegment(withTitle: "!!!", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "!!", at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: "!", at: 3, animated: true)
        segmentedControl.frame = CGRect(x: 10, y: self.datePicker.frame.origin.y + self.datePicker.frame.height + 30, width: self.dateView.frame.width - 20, height: 30)
        segmentedControl.selectedSegmentIndex = 2
        self.dateView.addSubview(segmentedControl)
        
        doneButton.frame.size = CGSize(width: self.view.frame.width, height: 50)
        doneButton.frame.origin = CGPoint(x: (self.view.frame.width/2)-(addButton.frame.width/2), y: segmentedControl.frame.origin.y + segmentedControl.frame.height + 30)
        doneButton.setTitle("add", for: UIControlState.normal)
        doneButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        doneButton.backgroundColor = UIColor.white
        doneButton.addTarget(self, action: #selector(self.done(sender:)), for: UIControlEvents.touchUpInside)
        doneButton.alpha = 1
        self.dateView.addSubview(doneButton)
        
    }
    
    @objc func onDidChangeDate(sender: UIDatePicker) {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        let selectedDate: String = dateFormatter.string(from: sender.date)
        dateString = selectedDate
        
    }
    
    @objc func done(sender:UIButton)
    {
        let todoNew = todo()
        todoNew.todoLabelText = textView.text!
        todoNew.date = dateString
        todoNew.priority = segmentedControl.selectedSegmentIndex
        
        try! realm.write {
            realm.add(todoNew)
        }
        
        main.updateScreen()
        self.view.removeFromSuperview()
        
    }
    
}






















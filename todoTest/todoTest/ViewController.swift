//
//  ViewController.swift
//  todoTest
//
//  Created by Andrew Simpson on 4/22/17.
//  Copyright © 2017 Andrew Simpson. All rights reserved.
//

import UIKit
import RealmSwift
class ViewController: UIViewController, UISearchBarDelegate {
    
    let backImageView = UIImageView()
    let addButton = UIButton(type: UIButtonType.custom) as UIButton
    var openAdd: newTodo!
    var update: updateTodo!
    let segmentedControl = UISegmentedControl()
    let scrollView = UIScrollView()
    var objectInScroll = NSMutableArray()
    var searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setup()
        updateScreen()
    }
    
    
    
    func setup()
    {
        print("in setup!!!")
        for sub in self.view.subviews
        {
            sub.removeFromSuperview()
        }
        main = self
        searchBar.delegate = self
        backImageView.image = UIImage(named: "WA3556POCEANSU.jpg")
        backImageView.frame = self.view.frame
        self.view.addSubview(backImageView)
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = self.view.frame
        self.view.addSubview(blurView)
        
        addButton.frame.size = CGSize(width: 75, height: 75)
        addButton.frame.origin = CGPoint(x: (self.view.frame.width/2)-(addButton.frame.width/2), y: (self.view.frame.height/2)-(addButton.frame.height/2))
        addButton.setImage(UIImage(named: "Untitled41.png"), for: UIControlState.normal)
        addButton.addTarget(self, action: #selector(addButtonPushed(sender:)), for: UIControlEvents.touchUpInside)
        addButton.alpha = 1
        self.view.addSubview(addButton)
        
        segmentedControl.insertSegment(withTitle: "Priority", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Date", at: 1, animated: true)
        segmentedControl.insertSegment(withTitle: "Search", at: 2, animated: true)
        segmentedControl.frame = CGRect(x: 10, y: 20, width: self.view.frame.width-20, height: 30)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(updateScreen), for: .valueChanged)
        self.view.addSubview(segmentedControl)
        
        scrollView.frame = CGRect(x: 0, y: segmentedControl.frame.origin.y + segmentedControl.frame.height + 10, width: self.view.frame.width, height: self.view.frame.height-125)
        
        
        
        
        print("setup done")
        
        
        
        
        
    }
    
    func refresh()
    {
        print("in setup!!!")
        for sub in self.view.subviews
        {
            sub.removeFromSuperview()
        }
        main = self
        searchBar.delegate = self
        backImageView.image = UIImage(named: "WA3556POCEANSU.jpg")
        backImageView.frame = self.view.frame
        self.view.addSubview(backImageView)
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = self.view.frame
        self.view.addSubview(blurView)
        
        addButton.frame.size = CGSize(width: 75, height: 75)
        addButton.frame.origin = CGPoint(x: (self.view.frame.width/2)-(addButton.frame.width/2), y: (self.view.frame.height/2)-(addButton.frame.height/2))
        addButton.setImage(UIImage(named: "Untitled41.png"), for: UIControlState.normal)
        addButton.addTarget(self, action: #selector(addButtonPushed(sender:)), for: UIControlEvents.touchUpInside)
        addButton.alpha = 1
        self.view.addSubview(addButton)
        
        
        self.view.addSubview(segmentedControl)
        
        scrollView.frame = CGRect(x: 0, y: segmentedControl.frame.origin.y + segmentedControl.frame.height + 10, width: self.view.frame.width, height: self.view.frame.height-125)
        
        
        
        
        print("setup done")
 
    }
    
    func addButtonPushed(sender:UIButton)
    {
        openAdd = newTodo(frame: self.view.frame)
        self.view.addSubview(openAdd.view)
        print("pushed")
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateScreen()
    {
        if update != nil
        {
            update.view.removeFromSuperview()
        }
        print("updating Screen")
        for sub in scrollView.subviews
        {
            sub.removeFromSuperview()
        }
        objectInScroll = NSMutableArray()
        let todos = realm.objects(todo.self)
        if todos.count > 0
        {
            
            addButton.frame = CGRect(x: 5, y: self.view.frame.height - 50 - 5, width: 50, height: 50)
            self.view.addSubview(scrollView)
            
            if segmentedControl.selectedSegmentIndex == 0
            {
                scrollView.frame = CGRect(x: 0, y: segmentedControl.frame.origin.y + segmentedControl.frame.height + 10, width: self.view.frame.width, height: self.view.frame.height-125)
                searchBar.removeFromSuperview()
                let todoByP = todos.sorted(byProperty: "priority")
                for todo2 in todoByP
                {
                    
                    print(todo2)
                    let newObject = scrollObjects(text: todo2.todoLabelText, dateText: todo2.date, priorityNum: todo2.priority, parentTodo: todo2)
                    scrollView.addSubview(newObject.view)
                    objectInScroll.add(newObject)
                    
                }
                let last = objectInScroll[objectInScroll.count - 1] as! scrollObjects
                scrollView.contentSize = CGSize(width: self.view.frame.width, height: last.view.frame.origin.y + last.view.frame.height + 100)
            }else if segmentedControl.selectedSegmentIndex == 1
            {
                let todoByP = todos.sorted(byProperty: "date")
                for todo2 in todoByP
                {
                    scrollView.frame = CGRect(x: 0, y: segmentedControl.frame.origin.y + segmentedControl.frame.height + 10, width: self.view.frame.width, height: self.view.frame.height-125)
                    searchBar.removeFromSuperview()
                    let newObject = scrollObjects(text: todo2.todoLabelText, dateText: todo2.date, priorityNum: todo2.priority, parentTodo: todo2)
                    scrollView.addSubview(newObject.view)
                    objectInScroll.add(newObject)
                    
                }
                let last = objectInScroll[objectInScroll.count - 1] as! scrollObjects
                scrollView.contentSize = CGSize(width: self.view.frame.width, height: last.view.frame.origin.y + last.view.frame.height + 100)
            }else if segmentedControl.selectedSegmentIndex == 2
            {
                searchBar.frame = CGRect(x: 0, y: segmentedControl.frame.origin.y + segmentedControl.frame.height+5, width: self.view.frame.width, height: 30)
                self.view.addSubview(searchBar)
                scrollView.frame = CGRect(x: 0, y: segmentedControl.frame.origin.y + segmentedControl.frame.height + 10 + searchBar.frame.height, width: self.view.frame.width, height: self.view.frame.height-125-searchBar.frame.height)
                let todoByP = todos.filter("todoLabelText BEGINSWITH '"+searchBar.text!+"'")
                if todoByP.count > 0
                {
                    for todo2 in todoByP
                    {
                        
                        print(todo2)
                        let newObject = scrollObjects(text: todo2.todoLabelText, dateText: todo2.date, priorityNum: todo2.priority, parentTodo: todo2)
                        scrollView.addSubview(newObject.view)
                        objectInScroll.add(newObject)
                        
                    }
                    let last = objectInScroll[objectInScroll.count - 1] as! scrollObjects
                    scrollView.contentSize = CGSize(width: self.view.frame.width, height: last.view.frame.origin.y + last.view.frame.height + 100)
                }
            }
        }
        
        
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateScreen()
    }
    
    
    
    
}





class scrollObjects
{
    let view = UIView()
    let label = UILabel()
    let date = UILabel()
    let priority = UILabel()
    let parentTodo: todo!
    
    init(text:String,dateText:String,priorityNum:Int, parentTodo:todo) {
        
        self.parentTodo = parentTodo
        if main.objectInScroll.count == 0
        {
            self.view.frame = CGRect(x: 0, y: 0, width: main.view.frame.width, height: 60)
        }else
        {
            let last = main.objectInScroll[main.objectInScroll.count - 1] as! scrollObjects
            self.view.frame = CGRect(x: 0, y: last.view.frame.origin.y + last.view.frame.height + 5, width: main.view.frame.width, height: 60)
        }
        
        self.view.backgroundColor = UIColor.white
        
        label.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        label.text = text
        label.font = UIFont(name: "Helvetica-Light", size: 17)
        label.textAlignment = .left
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.darkGray
        self.view.addSubview(label)
        
        
        date.text = dateText
        date.font = UIFont(name: "Helvetica-Light", size: 14)
        date.sizeToFit()
        date.textAlignment = .right
        date.frame.origin = CGPoint(x: self.view.frame.width - date.frame.width-5, y: 0)
        date.backgroundColor = UIColor.clear
        date.textColor = UIColor.darkGray
        self.view.addSubview(date)
        
        switch priorityNum {
        case 0:
            priority.text = "!!!"
            break
        case 1:
            priority.text = "!!"
            break
        case 2:
            priority.text = "!"
            break
        default:
            priority.text = "!"
        }
        
        priority.font = UIFont(name: "Helvetica-Light", size: 14)
        priority.sizeToFit()
        priority.textAlignment = .right
        priority.frame.origin = CGPoint(x: self.view.frame.width - priority.frame.width-5, y: self.view.frame.height - priority.frame.height)
        priority.backgroundColor = UIColor.clear
        priority.textColor = UIColor.darkGray
        self.view.addSubview(priority)
        
        let longG = UILongPressGestureRecognizer(target: self, action: #selector(longP))
        longG.minimumPressDuration = 0.5
        self.view.addGestureRecognizer(longG)
        
        let doubleG = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        doubleG.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleG)
        
        
        
    }
    
    @objc func longP()
    {
        main.update = updateTodo(frame: main.view.frame, nowTodo: parentTodo)
        main.view.addSubview(main.update.view)
        
        
        
    }
    @objc func doubleTap()
    {
        try! realm.write {
            realm.delete(parentTodo)
        }
        main.updateScreen()
    }
    
    
}








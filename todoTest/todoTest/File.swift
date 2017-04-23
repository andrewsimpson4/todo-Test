//
//  File.swift
//  todoTest
//
//  Created by Andrew Simpson on 4/22/17.
//  Copyright © 2017 Andrew Simpson. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

var todos = NSMutableArray()
let realm = try! Realm()
var main: ViewController!

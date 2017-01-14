//
//  ChannelGuide.swift
//  Seven24
//
//  Created by Sachin Sawant on 14/01/17.
//  Copyright © 2017 Sachin Sawant. All rights reserved.
//

import Foundation

// An ChannelGuide model to store the data list of channels and programs
struct ChannelGuide {
    let channels:[Channel]
}

// A Channel model to store channel properties and programs
struct Channel {
    let id:NSInteger
    let name:String
    let displayOrder:NSInteger
    let programs:[Program]
}

// A Program model and its properties
struct Program {
    let id:NSInteger
    let name:String
    let startTime:Date?
    let endtime:Date?
}

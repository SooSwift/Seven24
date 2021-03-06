//
//  ChannelGuide.swift
//  Seven24
//
//  Created by Sachin Sawant on 14/01/17.
//  Copyright © 2017 Sachin Sawant. All rights reserved.
//

import Foundation

// A ChannelGuide model to store the data list of channels and programs
struct ChannelGuide: Sortable {
    var channels:[Channel]
    
    mutating func sort() {
        var sortedChannels:[Channel] = []
        for var channel in channels {
            channel.sort()
            sortedChannels.append(channel)
        }
        self.channels = sortedChannels.sorted {$0.displayOrder < $1.displayOrder}
    }
}

// A Channel model to store channel properties and programs
struct Channel: Sortable{
    let id:NSInteger
    let name:String
    let displayOrder:NSInteger
    var programs:[Program]
    
    mutating func sort() {
        //Consider program with nil start times
        let programsWithNilStartTime = programs.filter({$0.startTime == nil})
        let programsWithValidStartTime = programs.filter({$0.startTime != nil})
        var sortedPrograms = programsWithValidStartTime.sorted {$0.startTime! < $1.startTime!}
        sortedPrograms.append(contentsOf: programsWithNilStartTime)
        self.programs = sortedPrograms
    }
}

// A Program model and its properties
struct Program {
    let id:NSInteger
    let name:String
    let startTime:Date?
    let endtime:Date?
}


// A Program Rating
enum Rating:Int{
    case NotAvailable = 0
    case Poor = 1
    case Ok = 2
    case Good = 3
    case VeryGood = 4
    case Superb = 5
    
    //Implement description which will return the user rating as String
    var description:String {
        switch self {
        case .NotAvailable: return "Not Available"
        case .Poor: return "Poor"
        case .Ok: return "Ok"
        case .Good: return "Good"
        case .VeryGood: return "Very Good"
        case .Superb: return "Superb"
        }
    }
}


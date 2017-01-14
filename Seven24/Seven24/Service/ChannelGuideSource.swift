//
//  ChannelGuideSource.swift
//  Seven24
//
//  Created by Sachin Sawant on 14/01/17.
//  Copyright © 2017 Sachin Sawant. All rights reserved.
//

import Foundation

protocol ChannelGuideSource {
    func getChannelGuide(fromURLString:String, completion:@escaping (_ success:Bool, _ channelGuide:ChannelGuide?)->Void)
}

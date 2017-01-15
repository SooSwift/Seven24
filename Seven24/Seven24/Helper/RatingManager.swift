//
//  RatingManager.swift
//  Seven24
//
//  Created by Sachin Sawant on 15/01/17.
//  Copyright © 2017 Sachin Sawant. All rights reserved.
//

import Foundation

class RatingManager {
    
    private var ratingDictionary = [String:Any] ()
    
    //MARK:- Singleton Instance
    static let sharedInstance = RatingManager()
    
    init() {
        if let dictionaryFromUserDefaults = UserDefaults.standard.object(forKey: Config.ratingsKey) as? [String:Any] {
            self.ratingDictionary = dictionaryFromUserDefaults
        } else {
            let newRatingsDictionary = [String:Any]()
            UserDefaults.standard.set(newRatingsDictionary, forKey: Config.ratingsKey)
            self.ratingDictionary = newRatingsDictionary
        }
    }
    
    func getRatingFor(channel channelId:Int, program programId:Int) ->Rating {
        let uniqueKey = String(channelId) + String(programId)
        guard let ratingIntger = self.ratingDictionary[uniqueKey] as? Int else {
            return Rating.NotAvailable
        }
        return Rating(rawValue: ratingIntger) ?? Rating.NotAvailable
    }
    
    func setRating(rating:Rating, forChannel channelId:Int, program programId:Int) {
        let uniqueKey = String(channelId) + String(programId)
        self.ratingDictionary[uniqueKey] = rating.rawValue
        UserDefaults.standard.set(self.ratingDictionary, forKey: Config.ratingsKey)
        UserDefaults.standard.synchronize()
    }
    
}

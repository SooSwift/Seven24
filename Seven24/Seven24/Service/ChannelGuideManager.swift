//
//  ChannelGuideManager.swift
//  Seven24
//
//  Created by Sachin Sawant on 14/01/17.
//  Copyright © 2017 Sachin Sawant. All rights reserved.
//

import Foundation

class ChannelGuideManager: ChannelGuideSource {
    
    //MARK:- Public Functions
    func getChannelGuide(fromURLString urlString:String,completion:@escaping (Bool, ChannelGuide?) -> Void) {
        // Check for URL validaty
        guard let url = URL(string: urlString) else {
            print("Unable to create URL instance. Please check URL String")
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Check for valid response
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Unable to receive response from URL \(urlString)")
                completion(false, nil)
                return
            }
            if(httpResponse.statusCode != 200) {
                print("Unexpected http status for URL: \(urlString)")
                completion(false, nil)
                return
            }
            guard error == nil else {
                print("Received error fetching data from URL: \(error)")
                completion(false, nil)
                return
            }
            guard let jsonData = data else {
                print("Failed to receive data")
                completion(false, nil)
                return
            }
            
            // Serialize JSON
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String:AnyObject]else {
                    print("Failed to parse json data")
                    completion(false, nil)
                    return
                }
                
                // Parse JSON
                guard let parsedChannelGuide = self.parseChannelGuideFrom(json: jsonObject) else {
                    print("Failed to parse JSON. Invalid JSON")
                    completion(false, nil)
                    return
                }
                
                completion(true, parsedChannelGuide)
            }
            catch {
                print("Failed to parse json data with error: \(error)")
                completion(false, nil)
                return
            }
        }
        
        dataTask.resume()
    }
    
    // MARK:- Private functions
    private func parseChannelGuideFrom(json jsonObject:[String:AnyObject]) ->ChannelGuide? {
        guard let channelArray = jsonObject["channels"] as? [AnyObject] else {
            return nil
        }
        
        var channels:[Channel] = []
        for channelElement in channelArray {
            guard let channelDictionary = channelElement as? [String:AnyObject] else {
                continue
            }
            
            let id = channelDictionary["channelId"] as? NSInteger ?? 0
            let name = channelDictionary["name"] as? String ?? "UNKNOWN"
            let displayOrder = channelDictionary["displayOrder"] as? NSInteger ?? 0
            
            // A channel can have no programs
            var programs:[Program] = []
            let programArrayKey = channelDictionary["programs"] as? [AnyObject]
            if(programArrayKey != nil) {
                guard let programArray = programArrayKey else {return nil}
                
                for programElement in programArray {
                    guard let programDictionary = programElement as? [String:AnyObject] else {
                        continue
                    }
                    
                    let id = programDictionary["programId"] as? NSInteger ?? 0
                    let name = programDictionary["name"] as? String ?? "UNKNOWN"
                    let startTimeISO = programDictionary["start_time"] as? String ?? ""
                    let endTimeISO = programDictionary["end_time"] as? String ?? ""
                    let startTime = getDateFromISOTimestamp(timestamp: startTimeISO)
                    let endTime = getDateFromISOTimestamp(timestamp: endTimeISO)
                    
                    let program = Program(id: id, name: name, startTime: startTime, endtime: endTime)
                    programs.append(program)
                }
            }
            
            let testProgram = Program(id: 33, name: "Kaun Banega CrorePati", startTime: nil, endtime: nil)
            let testProgram1 = Program(id: 34, name: "This is really a long name what can I tell you about htis", startTime: Date(timeIntervalSince1970: 1483797600), endtime: Date())
            programs.append(testProgram)
            programs.append(testProgram1)
            
            
            let channel = Channel(id: id, name: name, displayOrder: displayOrder, programs: programs)
            channels.append(channel)
        }
        
        return ChannelGuide(channels: channels)
    }
    
    private func getDateFromISOTimestamp(timestamp:String) -> Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.ssZ"
        return dateFormatter.date(from: timestamp)
        
    }
    
}

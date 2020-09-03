//
//  TimeInterval.swift
//  wishlist
//
//  Created by Jerilyn Gonçalves on 30/08/2020.
//  Copyright © 2020 Jerilyn Gonçalves. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    private var seconds: Int {
        return Int(self) % 60 * -1
    }

    private var minutes: Int {
        return (Int(self) / 60 ) % 60 * -1
    }

    private var hours: Int {
        return Int(self) / 3600 * -1
    }
    
    private var days: Int {
        return Int(self) / 3600 / 24 * -1
    }
    
    private var months: Int {
        return Int(self) / 3600 / 24 / 30 * -1
    }
    
    private var years: Int {
        return Int(self) / 3600 / 24 / 365 * -1
    }

    var friendlyString: String {
        if self.years != 0 {
            return "\(self.years) year\(self.years > 1 ? "s" : "") ago"
        } else if self.months != 0 {
            return "\(self.months) month\(self.months > 1 ? "s" : "") ago"
        } else if self.days != 0 {
            return "\(self.days) day\(self.days > 1 ? "s" : "") ago"
        } else if self.hours != 0 {
            return "\(self.hours) hour\(self.hours > 1 ? "s" : "") ago"
        } else if self.minutes != 0 {
            return "\(self.minutes) minute\(self.minutes > 1 ? "s" : "") ago"
        } else {
            return "\(self.seconds) second\(self.seconds > 1 ? "s" : "") ago"
        }
    }
}

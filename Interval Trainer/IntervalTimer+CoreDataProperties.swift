//
//  IntervalTimer+CoreDataProperties.swift
//  Interval Trainer
//
//  Created by Steven on 3/5/19.
//  Copyright © 2019 Steven Santiago. All rights reserved.
//
//

import Foundation
import CoreData


extension IntervalTimer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IntervalTimer> {
        return NSFetchRequest<IntervalTimer>(entityName: "IntervalTimer")
    }

    @NSManaged public var activeTime: Int32
    @NSManaged public var isDefault: Bool
    @NSManaged public var name: String?
    @NSManaged public var restTime: Int32
    @NSManaged public var sets: Int16

}

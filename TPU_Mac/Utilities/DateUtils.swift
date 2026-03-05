//
//  DateUtils.swift
//  TPU_Mac
//
//  Created by ElectricS01  on 5/3/2026.
//

import SwiftUI

enum DateUtils {
  static func dateFormat(_ date: String?) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    
    guard let date = formatter.date(from: date ?? "") else {
      return "Invalid Date"
    }
    
    formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
    return formatter.string(from: date)
  }
  
  static func relativeFormat(_ date: String?) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    
    guard let date = formatter.date(from: date ?? "") else {
      return "Invalid Date"
    }
    
    let relFormatter = RelativeDateTimeFormatter()
    relFormatter.unitsStyle = .full
    return relFormatter.localizedString(for: date, relativeTo: Date.now)
  }
}

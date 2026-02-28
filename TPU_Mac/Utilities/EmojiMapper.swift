//
//  EmojiMapper.swift
//  TPU Mac
//
//  Created by ElectricS01  on 27/2/2026.
//

import Foundation

final class EmojiMapper {
  static let shared = EmojiMapper()
  
  private(set) var map: [String: String] = [:]
  
  private init() {}
  
  func loadIfNeeded() {
    guard map.isEmpty else { return }
    
    DispatchQueue.global(qos: .userInitiated).async {
      guard
        let url = Bundle.main.url(forResource: "emoji", withExtension: "json"),
        let data = try? Data(contentsOf: url),
        let decoded = try? JSONDecoder().decode([String: String].self, from: data)
      else { return }
      
      DispatchQueue.main.async {
        self.map = decoded
      }
    }
  }
}

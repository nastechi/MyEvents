//
//  EventData.swift
//  MyEvents
//
//  Created by Анастасия on 07.02.2023.
//

import Foundation

struct EventData: Decodable {
    let _embedded: Embedded
}

struct Embedded: Decodable {
    let events: [EventItem]
}

struct EventItem: Decodable {
    let name: String
    let type: String
    let images: [ImageData]
    let dates: Dates
}

struct ImageData: Decodable {
    let ratio: String?
    let url: String
}

struct Dates: Decodable {
    let start: Start
}

struct Start: Decodable {
    let localDate: String
    let localTime: String
}

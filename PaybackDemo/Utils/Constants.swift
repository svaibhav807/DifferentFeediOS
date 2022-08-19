//
//  Constants.swift
//  PaybackDemo
//
//

import Foundation

class Constants {
    static let FeedAPI: String = "https://firebasestorage.googleapis.com/v0/b/payback-test.appspot.com/o/feed.json?alt=media&token=3b3606dd-1d09-4021-a013-a30e958ad930"

    // Time after which saved feed model will expire.
    static let feedExpiryDuration: Double =  60 * 60.0 * 24.0
}

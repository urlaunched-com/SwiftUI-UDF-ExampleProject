//
//  Image.swift
//
//
//  Created by Alexander Sharko on 10.11.2022.
//

import SwiftUI

public extension Image {
    static var cameraNormal: Image = .init("camera_normal", bundle: .module)
    static var camera: Image = .init("camera", bundle: .module)
    static var close: Image = .init("close", bundle: .module)
    static var closeNormal: Image = .init("close_normal", bundle: .module)
    static var edit: Image = .init("edit", bundle: .module)
    static var eyeSlash: Image = .init("eye_slash", bundle: .module)
    static var eye: Image = .init("eye", bundle: .module)
    static var filterApplied: Image = .init("filter_applied", bundle: .module)
    static var filter: Image = .init("filter", bundle: .module)
    static var flick: Image = .init("flick", bundle: .module)
    static var frame: Image = .init("frame", bundle: .module)
    static var global: Image = .init("global", bundle: .module)
    static var heartFill: Image = .init("heart_fill", bundle: .module)
    static var heartNormal: Image = .init("heart_normal", bundle: .module)
    static var heart: Image = .init("heart", bundle: .module)
    static var location: Image = .init("location", bundle: .module)
    static var lock: Image = .init("lock", bundle: .module)
    static var logoutRight: Image = .init("logout_right", bundle: .module)
    static var logoutUp: Image = .init("logout_up", bundle: .module)
    static var moneyRecieve: Image = .init("money_recieve", bundle: .module)
    static var moneySend: Image = .init("money_send", bundle: .module)
    static var pencil: Image = .init("pencil", bundle: .module)
    static var playCircle: Image = .init("play_circle", bundle: .module)
    static var receipt: Image = .init("receipt", bundle: .module)
    static var searchFill: Image = .init("search_fill", bundle: .module)
    static var searchNormal: Image = .init("search_normal", bundle: .module)
    static var search: Image = .init("search", bundle: .module)
    static var sms: Image = .init("sms", bundle: .module)
    static var starFill: Image = .init("star_fill", bundle: .module)
    static var star: Image = .init("star", bundle: .module)
    static var starNormal: Image = .init("star_normal", bundle: .module)
    static var subtitle: Image = .init("subtitle", bundle: .module)
    static var title: Image = .init("title", bundle: .module)
    static var tv: Image = .init("tv", bundle: .module)
    static var userCircle: Image = .init("user_circle", bundle: .module)
    static var userSquareFill: Image = .init("user_square_fill", bundle: .module)
    static var userSquare: Image = .init("user_square", bundle: .module)
    static var videoPlayFill: Image = .init("video_play_fill", bundle: .module)
    static var videoPlay: Image = .init("video_play", bundle: .module)
    static var videoTape: Image = .init("video_tape", bundle: .module)
    static var video: Image = .init("video", bundle: .module)
    static var videoNormal: Image = .init("video_normal", bundle: .module)
    static var logoDark: Image = .init("logo_dark", bundle: .module)
    static var logoLight: Image = .init("logo_light", bundle: .module)
    static var authCircles: Image = .init("auth_circles", bundle: .module)
    static var castPlaceholder: Image = .init("cast_placeholder", bundle: .module)
}

public extension Image {
    enum Arrow {
        private init() { fatalError() }
        public static var up: Image = .init("arrow_up", bundle: .module)
        public static var down: Image = .init("arrow_down", bundle: .module)
        public static var left: Image = .init("arrow_left", bundle: .module)
        public static var right: Image = .init("arrow_right", bundle: .module)
    }

    enum Onboarding {
        private init() { fatalError() }
        public static var first: Image = .init("onboarding_first", bundle: .module)
        public static var second: Image = .init("onboarding_second", bundle: .module)
        public static var third: Image = .init("onboarding_third", bundle: .module)
        public static var fourth: Image = .init("onboarding_fourth", bundle: .module)
    }
}

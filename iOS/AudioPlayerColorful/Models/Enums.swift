//
//  Enums.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/8.
//


// a enum,but why?
enum Tab: String, CaseIterable
{
    case home = "主页"
    case order = "报菜名"
    case more = "更多"
    case person = "个人"
}

// MARK: Role List
enum Role: String, CaseIterable, Identifiable {
    case yiji = "一姬"
    case youzi = "柚"
    //case low = "省流量"
    
    var id: String { self.rawValue }
}

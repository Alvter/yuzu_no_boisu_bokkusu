//
//  AudioOrder.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/15.
//

// 定义 AudioOrder 结构体
struct AudioOrder: Decodable {
    let order: [String]
}

// JSON 数据常量
let audioOrderJSON = """
{
  "order": ["lizhi", "yifa", "rong", "bai", "mengqing", "other_audio"]
}
"""

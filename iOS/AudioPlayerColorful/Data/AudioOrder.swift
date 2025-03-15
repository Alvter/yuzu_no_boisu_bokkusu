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
let audioOrderJSON =
"""
{
  "order": ["lizhi","wlizhi","yifa","qianggang","flowerinthehill","moon","fish","menqing","pinghe","yibeikou","erbeikou","sevencouple","white","facai","redmid","eastwind","southwind","westwind","northwind","duanyaojiu","hunquan","yiqi","sansetongshun","sansetongke","sangangzi","duiduihe","sananke","smallsan","hunlaotou","chunquan","hunyi","qingyi","baopai","redbao","dorabbei","insidebao"]
}
"""

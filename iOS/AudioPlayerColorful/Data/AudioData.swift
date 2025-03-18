//
//  AudioData.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/8.
//

import Foundation

// MARK: data
// todo: consider to use localizable string
let allAudioGroups = [
    AudioGroup(
        groupName: NSLocalizedString("リーチ", comment: "立直"),
        items: [
            AudioItem(filename: "lizhi", displayName: NSLocalizedString("リーチ", comment: "立直")),
            AudioItem(filename: "wlizhi", displayName: NSLocalizedString("ダブルリーチ", comment: "双立直")),
            AudioItem(filename: "yifa", displayName: NSLocalizedString("イッパツ", comment: "一发"))
        ]
    ),
    AudioGroup(
        groupName: NSLocalizedString("ヤクハイ", comment: "役牌"),
        items: [
            AudioItem(filename: "eastwind", displayName: NSLocalizedString("トン", comment: "东")),
            AudioItem(filename: "southwind", displayName: NSLocalizedString("ナン", comment: "南")),
            AudioItem(filename: "westwind", displayName: NSLocalizedString("シャ", comment: "西")),
            AudioItem(filename: "northwind", displayName: NSLocalizedString("ペイ", comment: "北")),
            AudioItem(filename: "lianeastwind", displayName: "连东"),
            AudioItem(filename: "liansouthwind", displayName: "连南"),
            AudioItem(filename: "lianwestwind", displayName: "连西"),
            AudioItem(filename: "liannorthwind", displayName: "连北"),
            AudioItem(filename: "white", displayName: NSLocalizedString("ハク", comment: "白")),
            AudioItem(filename: "facai", displayName: NSLocalizedString("ハツ", comment: "发")),
            AudioItem(filename: "redmid", displayName: NSLocalizedString("チュン", comment: "中")),
            AudioItem(filename: "smallsan", displayName: NSLocalizedString("ショウサンゲン", comment: "小三元"))
        ]
    ),
    AudioGroup(
        groupName: NSLocalizedString("幺九", comment: "幺九"),
        items: [
            AudioItem(filename: "duanyaojiu", displayName: NSLocalizedString("タンヤオ", comment: "断幺九")),
            AudioItem(filename: "chunquan", displayName: NSLocalizedString("ジュンチャン", comment: "纯全")),
            AudioItem(filename: "hunquan", displayName: NSLocalizedString("チャンタ", comment: "混全")),
            AudioItem(filename: "hunlaotou", displayName: NSLocalizedString("ホンロウトウ", comment: "混老头"))
        ]
    ),
    AudioGroup(
        groupName: "顺子",
        items:[
            AudioItem(filename: "pinghe", displayName: NSLocalizedString("ピンフ", comment: "平和")),
            AudioItem(filename: "yibeikou", displayName: NSLocalizedString("イーペーコー", comment: "一杯口")),
            AudioItem(filename: "erbeikou", displayName: NSLocalizedString("リャンペーコー", comment: "两杯口")),
            AudioItem(filename: "yiqi", displayName: NSLocalizedString("イッツー", comment: "一气贯通")),
            AudioItem(filename: "sansetongshun", displayName: NSLocalizedString("サンショク", comment: "三色同顺"))
        ]
    ),
    AudioGroup(
        groupName: "刻子",
        items:[
            AudioItem(filename: "sangangzi", displayName: NSLocalizedString("サンカンツ", comment: "三杠子")),
            AudioItem(filename: "sansetongke", displayName: NSLocalizedString("サンドウコウ", comment: "三色同刻")),
            AudioItem(filename: "duiduihe", displayName: NSLocalizedString("トイトイ", comment: "对对和")),
            AudioItem(filename: "sananke", displayName: NSLocalizedString("サンアンコウ", comment: "三暗刻"))
        ]
    ),
    AudioGroup(
        groupName: "宝牌",
        items:[
            AudioItem(filename: "baopai", displayName: "宝牌"),
            AudioItem(filename: "redbao", displayName: NSLocalizedString("赤牌", comment: "红宝牌")),
            AudioItem(filename: "dorabbei", displayName: "拔北宝牌"),
            AudioItem(filename: "insidebao", displayName: "里宝牌")
        ]
    ),
    AudioGroup(
        groupName: "其他",
        items:[
            AudioItem(filename: "menqing", displayName: "门清自摸"),
            AudioItem(filename: "sevencouple", displayName: "七对子"),
            AudioItem(filename: "hunyi", displayName: "混一色"),
            AudioItem(filename: "qingyi", displayName: "清一色"),
            AudioItem(filename: "qianggang", displayName: "抢杠"),
            AudioItem(filename: "flowerinthehill", displayName: "岭上"),
            AudioItem(filename: "moon", displayName: "海底捞月"),
            AudioItem(filename: "fish", displayName: "河底捞鱼")
        ]
    )
]

let smallAudioGroups = [
    AudioGroup(
        groupName: NSLocalizedString("リーチ", comment: "立直"),
        items: [
            AudioItem(filename: "lizhi", displayName: NSLocalizedString("リーチ", comment: "立直")),
            AudioItem(filename: "wlizhi", displayName: NSLocalizedString("ダブルリーチ", comment: "双立直"))
        ]
    ),
    AudioGroup(
        groupName: NSLocalizedString("なき", comment: "鸣牌"),
        items: [
            AudioItem(filename: "chi", displayName:  NSLocalizedString("チー", comment: "吃")),
            AudioItem(filename: "pong", displayName: NSLocalizedString("ポン", comment: "碰")),
            AudioItem(filename: "kang", displayName: NSLocalizedString("カン", comment: "杠")),
            AudioItem(filename: "bbei", displayName: NSLocalizedString("なき", comment: "拔北"))
        ]
    ),
    AudioGroup(
        groupName: NSLocalizedString("和了", comment: "和牌"),
        items: [
            AudioItem(filename: "rong", displayName: NSLocalizedString("栄和", comment: "荣和")),
            AudioItem(filename: "zimo", displayName: NSLocalizedString("自摸和", comment: "自摸"))
        ]
    )
]

//
//  AudioData.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/8.
//

// MARK: data
// todo: consider to use localizable string
let allAudioGroups = [
    AudioGroup(
        groupName: "立直",
        items: [
            AudioItem(filename: "lizhi", displayName: "立直"),
            AudioItem(filename: "wlizhi", displayName: "双立直"),
            AudioItem(filename: "yifa", displayName: "一发")
        ]
    ),
    AudioGroup(
        groupName: "役牌",
        items: [
            AudioItem(filename: "eastwind", displayName: "东风"),
            AudioItem(filename: "southwind", displayName: "南风"),
            AudioItem(filename: "westwind", displayName: "西风"),
            AudioItem(filename: "northwind", displayName: "北风"),
            AudioItem(filename: "lianeastwind", displayName: "连东"),
            AudioItem(filename: "liansouthwind", displayName: "连南"),
            AudioItem(filename: "lianwestwind", displayName: "连西"),
            AudioItem(filename: "liannorthwind", displayName: "连北"),
            AudioItem(filename: "white", displayName: "白"),
            AudioItem(filename: "facai", displayName: "发"),
            AudioItem(filename: "redmid", displayName: "中"),
            AudioItem(filename: "smallsan", displayName: "小三元")
        ]
    ),
    AudioGroup(
        groupName: "幺九",
        items: [
            AudioItem(filename: "duanyaojiu", displayName: "断幺九"),
            AudioItem(filename: "chunquan", displayName: "纯全"),
            AudioItem(filename: "hunquan", displayName: "混全"),
            AudioItem(filename: "hunlaotou", displayName: "混老头")
        ]
    ),
    AudioGroup(
        groupName: "顺子",
        items:[
            AudioItem(filename: "pinghe", displayName: "平和"),
            AudioItem(filename: "yibeikou", displayName: "一杯口"),
            AudioItem(filename: "erbeikou", displayName: "二杯口"),
            AudioItem(filename: "yiqi", displayName: "一气通贯"),
            AudioItem(filename: "sansetongshun", displayName: "三色同顺")
        ]
    ),
    AudioGroup(
        groupName: "刻子",
        items:[
            AudioItem(filename: "sangangzi", displayName: "三杠子"),
            AudioItem(filename: "sansetongke", displayName: "三色同刻"),
            AudioItem(filename: "duiduihe", displayName: "对对和"),
            AudioItem(filename: "sananke", displayName: "三暗刻")
        ]
    ),
    AudioGroup(
        groupName: "宝牌",
        items:[
            AudioItem(filename: "baopai", displayName: "宝牌"),
            AudioItem(filename: "redbao", displayName: "红宝牌"),
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
        groupName: "立直",
        items: [
            AudioItem(filename: "lizhi", displayName: "立直"),
            AudioItem(filename: "wlizhi", displayName: "双立直")
        ]
    ),
    AudioGroup(
        groupName: "鸣牌",
        items: [
            AudioItem(filename: "chi", displayName: "吃"),
            AudioItem(filename: "pong", displayName: "碰"),
            AudioItem(filename: "kang", displayName: "杠"),
            AudioItem(filename: "bbei", displayName: "拔北")
        ]
    ),
    AudioGroup(
        groupName: "和牌",
        items: [
            AudioItem(filename: "rong", displayName: "荣和"),
            AudioItem(filename: "zimo", displayName: "自摸")
        ]
    )
]

//
//  OrderViewModel.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/24.
//

import Combine
import SwiftUI

class OrderViewModel: ObservableObject
{
    @Published private var southWindTapCount = 0
    @Published var showingEasterEgg = false // 需要发布这个状态

    let tapInterval: TimeInterval = 1.0
    var timer: Timer? = nil

    func handleSouthWindTap()
    {
        timer?.invalidate()
        print("计时器已停止")

        southWindTapCount += 1
        print("计数器增加到: \(southWindTapCount)")

        timer = Timer.scheduledTimer(withTimeInterval: tapInterval, repeats: false)
        {
            _ in
            self.southWindTapCount = 0
            print("计时器结束，计数器重置为: \(self.southWindTapCount)")
        }

        if southWindTapCount >= 10
        {
            showingEasterEgg = true
            print("达到彩蛋触发条件，显示 EasterEggView")
            timer?.invalidate()
            print("彩蛋触发，计时器已停止")
            southWindTapCount = 0 // 手动重置计数器
            print("彩蛋触发，计数器重置为: \(self.southWindTapCount)")
        }
    }
}

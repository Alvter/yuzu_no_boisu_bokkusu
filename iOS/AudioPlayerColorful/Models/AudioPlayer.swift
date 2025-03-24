//
//  AudioPlayer.swift
//  AudioPlayerColorful
//
//  Created by 四月初一茶染绮良 on 2025/3/8.
//

import SwiftUI
import AVFoundation

class AudioPlayer: NSObject, ObservableObject
{
    // MARK: some variables
    private var player :AVAudioPlayer?
    @Published var isPlaying = false
    private var players: [String: (player: AVAudioPlayer, shouldReset: Bool)] = [:]
    private var shouldResetPlayback = false // Reset Sysbolm
    private var playQueue: [String] = []
    private var isQueuePlaying = false
    @Published var currentRole: String? // 添加当前角色属性
    @Published var currentPlaying: String?  // put the current playing file name here()
    {
        didSet
        {
            if isPlaying
            {
                guard player?.isPlaying == true
                else
                {
                    isPlaying = false
                    return
                }
            }
            else
            {
                guard player?.isPlaying == false
                else
                {
                    isPlaying = true
                    return
                }
            }
        }
    }
    
    // MARK: play control
    func togglePlayback(for filename: String)
    {
        DispatchQueue.main.async
        {
            // stop other playback
            if let current = self.currentPlaying, current != filename
            {
                self.stopPlayback(for: current)
            }
            if self.isPlaying(filename: filename)
            {
                self.pausePlayback(for: filename)
            }
            else
            {
                self.startPlayback(for: filename)
            }
        }
    }
    
    // MARK: start playback queue
    func startPlaybackQueue(for filenames: [String], roleName: String) {
        playQueue = filenames
        currentRole = roleName // 保存当前角色
        isQueuePlaying = true
        playNext()
    }

    // MARK: Next play
        func playNext() {
            guard !playQueue.isEmpty else {
                isQueuePlaying = false
                return
            }
            let filename = playQueue.removeFirst()
            startPlayback(for: filename)
        }
    
    func loadAudioIfNeeded(_ filename: String) {
        guard players[filename] == nil else { return }

        // 使用角色名前缀构建完整的文件名
        let fullFilename = filename // 已经包含了角色名前缀

        guard let url = Bundle.main.url(forResource: fullFilename, withExtension: "mp3") else {
            print("Audio file not found: \(fullFilename)")
            return
        }

        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.delegate = self
            players[filename] = (player: player, shouldReset: true) // initialize player and set shouldReset to true
        } catch {
            print("Audio player initialization failed: \(error)")
        }
    }
    
    // MARK: handle playback interruption
    func handlePlaybackInterruption()
    {
        player?.pause()
        isPlaying = false
        shouldResetPlayback = true // set reset symbol
    }
    
    // MARK: start playback
        func startPlayback(for filename: String) {
            loadAudioIfNeeded(filename)

            guard let playerInfo = players[filename] else { return }
            let player = playerInfo.player // get player

            do {
                #if os(iOS)
                try AVAudioSession.sharedInstance().setActive(true)
                #endif

                if playerInfo.shouldReset || player.currentTime >= player.duration {
                    player.currentTime = 0
                    players[filename]?.shouldReset = false
                }

                player.play() // call play method
                currentPlaying = filename
            } catch {
                print("Playback failed: \(error)")
                currentPlaying = nil
            }
        }
    
    override init() {
            super.init()
            setupAudioSession()
            setupInterruptionObserver()
        }
    
    // MARK: set interruption observer in iOS
    func setupInterruptionObserver()
    {
        #if os(iOS)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleInterruption),
            name: AVAudioSession.interruptionNotification,
            object: nil
        )
        #endif
    }

    
    // MARK: handle interruption in iOS
    #if os(iOS)
    @objc private func handleInterruption(notification: Notification)
    {
        guard let userInfo = notification.userInfo,
        let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
        let type = AVAudioSession.InterruptionType(rawValue: typeValue) else { return }

        switch type
        {
        case .began:
        if let current = currentPlaying
        {
            pausePlayback(for: current)
            // the symbol needs to be reset
            players[current]?.shouldReset = true
        }
        case .ended:
           break
        @unknown default:
           break
        }
    }
    #endif

    // MARK: setup audio session
    func setupAudioSession()
    {
        #if os(iOS)
        do
        {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch
        {
            print("Audio session setup failed: \(error)")
        }
        #endif
    }
    
    // MARK: pause playback
    func pausePlayback(for filename: String)
    {
        players[filename]?.player.pause()
        currentPlaying = nil
        players[filename]?.shouldReset = true
    }

    // MARK: stop playback
    func stopPlayback(for filename: String)
    {
        players[filename]?.player.stop()
        players[filename]?.player.currentTime = 0
        currentPlaying = nil
        players[filename]?.shouldReset = true // update reset symbol
    }

    // MARK: check if is playing
    func isPlaying(filename: String) -> Bool
    {
        return currentPlaying == filename && players[filename]?.player.isPlaying == true
    }
}

// MARK: AVAudioplayerDelegate
extension AudioPlayer: AVAudioPlayerDelegate
{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
        DispatchQueue.main.async
        {
            if let filename = self.players.first(where: { $0.value.player == player })?.key
            {
                self.stopPlayback(for: filename)
                self.players[filename]?.shouldReset = true // update reset symbol
                
                if self.isQueuePlaying
                {
                    self.playNext()
                }
            }
        }
    }
}

//
//  ACountdown.swift
//
//  Created by Moises Lozada on 3/4/18.
//

import Foundation

/// Class that can trigger a callback after a addable amount of time
final class ACountdown{
    
    /// Underlying timer class
    private var timer: Timer = Timer.init()
    
    /// Action to perform whenever the counter hits 0.0
    var action:(()->())? = nil
    
    /// Get the current vaue of the counter
    private(set) var time: TimeInterval = 0.0{
        didSet{
            print("Time: \(time)")
            if time <= 0{
                action?()
                timer.invalidate()
            }
        }
    }
    
    /// Countdown's precision in seconds
    var precision: TimeInterval = 0.5
    
    /// Initializes a new addable countdown object
    ///
    /// - Parameter action: what to do when the countdown reaches 0
    init(action:@escaping ()->()){
        self.action = action
    }
    
    /// Adds time to the current countdown
    ///
    /// - Parameter time: The ammount of time to add
    func add(time:TimeInterval){
        self.time += time
    }
    
    /// Sets a specific value for the current countdown
    ///
    /// - Parameter time: The ammount of time to set
    func set(time:TimeInterval){
        self.time = time
    }
    
    /// Fires or resumes the countdown
    func fire(){
        if #available(iOS 10.0, *) {
            self.timer = Timer.scheduledTimer(withTimeInterval: precision, repeats: true) {[weak self] (_) in
                self?.time = (self?.time ?? 0) - (self?.precision ?? 1)
            }
        }
        timer.fire()
    }
    
    /// Stops the countdown
    func stop(){
        timer.invalidate()
        self.time = 0
    }
    
    /// Pauses the countdown
    func pause(){
        timer.invalidate()
    }
}

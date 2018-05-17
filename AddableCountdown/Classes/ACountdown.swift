//
//  ACountdown.swift
//
//  Created by Moises Lozada on 3/4/18.
//

import Foundation

/// Class that can trigger a callback after a addable amount of time
public final class ACountdown{
    
    /// Underlying timer class
    private var timer: Timer = Timer.init()
    
    /// Action to perform whenever the counter hits 0.0
    public var action:(()->())? = nil
    
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
    public var precision: TimeInterval = 0.5
    
    /// Initializes a new addable countdown object
    ///
    /// - Parameter action: what to do when the countdown reaches 0
    public init(action:@escaping ()->()){
        self.action = action
    }
    
    /// Adds time to the current countdown
    ///
    /// - Parameter time: The ammount of time to add
    public func add(time:TimeInterval){
        self.time += time
    }
    
    /// Sets a specific value for the current countdown
    ///
    /// - Parameter time: The ammount of time to set
    public func set(time:TimeInterval){
        self.time = time
    }
    
    /// Fires or resumes the countdown
    public func fire(){
        if #available(iOS 10.0, *) {
            self.timer = Timer.scheduledTimer(withTimeInterval: precision, repeats: true) {[weak self] (_) in
                self?.time = (self?.time ?? 0) - (self?.precision ?? 1)
            }
        }
        timer.fire()
    }
    
    /// Stops the countdown
    public func stop(){
        timer.invalidate()
        self.time = 0
    }
    
    /// Pauses the countdown
    public func pause(){
        timer.invalidate()
    }
}

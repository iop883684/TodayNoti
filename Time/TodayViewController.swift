import Cocoa
import NotificationCenter

public class TodayViewController: NSViewController, NCWidgetProviding {
    
    var count = 0
    
    private lazy var timer: DispatchSourceTimer = {
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        timer.schedule(wallDeadline: .now() + Date().nearestMinute().timeIntervalSinceNow,
                          repeating: 10.0)
        timer.setEventHandler { [weak self] in
            self?.tick()
        }
        return timer
    }()
    
    @IBOutlet var clock: NSTextField!
    @IBOutlet var aux: NSTextField!
    
    public override var nibName: NSNib.Name? {
        return NSNib.Name(rawValue: "TodayViewController")
    }
    
    public var widgetAllowsEditing: Bool {
        return false
    }
    
    public override func viewDidAppear() {
        super.viewDidAppear()
        self.timer.resume()
        showNotification(dateStr: "view did appear")
        tick()
    }
    
    public func widgetPerformUpdate(completionHandler: @escaping (NCUpdateResult) -> Void) {
        tick()
        completionHandler(.newData)
    }
    
    //update Label
    
    @objc func tick() {
        
        print(Date())
        
        let dateStr = DateFormatter.localizedString(from: Date(),
                                                    dateStyle: .none,
                                                    timeStyle: .short)
        self.clock.stringValue = dateStr
        self.aux.stringValue = TimeZone.current.abbreviation()!
        
        count += 1
        if count%2 == 0{
            DispatchQueue.main.async {
                self.showNotification(dateStr: dateStr)
            }
            
        }
        
    }
    
    func showNotification(dateStr:String) -> Void {
        
        print("let show noti")
        let notification = NSUserNotification()
        
        notification.title = "Bây giờ là \(dateStr)"
        notification.informativeText = "Nhìn ra xa để tránh mỏi mắt"
        notification.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.deliver(notification)
    }
    
    
    func userNotificationCenter(_ center: NSUserNotificationCenter,
                                shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
}

public extension Date {
    public func nearestMinute() -> Date {
        let c = Calendar.current
        var next = c.dateComponents(Set<Calendar.Component>([.minute]), from: self)
        next.minute = (next.minute ?? -1) + 1
        return c.nextDate(after: self, matching: next, matchingPolicy: .strict) ?? self
    }
}

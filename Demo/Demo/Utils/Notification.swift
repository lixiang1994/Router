import Foundation

extension NotificationCenter {
    
    enum Delegate: Notificationable {
        enum defaultKeys: String {
            case launched
        }
    }
}

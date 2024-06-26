//
//  AppLApp.swift
//  AppL
//
//  Created by Víctor Varillas Ledesma on 20/3/24.
//

import SwiftUI
import Cocoa
import AppKit

@main
struct AppLApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var Delegate
    
    init() {
        // Inject dependencies
        Resolver.shared.injectModules()
    }

    var body: some Scene {
        Settings {
          SettingsView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {

    private var window: NSWindow!
    private var statusItem: NSStatusItem!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let window = NSApplication.shared.windows.first {
            window.close()
        }
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "book.pages", accessibilityDescription: "1")
        }
        // Setup status bar options
        setupMenus()
        
        // Setup restart on crash just in case the app crashes
        restartOnCrash()
    }
    
    
    // MARK: - Setup menus -
    func setupMenus() {
        let menu = NSMenu()

        let comics = NSMenuItem(title: "comics".localized(), action: #selector(didTapComics) , keyEquivalent: "1")
        menu.addItem(comics)
        
        let settings = NSMenuItem(title: "settings".localized(), action: #selector(didTapSettings) , keyEquivalent: "2")
        menu.addItem(settings)

        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "quit".localized(), action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))

        statusItem.menu = menu
    }
    
    private func changeStatusBarButton(number: Int) {
        if let button = statusItem.button {
            switch number {
            case 1:
                button.image = NSImage(systemSymbolName: "book.pages", accessibilityDescription: "comics")
            default:
                button.image = NSImage(systemSymbolName: "gear", accessibilityDescription: "settings")
            }
            
        }
    }

    @objc func didTapComics() {
        changeStatusBarButton(number: 1)
        let detailView = ComicsView();
         let controller = DetailWindowController(rootView: detailView)
         controller.window?.title = "comics".localized();
         controller.showWindow(nil)
        
        NSApp.setActivationPolicy(.regular)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    @objc func didTapSettings() {
        changeStatusBarButton(number: 2)
        let settingsView = SettingsView();
         let controller = DetailWindowController(rootView: settingsView)
         controller.window?.title = "settings".localized();
         controller.showWindow(nil)
        
        NSApp.setActivationPolicy(.regular)
        NSApp.activate(ignoringOtherApps: true)
    }
}

class DetailWindowController<RootView : View>: NSWindowController {
    convenience init(rootView: RootView) {
        let hostingController = NSHostingController(rootView: rootView.frame(width: 400, height: 500))
        let window = NSWindow(contentViewController: hostingController)
        window.setContentSize(NSSize(width: 400, height: 500))
        self.init(window: window)
    }
}

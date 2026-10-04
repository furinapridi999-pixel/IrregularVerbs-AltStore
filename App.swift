import SwiftUI
import WebKit

@main
struct IrregularVerbsApp: App {
    var body: some Scene {
        WindowGroup {
            VerbsWebView().ignoresSafeArea()
        }
    }
}

/// Saves the lesson progress coming from JavaScript into UserDefaults.
final class ProgressBridge: NSObject, WKScriptMessageHandler {
    static let key = "irrverbs-state"
    func userContentController(_ controller: WKUserContentController, didReceive message: WKScriptMessage) {
        if let json = message.body as? String {
            UserDefaults.standard.set(json, forKey: Self.key)
        }
    }
}

struct VerbsWebView: UIViewRepresentable {
    private let bridge = ProgressBridge()

    func makeUIView(context: Context) -> WKWebView {
        let controller = WKUserContentController()
        controller.add(bridge, name: "save")

        // Hand the saved progress to the page before its script runs.
        let saved = UserDefaults.standard.string(forKey: ProgressBridge.key) ?? "null"
        let literal = (try? String(data: JSONEncoder().encode(saved), encoding: .utf8)) ?? "\"null\""
        controller.addUserScript(WKUserScript(
            source: "window.__NATIVE_STATE = \(literal);",
            injectionTime: .atDocumentStart,
            forMainFrameOnly: true))

        let config = WKWebViewConfiguration()
        config.userContentController = controller
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.isOpaque = false
        webView.backgroundColor = .systemBackground
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.scrollView.bounces = false

        if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

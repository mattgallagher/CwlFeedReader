import SwiftUI
import WebKit

#if canImport(UIKit)
	import UIKit
	typealias PlatformViewRepresentable = UIViewRepresentable
#elseif canImport(AppKit)
	import AppKit
	typealias PlatformViewRepresentable = NSViewRepresentable
#endif

public struct WebView: PlatformViewRepresentable {
	public enum Content: Equatable {
		case string(String)
		case data(Data, String, URL)
		case url(URL)
	}

	let content: Content

	public init(content: Content) {
		self.content = content
	}

	#if canImport(UIKit)
		public func makeUIView(context _: UIViewRepresentableContext<WebView>) -> WKWebView {
			return WrappedWebView(frame: .zero, configuration: WKWebViewConfiguration())
		}

		public func updateUIView(_ uiView: WKWebView, context _: UIViewRepresentableContext<WebView>) {
			(uiView as? WrappedWebView)?.content = content
		}
	#elseif canImport(AppKit)
		public func makeNSView(context _: NSViewRepresentableContext<WebView>) -> WKWebView {
			return WrappedWebView(frame: .zero, configuration: WKWebViewConfiguration())
		}

		public func updateNSView(_ nsView: WKWebView, context _: NSViewRepresentableContext<WebView>) {
			(nsView as? WrappedWebView)?.content = content
		}
	#endif
}

class WrappedWebView: WKWebView {
	var content: WebView.Content = .string("") {
		didSet {
			guard oldValue != content else {
				return
			}
			switch content {
			case let .string(string): loadHTMLString(string, baseURL: nil)
			case let .data(data, mimeType, baseURL): load(data, mimeType: mimeType, characterEncodingName: "utf-8", baseURL: baseURL)
			case let .url(url): load(URLRequest(url: url))
			}
		}
	}
}

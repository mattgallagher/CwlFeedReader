import SwiftUI
import WebKit

#if canImport(UIKit)
	
	import UIKit
	
	public struct WebView: UIViewRepresentable {
		let content: String
		
		public init(content: String) {
			self.content = content
		}
		
		public func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
			return WrappedWebView(frame: .zero, configuration: WKWebViewConfiguration(), content: content)
		}
		
		public func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
			uiView.loadHTMLString(content, baseURL: nil)
		}
	}
	
#elseif canImport(AppKit)
	
	import AppKit
	
	public struct WebView: NSViewRepresentable {
		let content: String
		
		public init(content: String) {
			self.content = content
		}
		
		public func makeNSView(context: NSViewRepresentableContext<WebView>) -> WKWebView {
			return WrappedWebView(frame: .zero, configuration: WKWebViewConfiguration(), content: content)
		}
		
		public func updateNSView(_ nsView: WKWebView, context: NSViewRepresentableContext<WebView>) {
			nsView.loadHTMLString(content, baseURL: nil)
		}
	}
	
#endif

class WrappedWebView: WKWebView {
	var content: String {
		didSet {
			guard oldValue != content else {
				return
			}
			loadHTMLString(content, baseURL: nil)
		}
	}
	
	init(frame: CGRect, configuration: WKWebViewConfiguration, content: String) {
		self.content = content
		super.init(frame: frame, configuration: configuration)
		loadHTMLString(content, baseURL: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

import SwiftUI

#if canImport(UIKit)
	public typealias DisplayMode = NavigationBarItem.TitleDisplayMode
#else
	public enum DisplayMode {
		case inline
	}
#endif

public extension View {
	func navigationBarTitleDisplayModeIfAvailable(_ displayMode: DisplayMode) -> some View {
		#if canImport(UIKit)
			return navigationBarTitleDisplayMode(displayMode)
		#else
			return self
		#endif
	}
	
	#if !canImport(UIKit)
		func navigationBarItems<Item: View>(trailing: Item) -> some View {
			return toolbar {
				ToolbarItem {
					trailing
				}
			}
		}
	#endif
}

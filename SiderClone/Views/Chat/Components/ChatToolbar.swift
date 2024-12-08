import SwiftUI

struct ChatToolbar: View {
    let onClear: () -> Void
    let onShare: () -> Void
    
    var body: some View {
        HStack {
            Button {
                onClear()
            } label: {
                Image(systemName: "trash")
            }
            
            Button {
                onShare()
            } label: {
                Image(systemName: "square.and.arrow.up")
            }
        }
    }
}
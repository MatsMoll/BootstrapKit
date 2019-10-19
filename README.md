# BootstrapKit

An extension on HTMLKit, that simplefies the use of Bootstrap 4 classes.

This can result in a HTML template looking like this:
```swift
struct CopyrightFooter: StaticView {

    struct AnchorInfo {
        let link: String
        let title: String
    }
    
    let links: [AnchorInfo] = [
        .init(link: "#", title: "About Us"),
        .init(link: "#", title: "Help"),
        .init(link: "#", title: "Contact Us"),
    ]  

    var body: View {
        Footer {
            Container(mode: .fluid) {
                Row {
                    Div {
                        "Copyright"
                    }
                    .columnWidth(6, for: .medium)
                    Div {
                        Div {
                            ForEach(in: links) { link in
                                Anchor {
                                    link.title
                                }
                                .href(link.link)
                            }
                        }
                        .text(alignment: .right)
                        .display(.block, for: .medium)
                        .display(.none)
                        .class("footer-links")
                    }
                    .columnWidth(6, for: .medium)
                }
            }
        }.class("footer")
    }
}
```

If only HTMLKit is used, then all the helper functions like `.text(alignment: ...)` would be replaced by `.class("some class")`. This is therefore more typesafe and readable.  

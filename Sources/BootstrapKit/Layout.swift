import HTMLKit

public struct BootstrapPage : StaticView {

    let content: View

    public init(@HTMLBuilder content: () -> View) {
        self.content = content()
    }

    public var body: View {
        HTMLNode {
            Head {
                Link()
                    .relationship("stylesheet")
                    .href("https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css")
            }
            Body {
                content
                Script().source("https://code.jquery.com/jquery-3.3.1.slim.min.js")
                Script().source("https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js")
                Script().source("https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js")
            }
        }
    }
}

public enum SizeClass : String {
    case small = "sm"
    case extraSmall = "xs"
    case medium = "md"
    case large = "lg"
    case extraLarge = "xl"
    case all = ""
}

public enum Direction : String {
    case top = "t"
    case bottom = "b"
    case left = "l"
    case right = "r"
}

extension GlobalAttributes {
    public func columnWidth(_ width: Int, for sizeClass: SizeClass = .all) -> Self {
        switch sizeClass {
        case .all:  return self.class("col-\(width)")
        default:    return self.class("col-\(sizeClass.rawValue)-\(width)")
        }
    }

    public func textAlignment(_ alignment: Text.Alignment) -> Self {
        self.class("text-\(alignment.rawValue)")
    }

    public func margin(_ direction: Direction, size: Int, sizeClass: SizeClass = .all) -> Self {
        sizeClass == .all ? self.class("m\(direction.rawValue)-\(size)") : self.class("m\(direction.rawValue)-\(size)-\(sizeClass.rawValue)")
    }

    public func padding(_ direction: Direction, size: Int, sizeClass: SizeClass = .all) -> Self {
        sizeClass == .all ? self.class("p\(direction.rawValue)-\(size)") : self.class("p\(direction.rawValue)-\(size)-\(sizeClass.rawValue)")
    }
}

public struct Container : StaticView, AttributeNode {

    public enum Mode : String {
        case fluid = "-fluid"
        case snap = ""
    }

    public var attributes: [HTML.Attribute]
    let mode: Mode
    let content: View

    public init(mode: Mode = .snap, @HTMLBuilder content: () -> View) {
        self.mode = mode
        self.attributes = []
        self.content = content()
    }

    init(mode: Mode, attributes: [HTML.Attribute] = [], content: View) {
        self.mode = mode
        self.attributes = attributes
        self.content = content
    }

    public var body: View {
        Div { content }
            .class("container" + mode.rawValue)
            .add(attributes: attributes)
    }

    public func copy(with attributes: [HTML.Attribute]) -> Container {
        .init(mode: mode, attributes: attributes, content: content)
    }
}

public struct Row : StaticView, AttributeNode {

    public var attributes: [HTML.Attribute]
    let content: View

    public init(@HTMLBuilder content: () -> View) {
        self.content = content()
        self.attributes = []
    }

    init(attributes: [HTML.Attribute], content: View) {
        self.attributes = attributes
        self.content = content
    }

    public var body: View {
        Div { content }
            .class("row")
            .add(attributes: attributes)
    }

    public func copy(with attributes: [HTML.Attribute]) -> Row {
        .init(attributes: attributes, content: content)
    }
}


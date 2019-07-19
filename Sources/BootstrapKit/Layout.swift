import HTMLKit

public enum SizeClass : String {
    case small = "sm"
    case extraSmall = "xs"
    case medium = "md"
    case large = "lg"
    case extraLarge = "xl"
    case all = ""
}

extension AttributeNode {
    public func columnWidth(_ width: Int, for sizeClass: SizeClass = .all) -> Self {
        switch sizeClass {
        case .all:  return self.class("col-\(width)")
        default:    return self.class("col-\(sizeClass.rawValue)-\(width)")
        }
    }
    
    public func textAlignment(_ alignment: Text.Alignment) -> Self {
        self.class("text-\(alignment.rawValue)")
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


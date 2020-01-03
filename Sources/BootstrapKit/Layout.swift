import HTMLKit

public struct BootstrapPage : HTMLComponent {

    let content: HTML

    public init(@HTMLBuilder content: () -> HTML) {
        self.content = content()
    }

    public var body: HTML {
        HTMLNode {
            Head {
                Link()
                    .relationship(.stylesheet)
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

public enum SizeClass: String {
    case small = "sm"
    case extraSmall = "xs"
    case medium = "md"
    case large = "lg"
    case extraLarge = "xl"
    case all = ""
}

public enum Direction: String {
    case top = "t"
    case bottom = "b"
    case left = "l"
    case right = "r"
    case horizontal = "x"
    case vertical = "y"
    case all = ""
}

public enum Display: String {
    case none
    case block
    case inline
    case inlineBlock = "inline-block"
    case inlineFlex = "inline-flex"
    case flex
    case table
    case tableCell = "table-cell"
    case tableRow = "table-row"
}

public enum FontWeight: String {
    case bold
    case italic
    case regular = "normal"
    case light
}

public enum TextTransform: String {
    case lowercase
    case uppercase
    case capitalize
}

public enum Alignment: String {
    case baseline
    case top
    case bottom
    case middle
    case textTop = "text-top"
    case textBottom = "text-bottom"
    case itemsCenter = "items-center"
}

public enum HorizontalAlignment: String {
    case start
    case center
    case end
    case around
    case between
}

public enum VerticalAlignment: String {
    case start
    case center
    case end
}

public enum SpacingSize: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case auto
}

public enum ColumnWidth: Int {
    case one = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case eleven
    case twelve
}

public enum FloatDirection: String {
    case right
    case left
    case top
    case bottom
}

public enum WidthSize: String {
    case full = "100"
    case threeQuarter = "75"
    case half = "50"
    case quarter = "25"
}

extension GlobalAttributes {
    public func noGutters() -> Self {
        self.class("no-gutters")
    }

    public func columnWidth(_ width: Int, for sizeClass: SizeClass = .all) -> Self {
        switch sizeClass {
        case .all:  return self.class("col-\(width)")
        default:    return self.class("col-\(sizeClass.rawValue)-\(width)")
        }
    }

    public func column(width: ColumnWidth, for sizeClass: SizeClass = .all) -> Self {
        switch sizeClass {
        case .all:  return self.class("col-\(width.rawValue)")
        default:    return self.class("col-\(sizeClass.rawValue)-\(width.rawValue)")
        }
    }

    public func text(alignment: Text.Alignment) -> Self {
        self.class("text-\(alignment.rawValue)")
    }

    public func text(color style: BootstrapStyle) -> Self {
        self.class("text-\(style.rawValue)")
    }

    public func text(transform: TextTransform) -> Self {
        self.class("text-\(transform.rawValue)")
    }

    public func truncateText() -> Self {
        self.class("text-truncate")
    }

    public func font(style: FontWeight) -> Self {
        style == .italic ? self.class("font-\(style.rawValue)") : self.class("font-weight-\(style.rawValue)")
    }

    public func alignment(_ alignment: Alignment) -> Self {
        self.class("align-\(alignment.rawValue)")
    }

    public func vertical(alignment: VerticalAlignment) -> Self {
        self.class("align-items-\(alignment.rawValue)")
    }

    public func horizontal(alignment: HorizontalAlignment) -> Self {
        self.class("justify-content-\(alignment.rawValue)")
    }

    public func margin(_ size: SpacingSize, for direction: Direction = .all, sizeClass: SizeClass = .all) -> Self {
        sizeClass == .all ? self.class("m\(direction.rawValue)-\(size.rawValue)") : self.class("m\(direction.rawValue)-\(size.rawValue)-\(sizeClass.rawValue)")
    }

    public func padding(_ size: SpacingSize, for direction: Direction = .all, sizeClass: SizeClass = .all) -> Self {
        sizeClass == .all ? self.class("p\(direction.rawValue)-\(size.rawValue)") : self.class("p\(direction.rawValue)-\(size.rawValue)-\(sizeClass.rawValue)")
    }

    public func display(_ display: Display, breakpoint: SizeClass = .all) -> Self {
        breakpoint == .all ? self.class("d-\(display.rawValue)") : self.class("d-\(breakpoint.rawValue)-\(display.rawValue)")
    }

    public func background(color style: BootstrapStyle) -> Self {
        self.class("bg-\(style.rawValue)")
    }

    public func float(_ direction: FloatDirection) -> Self {
        self.class("float-\(direction.rawValue)")
    }

    public func width(portion: WidthSize) -> Self {
        self.class("w-\(portion.rawValue)")
    }
}

public struct Container : HTMLComponent, AttributeNode {

    public enum Mode : String {
        case fluid = "-fluid"
        case snap = ""
    }

    public var attributes: [HTMLAttribute]
    let mode: Mode
    let content: HTML

    public init(mode: Mode = .snap, @HTMLBuilder content: () -> HTML) {
        self.mode = mode
        self.attributes = []
        self.content = content()
    }

    init(mode: Mode, attributes: [HTMLAttribute] = [], content: HTML) {
        self.mode = mode
        self.attributes = attributes
        self.content = content
    }

    public var body: HTML {
        Div { content }
            .class("container" + mode.rawValue)
            .add(attributes: attributes)
    }

    public func copy(with attributes: [HTMLAttribute]) -> Container {
        .init(mode: mode, attributes: attributes, content: content)
    }
}

public struct Row : HTMLComponent, AttributeNode {

    public var attributes: [HTMLAttribute]
    let content: HTML

    public init(@HTMLBuilder content: () -> HTML) {
        self.content = content()
        self.attributes = []
    }

    init(attributes: [HTMLAttribute], content: HTML) {
        self.attributes = attributes
        self.content = content
    }

    public var body: HTML {
        Div { content }
            .class("row")
            .add(attributes: attributes)
    }

    public func copy(with attributes: [HTMLAttribute]) -> Row {
        .init(attributes: attributes, content: content)
    }
}


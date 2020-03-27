public struct Modal: HTMLComponent, AttributeNode {

    public struct DataContent {

        public enum Types {
            case input
            case textArea
            case node
            case markdown

            func scriptFor(tagID: String, dataID: String) -> String {
                let jsVarName = dataID.replacingOccurrences(of: "-", with: "")
                let tagVarName = jsVarName + "tag"
                var script = "let \(jsVarName) = button.data('\(dataID.lowercased())');"
                switch self {
                case .input: script += "let \(tagVarName) = modal.find('#\(tagID)');\(tagVarName).val(\(jsVarName));"
                case .textArea, .node: script += "let \(tagVarName) = modal.find('#\(tagID)');\(tagVarName).text(\(jsVarName));"
                case .markdown: script += "\(tagID.replacingOccurrences(of: "-", with: "")).value(\(jsVarName));"
                }
                return script
            }
        }

        let tagID: String
        let dataID: String
        let type: Types

        var script: String {
            type.scriptFor(tagID: tagID, dataID: dataID)
        }
    }

    let title: HTML
    let content: HTML
    let dataContent: [DataContent]
    public var attributes: [HTMLAttribute]

    public init(title: HTML, id: HTML, @HTMLBuilder content: () -> HTML) {
        self.title = title
        self.content = content()
        self.attributes = [HTMLAttribute(attribute: "id", value: id)]
        self.dataContent = []
    }

    private init(title: HTML, content: HTML, dataContent: [DataContent], attributes: [HTMLAttribute]) {
        self.title = title
        self.content = content
        self.dataContent = dataContent
        self.attributes = attributes
    }

    public var body: HTML {
        let id = modalID
        let modifiesAttributes = attributes.filter({ $0.attribute != "id" })
        return Div {
            Div {
                Div {
                    Div {
                        H4 {
                            title
                        }
                        .class("modal-title")
                        Button {
                            "×"
                        }
                        .type("button")
                        .class("close")
                        .data(for: "dismiss", value: "modal")
                        .aria(for: "hidden", value: "true")
                    }
                    .class("modal-header bg-light")
                    Div {
                        Div {
                            content
                        }
                        .class("p-2")
                    }
                    .class("modal-body")
                }
                .class("modal-content")
            }
            .class("modal-dialog modal-dialog-centered modal-lg")
        }
        .class("modal fade")
        .id(id)
        .role("dialog")
        .aria(for: "labelledby", value: id)
        .aria(for: "hidden", value: "true")
        .add(attributes: modifiesAttributes)
    }

    private var modalID: HTML {
        value(of: "id") ?? "modal-content"
    }

    public var scripts: HTML {
        guard dataContent.isEmpty == false else { return content.scripts }
        let dataScript = dataContent.reduce(into: "") { script, dataContent in
            script += dataContent.script
        }
        return [
            content.scripts,
            Script {
            """
            $('#\(modalID)').on('show.bs.modal', function (event) {
              var button = $(event.relatedTarget) // Button that triggered the modal
              var modal = $(this)
              \(dataScript)
            })
            """
            }
        ]
    }

    public func copy(with attributes: [HTMLAttribute]) -> Modal {
        .init(title: title, content: content, dataContent: dataContent, attributes: attributes)
    }

    public func set(data dataID: String, type: DataContent.Types, to tagID: String) -> Modal {
        let newDataContent = dataContent + [DataContent(tagID: tagID, dataID: dataID, type: type)]
        return .init(title: title, content: content, dataContent: newDataContent, attributes: attributes)
    }
}

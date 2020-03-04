public struct Modal: HTMLComponent, AttributeNode {

    struct DataContent {
        let tagID: String
        let dataID: String
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
        guard dataContent.isEmpty == false else { return "" }
        let dataScript = dataContent.reduce(into: "") { script, dataContent in
            let jsVarName = dataContent.dataID.replacingOccurrences(of: "-", with: "")
            let tagVarName = jsVarName + "tag"
            script +=
            """
              let \(jsVarName) = button.data('\(dataContent.dataID.lowercased())')
              let \(tagVarName) = modal.find('#\(dataContent.tagID)')
              if (\(tagVarName).prop('tagName') == 'INPUT') {
                \(tagVarName).val(\(jsVarName))
              } else {
                \(tagVarName).text(\(jsVarName))
              }
            """
        }
        return Script {
        """
        $('#\(modalID)').on('show.bs.modal', function (event) {
          var button = $(event.relatedTarget) // Button that triggered the modal
          var modal = $(this)
          \(dataScript)
        })
        """
        }
    }

    public func copy(with attributes: [HTMLAttribute]) -> Modal {
        .init(title: title, content: content, dataContent: dataContent, attributes: attributes)
    }

    public func set(data dataID: String, to tagID: String) -> Modal {
        let newDataContent = dataContent + [DataContent(tagID: tagID, dataID: dataID)]
        return .init(title: title, content: content, dataContent: newDataContent, attributes: attributes)
    }
}

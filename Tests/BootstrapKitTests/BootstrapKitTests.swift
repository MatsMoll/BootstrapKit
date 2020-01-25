import XCTest
import BootstrapKit
import HTMLKit

final class BootstrapKitTests: XCTestCase {
    
    var renderer: HTMLRenderer!
    
    override func setUp() {
        try! setUpRenderer()
    }
    
    func testViews() throws {
        let testData = [
            Subscription(description: "Test", price: 10),
            Subscription(description: "Test 2", price: 200)
        ]

        let textViews = try renderer.render(raw: TextView.self)
        let columnView = try renderer.render(raw: ColumnView.self)
        let alertView = try renderer.render(raw: AlertViewTest.self)
        let breadcrumbActive = try renderer.render(raw: BreadcrumbViewTest.self, with: "is active")
        let breadcrumbInactive = try renderer.render(raw: BreadcrumbViewTest.self, with: "")
        let card = try renderer.render(raw: CardViewTest.self)
        let accordion = try renderer.render(raw: AccordionViewTest.self, with: testData)
        let form = try renderer.render(raw: FormViewTest.self, with: LoginContext(loginError: "", options: []))
        let listGroup = try renderer.render(raw: ListGroupTest.self, with: testData)
        let inputGroup = try renderer.render(raw: InputGroupTest.self, with: LoginContext(loginError: "", options: []))
        print(listGroup)
        print(accordion)
        print(form)
    
//        XCTAssertEqual(textViews, "<div class='container'><h1 class='display-1'>d1</h1><h1 class='display-2'>d2</h1><h1 class='display-3'>d3</h1><h1 class='display-4'>d4</h1><h1>h1</h1><h2>h2</h2><h3>h3</h3><h4>h4</h4><h5>h5</h5><h6>h6</h6><p class='lead'>lead</p><blockquote class='blockquote'>blockquote</blockquote><p>Simple P</p></div>")
//        XCTAssertEqual(columnView, "<div class='container col-sm-3 col-md-6 col-12 text-left'><p>Hello World!</p></div>")
//        XCTAssertEqual(alertView, "<div class='container-fluid'><div class='alert alert-dark' role='alert'>This is an importante message 1</div><div class='alert alert-success' role='alert'>This is an importante message 2<button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button></div><div class='alert alert-primary' role='alert'>This is an importante message 3<button type='button' class='close' data-dismiss='alert' aria-label='Close'><span aria-hidden='true'>&times;</span></button></div></div>")
//        XCTAssertEqual(breadcrumbActive, "<nav aria-label='breadcrumb'><ol class='breadcrumb'><li class='breadcrumb-item'><a href='#'>Title 1</a></li><li class='breadcrumb-item active'><a href='#'>Title 2</a></li></ol></nav>")
//        XCTAssertEqual(breadcrumbInactive, "<nav aria-label='breadcrumb'><ol class='breadcrumb'><li class='breadcrumb-item'><a href='#'>Title 1</a></li><li class='breadcrumb-item'><a href='#'>Title 2</a></li></ol></nav>")
//        XCTAssertEqual(card, "<div class='container'><div class='card'><div class='card-body'><h5 class='card-title'>Hello!</h5><p class='card-text'>Some text</p></div></div><div class='card'><img src='#' class='card-img-top'><div class='card-body'><h5 class='card-title'>Hello!</h5><p class='card-text'>Some text</p></div></div></div>")
    }
    
    
    private func setUpRenderer() throws {
        renderer = HTMLRenderer()
        
        try renderer.add(view: TextView())
        try renderer.add(view: ColumnView())
        try renderer.add(view: AlertViewTest())
        try renderer.add(view: BreadcrumbViewTest())
        try renderer.add(view: CardViewTest())
        try renderer.add(view: AccordionViewTest())
        try renderer.add(view: FormViewTest())
        try renderer.add(view: ListGroupTest())
        try renderer.add(view: InputGroupTest())
    }

    static var allTests = [
        ("testViews", testViews),
    ]
}

@testable import VaporMustache
import XCTVapor

final class VaporMustacheTests: XCTestCase {
    func testHelloWorld() throws {
        let app = Application(.testing)
        defer { app.shutdown() }
        app.views.use(.mustache)
        
        app.directory.viewsDirectory = projectFolder + "/Resources/Views/"
        
        app.get("mustache-test") { req in
            req.view.render("test.mustache", ["test": "success"])
        }
        
        try app.test(.GET, "mustache-test", afterResponse:  { res in
            XCTAssertEqual(res.status, .ok)
            XCTAssertEqual(res.body.string, "<test>success</test>\n")
        })
    }
    
    internal var projectFolder: String {
        let folder = #file.split(separator: "/").dropLast(3).joined(separator: "/")
        return "/" + folder + "/"
    }
}

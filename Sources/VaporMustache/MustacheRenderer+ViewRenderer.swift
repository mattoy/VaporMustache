import Vapor
import Mustache

extension MustacheRenderer: ViewRenderer {
    public func `for`(_ request: Request) -> ViewRenderer {
        request.mustache
    }
    
    public func render<E>(_ name: String, _ context: E) -> EventLoopFuture<View> where E : Encodable {
        guard let data = context as? [String: Any] else {
            fatalError("Encoding has not been implemented. Can only accept [String:Any] at this point.")
        }

        return self.render(path: name, context: data).map { buffer in
            return View(data: buffer)
        }
    }
}

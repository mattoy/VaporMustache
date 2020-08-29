import Mustache
import Vapor

public final class MustacheRenderer {
    public let eventLoop: EventLoop
    public let userInfo: [AnyHashable: Any]
    
    public init(
//            configuration: LeafConfiguration,
//            tags: [String: LeafTag] = defaultTags,
//            cache: LeafCache = DefaultLeafCache(),
//            sources: LeafSources,
            eventLoop: EventLoop,
            userInfo: [AnyHashable: Any] = [:]
        ) {
//            self.configuration = configuration
//            self.tags = tags
//            self.cache = cache
//            self.sources = sources
            self.eventLoop = eventLoop
            self.userInfo = userInfo
        }
    
    public func render(path: String, context: [String: Any]) -> EventLoopFuture<ByteBuffer> { // Any to MustacheData
//        guard path.count > 0 else { return self.eventLoop.makeFailedFuture(MustacheError(.noTemplateExists("(no key provided)"))) }
        
        let promise = self.eventLoop.makePromise(of: ByteBuffer.self)
        let app = self.userInfo["application"] as! Application
        let viewDirectory = app.directory.viewsDirectory
        let filePath = "\(viewDirectory)\(path)"
    
        let template = try! Template(path: filePath)
        
        let buffer = ByteBuffer(string: try! template.render(context))
        
        promise.succeed(buffer)
        return promise.futureResult

    }
}

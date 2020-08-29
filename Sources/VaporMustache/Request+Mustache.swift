import Vapor

extension Request {
    var mustache: MustacheRenderer {
        var userInfo = self.application.mustache.userInfo
        userInfo["request"] = self
        userInfo["application"] = self.application

        return .init(
//            configuration: self.application.leaf.configuration,
//            tags: self.application.leaf.tags,
//            cache: self.application.leaf.cache,
//            sources: self.application.leaf.sources,
            eventLoop: self.eventLoop,
            userInfo: userInfo
        )
    }
}

//extension MustacheContext {
//    public var request: Request? {
//        self.userInfo["request"] as? Request
//    }
//}

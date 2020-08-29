import Vapor

extension Application.Views.Provider {
    public static var mustache: Self {
        .init {
            $0.views.use {
                $0.mustache.renderer
            }
        }
    }
}

extension Application {
    public var mustache: Mustache {
        .init(application: self)
    }
    
    public struct Mustache {
        public let application: Application
        
        public var renderer: MustacheRenderer {
            var userInfo = self.userInfo
                userInfo["application"] = self

                return .init(
//                    configuration: self.configuration,
//                    cache: self.cache,
//                    sources: self.sources,
                    eventLoop: self.application.eventLoopGroup.next(),
                    userInfo: userInfo
                )
        }
//        public var configuration: MustacheConfiguration {
//            get {
//                self.storage.configuration ?? MustacheConfiguration(
//                    rootDirectory: self.application.directory.viewsDirectory
//                )
//            }
//            nonmutating set {
//                self.storage.configuration = newValue
//            }
//        }

//        public var tags: [String: MustacheTag] {
//            get {
//                self.storage.tags
//            }
//            nonmutating set {
//                self.storage.tags = newValue
//            }
//        }

//        public var sources: MustacheSources {
//            get {
//                self.storage.sources ?? MustacheSources.singleSource(
//                                            NIOLeafFiles(fileio: self.application.fileio,
//                                                        limits: .default,
//                                                        sandboxDirectory: self.configuration.rootDirectory,
//                                                        viewDirectory: self.configuration.rootDirectory))
//            }
//            nonmutating set {
//                self.storage.sources = newValue
//            }
//        }

//        public var cache: MustacheCache {
//            get {
//                self.storage.cache
//            }
//            nonmutating set {
//                self.storage.cache = newValue
//            }
//        }
        
        public var userInfo: [AnyHashable: Any] {
            get {
                self.storage.userInfo
            }
            nonmutating set {
                self.storage.userInfo = newValue
            }
        }

        var storage: Storage {
            if let existing = self.application.storage[Key.self] {
                return existing
            } else {
                let new = Storage()
                self.application.storage[Key.self] = new
                return new
            }
        }

        struct Key: StorageKey {
            typealias Value = Storage
        }

        final class Storage {
//            var cache: MustacheCache
//            var configuration: MustacheConfiguration?
//            var sources: MustacheSources?
//            var tags: [String: MustacheTag]
            var userInfo: [AnyHashable: Any]

            init() {
//                self.cache = DefaultMustacheCache()
//                self.tags = MustacheKit.defaultTags
                self.userInfo = [:]
            }
        }
    }
}


//extension MustacheContext {
//    public var application: Application? {
//        self.userInfo["application"] as? Application
//    }
//}

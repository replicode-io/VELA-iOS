import Foundation
import Combine

fileprivate struct PageResponse<ItemType> {
    var items = [ItemType]()
    var hasMorePages = true
    var nextPage = 0
}

class PaginatedLoader<ItemType> {
    
    private(set) var requests = Set<AnyCancellable>()
    private let startPage:Int
    private let pageSize:Int
    private let publisher:(_ page:Int)->(AnyPublisher<[ItemType], Error>)
    private let scheduler = DispatchQueue.global(qos: .background)
    
    init(startPage:Int=1, pageSize:Int=500, publisher:@escaping (_ page:Int)->(AnyPublisher<[ItemType], Error>)) {
        self.startPage = startPage
        self.pageSize = pageSize
        self.publisher = publisher
    }

    private func loadPage(page: Int) -> AnyPublisher<PageResponse<ItemType>, Never> {
        
        Future { promise in
            self.publisher(page)
//                .delay(for: 0.2, scheduler: DispatchQueue.main)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { state in
                    switch state {
                    case .finished:
                        break
                    case let .failure(error):
                        print(error)
                        break
                    }
                }, receiveValue: { response in
                    
                    if response.count < self.pageSize {
                        return promise(.success(PageResponse<ItemType>(items: response,
                                                                       hasMorePages: false)))
                    } else {
                        let nextPage = page + 1
                        return promise(.success(PageResponse<ItemType>(items: response,
                                                                       nextPage: nextPage)))
                    }
                    
                })
                .store(in: &self.requests)
        }.eraseToAnyPublisher()
    }
    
    func loadPages() -> AnyPublisher<[ItemType], Never> {
      let pageIndexPublisher = CurrentValueSubject<Int, Never>(startPage)

      return pageIndexPublisher
        .flatMap({ index in
          return self.loadPage(page: index)
        })
        .handleEvents(receiveOutput: { (response: PageResponse) in
          if response.hasMorePages {
              pageIndexPublisher.send(response.nextPage)
          } else {
              pageIndexPublisher.send(completion: .finished)
          }
        })
        .reduce([ItemType](), { allTxns, response in
          return allTxns + response.items
        })
        .eraseToAnyPublisher()
    }
    
}

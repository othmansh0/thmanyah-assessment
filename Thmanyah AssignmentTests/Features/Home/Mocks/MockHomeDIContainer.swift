@testable import Thmanyah_Assignment

struct MockHomeDIContainer: HomeDIContainerProtocol {
    let fetchSectionsUseCase: FetchHomeSectionsUseCaseProtocol

    init(useCase: FetchHomeSectionsUseCaseProtocol = MockFetchHomeSectionsUseCase()) {
        self.fetchSectionsUseCase = useCase
    }
}

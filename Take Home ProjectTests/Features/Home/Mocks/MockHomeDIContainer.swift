@testable import Take_Home_Project

struct MockHomeDIContainer: HomeDIContainerProtocol {
    let fetchSectionsUseCase: FetchHomeSectionsUseCaseProtocol

    init(useCase: FetchHomeSectionsUseCaseProtocol = MockFetchHomeSectionsUseCase()) {
        self.fetchSectionsUseCase = useCase
    }
}

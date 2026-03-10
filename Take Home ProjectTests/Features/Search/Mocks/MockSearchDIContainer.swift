@testable import Take_Home_Project

struct MockSearchDIContainer: SearchDIContainerProtocol {
    let searchContentUseCase: SearchContentUseCaseProtocol

    init(useCase: SearchContentUseCaseProtocol = MockSearchContentUseCase()) {
        self.searchContentUseCase = useCase
    }
}

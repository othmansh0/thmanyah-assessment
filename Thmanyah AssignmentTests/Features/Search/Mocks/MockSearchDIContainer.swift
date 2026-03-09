@testable import Thmanyah_Assignment

struct MockSearchDIContainer: SearchDIContainerProtocol {
    let searchContentUseCase: SearchContentUseCaseProtocol

    init(useCase: SearchContentUseCaseProtocol = MockSearchContentUseCase()) {
        self.searchContentUseCase = useCase
    }
}

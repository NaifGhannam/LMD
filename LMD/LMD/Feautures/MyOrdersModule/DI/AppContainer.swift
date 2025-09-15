//
//  AppContainer.swift
//  LMD
//
//  Created by Tahani on 23/03/1447 AH.
//

import Foundation

struct AppContainer {
    // Data
    private let networkClient: NetworkClient = DefaultNetworkClient()
    private var remoteDataSource: MyOrdersRemoteDataSource { .init(client: networkClient) }
    private var ordersRepository: MyOrdersRepository {
        MyOrdersRepositoryImpl(remote: remoteDataSource)
    }

    // UseCases
    var getMyOrders: GetMyOrdersUseCase { GetMyOrders(repo: ordersRepository) }
    var updateOrderStatus: UpdateOrderStatusUseCase { UpdateOrderStatus(repo: ordersRepository) }
    var getAllUsers: GetAllUsersUseCase { GetAllUsers(repo: ordersRepository) }

    // VM factories
    @MainActor
    func makeMyOrdersVM() -> MyOrdersViewModel {
        .init(getMyOrders: getMyOrders, updateOrderStatus: updateOrderStatus, getAllUsers: getAllUsers)
    }
}

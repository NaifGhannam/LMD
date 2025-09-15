//
//  DTO+DomainMappers.swift
//  LMD
//
//  Created by Tahani on 23/03/1447 AH.
//

import Foundation

extension Order {
    func toDomain() -> Order {
        Order(orderID: orderID,
              orderNumber: orderNumber,
              customerID: customerID,
              customerName: customerName,
              address: address,
              statusID: statusID,
              assignedAgentID: assignedAgentID,
              partnerID: partnerID,
              dcID: dcID,
              orderDate: orderDate,
              deliveryTime: deliveryTime,
              slaMet: deliveryTime,
              serialNumber: serialNumber,
              coordinates: coordinates,
              lastUpdated: lastUpdated,
              orderStatuses: orderStatuses,
              users: users,
              partners: partners,
              distributionCenters: distributionCenters,
              distanceKm: distanceKm)
    }
}

extension OrdersData {
    func toDomain() -> (orders: [Order], data: OrdersData, pagination: Paginations?) {
        (
            orders.map { $0.toDomain() },
            OrdersData(
                orders: orders,
                pagination: pagination,
                filters: filters,
                location: location,
                sorting: sorting
            ),
            pagination?.toDomain()
        )
    }
}

extension Paginations {
    
    func toDomain() -> Paginations {
        Paginations(
            currentPage: currentPage,
            totalPages: totalPages,
            totalCount: totalCount,
            limit: limit,
            hasNextPage: hasNextPage,
            hasPrevPage: hasPrevPage
        )
    }
}

extension Users {
    func toDomain() -> Users {
        Users(id: id,
              name: name
        )
    }
}

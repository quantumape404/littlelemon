//
//  DishDetail.swift
//  Little Lemon
//
//  Created by Edem Ahorlu on 12/20/23.
//

import SwiftUI

struct DishDetail: View {
    let dish: Dish
    
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .clipShape(Rectangle())
            .frame(minHeight: 150)
            Text(dish.title ?? "")
//                .font(.subTitleFont())
//                .foregroundColor(.primaryColor1)
            Spacer(minLength: 20)
            Text(dish.dishDescription ?? "")
//                .font(.regularText())
            Spacer(minLength: 10)
            Text("$" + (dish.price ?? ""))
//                .font(.highlightText())
//                .foregroundColor(.primaryColor1)
                .monospaced()
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .ignoresSafeArea()
    }
}

struct DishDetail_Previews: PreviewProvider {
    static var previews: some View {
        DishDetail(dish: PersistenceController.oneDish())
    }
}

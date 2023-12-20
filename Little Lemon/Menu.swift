//
//  Menu.swift
//  Little Lemon
//
//  Created by Edem Ahorlu on 12/19/23.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                LittleLemonLogo()
                VStack {
                    Hero()
                        .frame(maxHeight: 180)
                    TextField("Search menu", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                }
                .padding()
                .background(Color.primaryColor1)
            
                FetchedObjects(predicate: buildPredicate(),
                    sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                    List {
                        ForEach(dishes, id: \.self) { dish in
                            NavigationLink(destination: DishDetail(dish: dish)) {
                                DishItem(dish: dish)
                            }
                        }
                    }
                    .listStyle(.plain)
                    
                }
            }
        }
        .onAppear {
            Menu.getMenuData(viewContext: viewContext)
        }
    }
    
    
    static func getMenuData(viewContext: NSManagedObjectContext) {
        PersistenceController.shared.clear()
        
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let menuItems = try? decoder.decode(MenuList.self, from: data) {
                    for menuItem in menuItems.menu {
                        let dish = Dish(context: viewContext)
                        dish.title = menuItem.title
                        dish.title = menuItem.title
                        dish.price = menuItem.price
                        dish.dishDescription = menuItem.dishDescription
                        dish.image = menuItem.image
                        dish.category = menuItem.category
                    }
                    try? viewContext.save()
                }
            }
        }
        dataTask.resume()
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                                  ascending: true,
                                  selector:
                                    #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSPredicate {
        let search = searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        return search
    }

}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}

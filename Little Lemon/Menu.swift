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
    
    @State var startersIsEnabled = true
    @State var mainsIsEnabled = true
    @State var dessertsIsEnabled = true
    @State var drinksIsEnabled = true
    
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
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        Toggle("Starters", isOn: $startersIsEnabled)
                        Toggle("Mains", isOn: $mainsIsEnabled)
                        Toggle("Desserts", isOn: $dessertsIsEnabled)
                        Toggle("Drinks", isOn: $drinksIsEnabled)
                    }
                    .toggleStyle(MyToggleStyle())
                    .padding(.horizontal)
                }
            
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
    
    func buildPredicate() -> NSCompoundPredicate {
        let search = searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        let starters = !startersIsEnabled ? NSPredicate(format: "category != %@", "starters") : NSPredicate(value: true)
        let mains = !mainsIsEnabled ? NSPredicate(format: "category != %@", "mains") : NSPredicate(value: true)
        let desserts = !dessertsIsEnabled ? NSPredicate(format: "category != %@", "desserts") : NSPredicate(value: true)
        let drinks = !drinksIsEnabled ? NSPredicate(format: "category != %@", "drinks") : NSPredicate(value: true)
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [search, starters, mains, desserts, drinks])
        return compoundPredicate
    }

}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}

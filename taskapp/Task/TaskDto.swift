//
//  TaskDto.swift
//  taskapp
//
//  Created by Guilherme on 12/12/2017.
//  Copyright © 2017 Guilherme. All rights reserved.
//

import Foundation
import RealmSwift

extension TaskItem {
    
    func toTaskDto() -> TaskDto {
        
        var taskDto = TaskDto()
        taskDto.id = self.id
        taskDto.expirationDate = self.expirationDate
        taskDto.title = self.title
        taskDto.taskDescription = self.taskDescription
        taskDto.isComplete = self.isComplete! ? true : false
        taskDto.owner = self.owner
        
        return taskDto
    }
    
}

class TaskDto : Object {
    
    @objc dynamic var id: String?
    @objc dynamic var expirationDate: String?
    @objc dynamic var title: String?
    @objc dynamic var taskDescription: String?
    @objc dynamic var isComplete: ObjCBool = false
    @objc dynamic var owner: String?
    
    func insert() -> TaskDto {
        if "" == self.id { self.id = UUID().uuidString }
        // Get the default Realm
        let realm = try! Realm()
        // Persist your data easily
        try! realm.write {
            realm.add(self)
        }
        return self
    }
    
    func printItems()  {
        let realm = try! Realm()
        let items = realm.objects(TaskDto.self)
        print("******** IMPRIMINDO DATABASE***********")
        items.forEach{
            print($0)
        }
        print("***************************************")
    }
    
    /*
    fileprivate func update(_ idUpdate : String) -> TasksDB {
        let realm = try! Realm()
        let predicate = NSPredicate(format: "id == %@", idUpdate)
        let item = realm.objects(TasksDB.self).filter(predicate).first
        if item != nil {
            try! realm.write {
                item!.id = self.id
                item?.expirationdate = self.expirationdate
                item?.title = self.title
                item?.descriptionTask = self.descriptionTask
                item?.iscomplete = self.iscomplete
                item?.owner = self.owner
                item?.isSyncronized = self.isSyncronized
            }
            return item!
        }
        else {
            return self.insert() //neste caso, o item ainda nao existe na base, e eh incluido
        }
    }
     */
    
}

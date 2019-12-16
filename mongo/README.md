
docker exec -it mymongo bash
use backyard;
use admin;
db.auth("admin","admin");
db.auditlist.getIndexes();
db.auditlist.dropIndexes();
db.auditlist.createIndex({"table": 1, "id": 1})
db.auditlist.createIndex({"table": 1, "id": 1}, {background: true})


db.auditlist.createIndex({"staff_id_union": 1, "status_union": 1}, {background: true})


sudo docker-compose stop mymongo
sudo docker-compose rm mymongo

sudo docker ps -a



1、查看集合索引

db.auditlist.getIndexes()
2、查看集合索引大小

db.auditlist.totalIndexSize()
3、删除集合所有索引

db.auditlist.dropIndexes()
4、删除集合指定索引

db.auditlist.dropIndex("索引名称")

db.auditlist.ensureIndex({"staff_id_union":1})


db.createCollection("auditlist");

db.getCollection("auditlist").createIndex({
    "staff_id_union": NumberInt("1"),
    "status_union": NumberInt("1")
}, {
    name: "staff_id_union_1_status_union_1",
    background: true
});

db.getCollection("auditlist").createIndex({
    "staff_id_union": NumberInt("1")
}, {
    name: "staff_id_union_1"
});

db.auditlist.find({audit:'30425' }).explain()

rs.slaveOk()
db.content.find({"identifiers": {"$elemMatch": {"authority": "http://api.ft.com/system/BRIGHTCOVE"}}}, { _id:0, uuid:1, "identifiers.identifierValue": 1 }).toArray()

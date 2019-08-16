class FollowEntity {
	bool adExist;
	int total;
	String nextPageUrl;
	int refreshCount;
	int count;
	List<FollowItem> itemList;
	int lastStartId;

	FollowEntity({this.adExist, this.total, this.nextPageUrl, this.refreshCount, this.count, this.itemList, this.lastStartId});

	FollowEntity.fromJson(Map<String, dynamic> json) {
		adExist = json['adExist'];
		total = json['total'];
		nextPageUrl = json['nextPageUrl'];
		refreshCount = json['refreshCount'];
		count = json['count'];
		if (json['itemList'] != null) {
			itemList = new List<FollowItem>();(json['itemList'] as List).forEach((v) { itemList.add(new FollowItem.fromJson(v)); });
		}
		lastStartId = json['lastStartId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['adExist'] = this.adExist;
		data['total'] = this.total;
		data['nextPageUrl'] = this.nextPageUrl;
		data['refreshCount'] = this.refreshCount;
		data['count'] = this.count;
		if (this.itemList != null) {
      data['itemList'] =  this.itemList.map((v) => v.toJson()).toList();
    }
		data['lastStartId'] = this.lastStartId;
		return data;
	}
}

class FollowItem {
	FollowItemData data;
	int adIndex;
	int id;
	String type;

	FollowItem({this.data, this.adIndex, this.id, this.type});

	FollowItem.fromJson(Map<String, dynamic> json) {
		data = json['data'] != null ? new FollowItemData.fromJson(json['data']) : null;
		adIndex = json['adIndex'];
		id = json['id'];
		type = json['type'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['adIndex'] = this.adIndex;
		data['id'] = this.id;
		data['type'] = this.type;
		return data;
	}
}

class FollowItemData {
	String dataType;
	int count;
	FollowItemHeader header;
	List<FollowItemlistDataItemlist> itemList;

	FollowItemData({this.dataType, this.count, this.header, this.itemList});

	FollowItemData.fromJson(Map<String, dynamic> json) {
		dataType = json['dataType'];
		count = json['count'];
		header = json['header'] != null ? new FollowItemHeader.fromJson(json['header']) : null;
		if (json['itemList'] != null) {
			itemList = new List<FollowItemlistDataItemlist>();(json['itemList'] as List).forEach((v) { itemList.add(new FollowItemlistDataItemlist.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['dataType'] = this.dataType;
		data['count'] = this.count;
		if (this.header != null) {
      data['header'] = this.header.toJson();
    }
		if (this.itemList != null) {
      data['itemList'] =  this.itemList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class FollowItemHeader {
	bool ifShowNotificationIcon;
	int uid;
	bool expert;
	String iconType;
	String actionUrl;
	String icon;
	bool ifPgc;
	String description;
	int id;
	FollowItemlistDataHeaderFollow follow;
	String title;

	FollowItemHeader({this.ifShowNotificationIcon, this.uid, this.expert, this.iconType, this.actionUrl, this.icon, this.ifPgc, this.description, this.id, this.follow, this.title});

	FollowItemHeader.fromJson(Map<String, dynamic> json) {
		ifShowNotificationIcon = json['ifShowNotificationIcon'];
		uid = json['uid'];
		expert = json['expert'];
		iconType = json['iconType'];
		actionUrl = json['actionUrl'];
		icon = json['icon'];
		ifPgc = json['ifPgc'];
		description = json['description'];
		id = json['id'];
		follow = json['follow'] != null ? new FollowItemlistDataHeaderFollow.fromJson(json['follow']) : null;
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['ifShowNotificationIcon'] = this.ifShowNotificationIcon;
		data['uid'] = this.uid;
		data['expert'] = this.expert;
		data['iconType'] = this.iconType;
		data['actionUrl'] = this.actionUrl;
		data['icon'] = this.icon;
		data['ifPgc'] = this.ifPgc;
		data['description'] = this.description;
		data['id'] = this.id;
		if (this.follow != null) {
      data['follow'] = this.follow.toJson();
    }
		data['title'] = this.title;
		return data;
	}
}

class FollowItemlistDataHeaderFollow {
	int itemId;
	String itemType;
	bool followed;

	FollowItemlistDataHeaderFollow({this.itemId, this.itemType, this.followed});

	FollowItemlistDataHeaderFollow.fromJson(Map<String, dynamic> json) {
		itemId = json['itemId'];
		itemType = json['itemType'];
		followed = json['followed'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['itemId'] = this.itemId;
		data['itemType'] = this.itemType;
		data['followed'] = this.followed;
		return data;
	}
}

class FollowItemlistDataItemlist {
	FollowItemlistDataItemlistData data;
	int adIndex;
	int id;
	String type;

	FollowItemlistDataItemlist({this.data, this.adIndex, this.id, this.type});

	FollowItemlistDataItemlist.fromJson(Map<String, dynamic> json) {
		data = json['data'] != null ? new FollowItemlistDataItemlistData.fromJson(json['data']) : null;
		adIndex = json['adIndex'];
		id = json['id'];
		type = json['type'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['adIndex'] = this.adIndex;
		data['id'] = this.id;
		data['type'] = this.type;
		return data;
	}
}

class FollowItemlistDataItemlistData {
	int date;
	int releaseTime;
	String description;
	bool collected;
	String remark;
	String title;
	String type;
	String playUrl;
	FollowItemlistDataItemlistDataCover cover;
	int duration;
	String descriptionEditor;
	String xLibrary;
	FollowItemlistDataItemlistDataProvider provider;
	String descriptionPgc;
	int id;
	String titlePgc;
	List<Null> subtitles;
	bool ad;
	FollowItemlistDataItemlistDataAuthor author;
	String dataType;
	int searchWeight;
	FollowItemlistDataItemlistDataConsumption consumption;
	bool played;
	List<FollowItemlistDataItemlistDataTag> tags;
	List<Null> labelList;
	List<FollowItemlistDataItemlistDataPlayinfo> playInfo;
	bool ifLimitVideo;
	FollowItemlistDataItemlistDataWeburl webUrl;
	String category;
	int idx;
	String resourceType;

	FollowItemlistDataItemlistData({this.date, this.releaseTime, this.description, this.collected, this.remark, this.title, this.type, this.playUrl, this.cover, this.duration, this.descriptionEditor, this.xLibrary, this.provider, this.descriptionPgc, this.id, this.titlePgc, this.subtitles, this.ad, this.author, this.dataType, this.searchWeight, this.consumption, this.played, this.tags, this.labelList, this.playInfo, this.ifLimitVideo, this.webUrl, this.category, this.idx, this.resourceType});

	FollowItemlistDataItemlistData.fromJson(Map<String, dynamic> json) {
		date = json['date'];
		releaseTime = json['releaseTime'];
		description = json['description'];
		collected = json['collected'];
		remark = json['remark'];
		title = json['title'];
		type = json['type'];
		playUrl = json['playUrl'];
		cover = json['cover'] != null ? new FollowItemlistDataItemlistDataCover.fromJson(json['cover']) : null;
		duration = json['duration'];
		descriptionEditor = json['descriptionEditor'];
		xLibrary = json['library'];
		provider = json['provider'] != null ? new FollowItemlistDataItemlistDataProvider.fromJson(json['provider']) : null;
		descriptionPgc = json['descriptionPgc'];
		id = json['id'];
		titlePgc = json['titlePgc'];
		if (json['subtitles'] != null) {
			subtitles = new List<Null>();
		}
		ad = json['ad'];
		author = json['author'] != null ? new FollowItemlistDataItemlistDataAuthor.fromJson(json['author']) : null;
		dataType = json['dataType'];
		searchWeight = json['searchWeight'];
		consumption = json['consumption'] != null ? new FollowItemlistDataItemlistDataConsumption.fromJson(json['consumption']) : null;
		played = json['played'];
		if (json['tags'] != null) {
			tags = new List<FollowItemlistDataItemlistDataTag>();(json['tags'] as List).forEach((v) { tags.add(new FollowItemlistDataItemlistDataTag.fromJson(v)); });
		}
		if (json['labelList'] != null) {
			labelList = new List<Null>();
		}
		if (json['playInfo'] != null) {
			playInfo = new List<FollowItemlistDataItemlistDataPlayinfo>();(json['playInfo'] as List).forEach((v) { playInfo.add(new FollowItemlistDataItemlistDataPlayinfo.fromJson(v)); });
		}
		ifLimitVideo = json['ifLimitVideo'];
		webUrl = json['webUrl'] != null ? new FollowItemlistDataItemlistDataWeburl.fromJson(json['webUrl']) : null;
		category = json['category'];
		idx = json['idx'];
		resourceType = json['resourceType'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['date'] = this.date;
		data['releaseTime'] = this.releaseTime;
		data['description'] = this.description;
		data['collected'] = this.collected;
		data['remark'] = this.remark;
		data['title'] = this.title;
		data['type'] = this.type;
		data['playUrl'] = this.playUrl;
		if (this.cover != null) {
      data['cover'] = this.cover.toJson();
    }
		data['duration'] = this.duration;
		data['descriptionEditor'] = this.descriptionEditor;
		data['library'] = this.xLibrary;
		if (this.provider != null) {
      data['provider'] = this.provider.toJson();
    }
		data['descriptionPgc'] = this.descriptionPgc;
		data['id'] = this.id;
		data['titlePgc'] = this.titlePgc;
		if (this.subtitles != null) {
      data['subtitles'] =  [];
    }
		data['ad'] = this.ad;
		if (this.author != null) {
      data['author'] = this.author.toJson();
    }
		data['dataType'] = this.dataType;
		data['searchWeight'] = this.searchWeight;
		if (this.consumption != null) {
      data['consumption'] = this.consumption.toJson();
    }
		data['played'] = this.played;
		if (this.tags != null) {
      data['tags'] =  this.tags.map((v) => v.toJson()).toList();
    }
		if (this.labelList != null) {
      data['labelList'] =  [];
    }
		if (this.playInfo != null) {
      data['playInfo'] =  this.playInfo.map((v) => v.toJson()).toList();
    }
		data['ifLimitVideo'] = this.ifLimitVideo;
		if (this.webUrl != null) {
      data['webUrl'] = this.webUrl.toJson();
    }
		data['category'] = this.category;
		data['idx'] = this.idx;
		data['resourceType'] = this.resourceType;
		return data;
	}
}

class FollowItemlistDataItemlistDataCover {
	String feed;
	String detail;
	String blurred;

	FollowItemlistDataItemlistDataCover({this.feed, this.detail, this.blurred});

	FollowItemlistDataItemlistDataCover.fromJson(Map<String, dynamic> json) {
		feed = json['feed'];
		detail = json['detail'];
		blurred = json['blurred'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['feed'] = this.feed;
		data['detail'] = this.detail;
		data['blurred'] = this.blurred;
		return data;
	}
}

class FollowItemlistDataItemlistDataProvider {
	String icon;
	String name;
	String alias;

	FollowItemlistDataItemlistDataProvider({this.icon, this.name, this.alias});

	FollowItemlistDataItemlistDataProvider.fromJson(Map<String, dynamic> json) {
		icon = json['icon'];
		name = json['name'];
		alias = json['alias'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['icon'] = this.icon;
		data['name'] = this.name;
		data['alias'] = this.alias;
		return data;
	}
}

class FollowItemlistDataItemlistDataAuthor {
	FollowItemlistDataItemlistDataAuthorShield shield;
	bool expert;
	int approvedNotReadyVideoCount;
	String icon;
	String link;
	String description;
	int videoNum;
	FollowItemlistDataItemlistDataAuthorFollow follow;
	int recSort;
	bool ifPgc;
	String name;
	int latestReleaseTime;
	int id;

	FollowItemlistDataItemlistDataAuthor({this.shield, this.expert, this.approvedNotReadyVideoCount, this.icon, this.link, this.description, this.videoNum, this.follow, this.recSort, this.ifPgc, this.name, this.latestReleaseTime, this.id});

	FollowItemlistDataItemlistDataAuthor.fromJson(Map<String, dynamic> json) {
		shield = json['shield'] != null ? new FollowItemlistDataItemlistDataAuthorShield.fromJson(json['shield']) : null;
		expert = json['expert'];
		approvedNotReadyVideoCount = json['approvedNotReadyVideoCount'];
		icon = json['icon'];
		link = json['link'];
		description = json['description'];
		videoNum = json['videoNum'];
		follow = json['follow'] != null ? new FollowItemlistDataItemlistDataAuthorFollow.fromJson(json['follow']) : null;
		recSort = json['recSort'];
		ifPgc = json['ifPgc'];
		name = json['name'];
		latestReleaseTime = json['latestReleaseTime'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.shield != null) {
      data['shield'] = this.shield.toJson();
    }
		data['expert'] = this.expert;
		data['approvedNotReadyVideoCount'] = this.approvedNotReadyVideoCount;
		data['icon'] = this.icon;
		data['link'] = this.link;
		data['description'] = this.description;
		data['videoNum'] = this.videoNum;
		if (this.follow != null) {
      data['follow'] = this.follow.toJson();
    }
		data['recSort'] = this.recSort;
		data['ifPgc'] = this.ifPgc;
		data['name'] = this.name;
		data['latestReleaseTime'] = this.latestReleaseTime;
		data['id'] = this.id;
		return data;
	}
}

class FollowItemlistDataItemlistDataAuthorShield {
	int itemId;
	String itemType;
	bool shielded;

	FollowItemlistDataItemlistDataAuthorShield({this.itemId, this.itemType, this.shielded});

	FollowItemlistDataItemlistDataAuthorShield.fromJson(Map<String, dynamic> json) {
		itemId = json['itemId'];
		itemType = json['itemType'];
		shielded = json['shielded'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['itemId'] = this.itemId;
		data['itemType'] = this.itemType;
		data['shielded'] = this.shielded;
		return data;
	}
}

class FollowItemlistDataItemlistDataAuthorFollow {
	int itemId;
	String itemType;
	bool followed;

	FollowItemlistDataItemlistDataAuthorFollow({this.itemId, this.itemType, this.followed});

	FollowItemlistDataItemlistDataAuthorFollow.fromJson(Map<String, dynamic> json) {
		itemId = json['itemId'];
		itemType = json['itemType'];
		followed = json['followed'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['itemId'] = this.itemId;
		data['itemType'] = this.itemType;
		data['followed'] = this.followed;
		return data;
	}
}

class FollowItemlistDataItemlistDataConsumption {
	int shareCount;
	int replyCount;
	int collectionCount;

	FollowItemlistDataItemlistDataConsumption({this.shareCount, this.replyCount, this.collectionCount});

	FollowItemlistDataItemlistDataConsumption.fromJson(Map<String, dynamic> json) {
		shareCount = json['shareCount'];
		replyCount = json['replyCount'];
		collectionCount = json['collectionCount'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['shareCount'] = this.shareCount;
		data['replyCount'] = this.replyCount;
		data['collectionCount'] = this.collectionCount;
		return data;
	}
}

class FollowItemlistDataItemlistDataTag {
	String tagRecType;
	String headerImage;
	String actionUrl;
	int communityIndex;
	String name;
	int id;
	String bgPicture;
	String desc;

	FollowItemlistDataItemlistDataTag({this.tagRecType, this.headerImage, this.actionUrl, this.communityIndex, this.name, this.id, this.bgPicture, this.desc});

	FollowItemlistDataItemlistDataTag.fromJson(Map<String, dynamic> json) {
		tagRecType = json['tagRecType'];
		headerImage = json['headerImage'];
		actionUrl = json['actionUrl'];
		communityIndex = json['communityIndex'];
		name = json['name'];
		id = json['id'];
		bgPicture = json['bgPicture'];
		desc = json['desc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['tagRecType'] = this.tagRecType;
		data['headerImage'] = this.headerImage;
		data['actionUrl'] = this.actionUrl;
		data['communityIndex'] = this.communityIndex;
		data['name'] = this.name;
		data['id'] = this.id;
		data['bgPicture'] = this.bgPicture;
		data['desc'] = this.desc;
		return data;
	}
}

class FollowItemlistDataItemlistDataPlayinfo {
	String name;
	int width;
	List<FollowItemlistDataItemlistDataPlayinfoUrllist> urlList;
	String type;
	String url;
	int height;

	FollowItemlistDataItemlistDataPlayinfo({this.name, this.width, this.urlList, this.type, this.url, this.height});

	FollowItemlistDataItemlistDataPlayinfo.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		width = json['width'];
		if (json['urlList'] != null) {
			urlList = new List<FollowItemlistDataItemlistDataPlayinfoUrllist>();(json['urlList'] as List).forEach((v) { urlList.add(new FollowItemlistDataItemlistDataPlayinfoUrllist.fromJson(v)); });
		}
		type = json['type'];
		url = json['url'];
		height = json['height'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['width'] = this.width;
		if (this.urlList != null) {
      data['urlList'] =  this.urlList.map((v) => v.toJson()).toList();
    }
		data['type'] = this.type;
		data['url'] = this.url;
		data['height'] = this.height;
		return data;
	}
}

class FollowItemlistDataItemlistDataPlayinfoUrllist {
	int size;
	String name;
	String url;

	FollowItemlistDataItemlistDataPlayinfoUrllist({this.size, this.name, this.url});

	FollowItemlistDataItemlistDataPlayinfoUrllist.fromJson(Map<String, dynamic> json) {
		size = json['size'];
		name = json['name'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['size'] = this.size;
		data['name'] = this.name;
		data['url'] = this.url;
		return data;
	}
}

class FollowItemlistDataItemlistDataWeburl {
	String forWeibo;
	String raw;

	FollowItemlistDataItemlistDataWeburl({this.forWeibo, this.raw});

	FollowItemlistDataItemlistDataWeburl.fromJson(Map<String, dynamic> json) {
		forWeibo = json['forWeibo'];
		raw = json['raw'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['forWeibo'] = this.forWeibo;
		data['raw'] = this.raw;
		return data;
	}
}

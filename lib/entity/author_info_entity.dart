class AuthorInfoEntity {
	AuthorInfoTabinfo tabInfo;
	AuthorInfoPgcinfo pgcInfo;

	AuthorInfoEntity({this.tabInfo, this.pgcInfo});

	AuthorInfoEntity.fromJson(Map<String, dynamic> json) {
		tabInfo = json['tabInfo'] != null ? new AuthorInfoTabinfo.fromJson(json['tabInfo']) : null;
		pgcInfo = json['pgcInfo'] != null ? new AuthorInfoPgcinfo.fromJson(json['pgcInfo']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.tabInfo != null) {
      data['tabInfo'] = this.tabInfo.toJson();
    }
		if (this.pgcInfo != null) {
      data['pgcInfo'] = this.pgcInfo.toJson();
    }
		return data;
	}
}

class AuthorInfoTabinfo {
	List<TabItem> tabList;
	int defaultIdx;

	AuthorInfoTabinfo({this.tabList, this.defaultIdx});

	AuthorInfoTabinfo.fromJson(Map<String, dynamic> json) {
		if (json['tabList'] != null) {
			tabList = new List<TabItem>();(json['tabList'] as List).forEach((v) { tabList.add(new TabItem.fromJson(v)); });
		}
		defaultIdx = json['defaultIdx'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.tabList != null) {
      data['tabList'] =  this.tabList.map((v) => v.toJson()).toList();
    }
		data['defaultIdx'] = this.defaultIdx;
		return data;
	}
}

class TabItem {
	int nameType;
	String apiUrl;
	String name;
	int tabType;
	int id;

	TabItem({this.nameType, this.apiUrl, this.name, this.tabType, this.id});

	TabItem.fromJson(Map<String, dynamic> json) {
		nameType = json['nameType'];
		apiUrl = json['apiUrl'];
		name = json['name'];
		tabType = json['tabType'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['nameType'] = this.nameType;
		data['apiUrl'] = this.apiUrl;
		data['name'] = this.name;
		data['tabType'] = this.tabType;
		data['id'] = this.id;
		return data;
	}
}

class AuthorInfoPgcinfo {
	String area;
	String brief;
	AuthorInfoPgcinfoShield shield;
	int worksRecCount;
	bool expert;
	int followCount;
	String gender;
	String dataType;
	String actionUrl;
	int collectCount;
	String icon;
	String description;
	AuthorInfoPgcinfoFollow follow;
	String cover;
	int videoCount;
	int shareCount;
	int worksSelectedCount;
	String name;
	bool self;
	int myFollowCount;
	int id;
	int medalsNum;
	int registDate;

	AuthorInfoPgcinfo({this.area, this.brief, this.shield, this.worksRecCount, this.expert, this.followCount, this.gender, this.dataType, this.actionUrl, this.collectCount, this.icon, this.description, this.follow, this.cover, this.videoCount, this.shareCount, this.worksSelectedCount, this.name, this.self, this.myFollowCount, this.id, this.medalsNum, this.registDate});

	AuthorInfoPgcinfo.fromJson(Map<String, dynamic> json) {
		area = json['area'];
		brief = json['brief'];
		shield = json['shield'] != null ? new AuthorInfoPgcinfoShield.fromJson(json['shield']) : null;
		worksRecCount = json['worksRecCount'];
		expert = json['expert'];
		followCount = json['followCount'];
		gender = json['gender'];
		dataType = json['dataType'];
		actionUrl = json['actionUrl'];
		collectCount = json['collectCount'];
		icon = json['icon'];
		description = json['description'];
		follow = json['follow'] != null ? new AuthorInfoPgcinfoFollow.fromJson(json['follow']) : null;
		cover = json['cover'];
		videoCount = json['videoCount'];
		shareCount = json['shareCount'];
		worksSelectedCount = json['worksSelectedCount'];
		name = json['name'];
		self = json['self'];
		myFollowCount = json['myFollowCount'];
		id = json['id'];
		medalsNum = json['medalsNum'];
		registDate = json['registDate'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['area'] = this.area;
		data['brief'] = this.brief;
		if (this.shield != null) {
      data['shield'] = this.shield.toJson();
    }
		data['worksRecCount'] = this.worksRecCount;
		data['expert'] = this.expert;
		data['followCount'] = this.followCount;
		data['gender'] = this.gender;
		data['dataType'] = this.dataType;
		data['actionUrl'] = this.actionUrl;
		data['collectCount'] = this.collectCount;
		data['icon'] = this.icon;
		data['description'] = this.description;
		if (this.follow != null) {
      data['follow'] = this.follow.toJson();
    }
		data['cover'] = this.cover;
		data['videoCount'] = this.videoCount;
		data['shareCount'] = this.shareCount;
		data['worksSelectedCount'] = this.worksSelectedCount;
		data['name'] = this.name;
		data['self'] = this.self;
		data['myFollowCount'] = this.myFollowCount;
		data['id'] = this.id;
		data['medalsNum'] = this.medalsNum;
		data['registDate'] = this.registDate;
		return data;
	}
}

class AuthorInfoPgcinfoShield {
	int itemId;
	String itemType;
	bool shielded;

	AuthorInfoPgcinfoShield({this.itemId, this.itemType, this.shielded});

	AuthorInfoPgcinfoShield.fromJson(Map<String, dynamic> json) {
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

class AuthorInfoPgcinfoFollow {
	int itemId;
	String itemType;
	bool followed;

	AuthorInfoPgcinfoFollow({this.itemId, this.itemType, this.followed});

	AuthorInfoPgcinfoFollow.fromJson(Map<String, dynamic> json) {
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

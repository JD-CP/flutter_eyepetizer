class CategoryEntity {
	String bgColor;
	int defaultAuthorId;
	String headerImage;
	int tagId;
	String name;
	String description;
	int id;
	String bgPicture;
	String alias;

	CategoryEntity({this.bgColor, this.defaultAuthorId, this.headerImage, this.tagId, this.name, this.description, this.id, this.bgPicture, this.alias});

	CategoryEntity.fromJson(Map<String, dynamic> json) {
		bgColor = json['bgColor'];
		defaultAuthorId = json['defaultAuthorId'];
		headerImage = json['headerImage'];
		tagId = json['tagId'];
		name = json['name'];
		description = json['description'];
		id = json['id'];
		bgPicture = json['bgPicture'];
		alias = json['alias'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['bgColor'] = this.bgColor;
		data['defaultAuthorId'] = this.defaultAuthorId;
		data['headerImage'] = this.headerImage;
		data['tagId'] = this.tagId;
		data['name'] = this.name;
		data['description'] = this.description;
		data['id'] = this.id;
		data['bgPicture'] = this.bgPicture;
		data['alias'] = this.alias;
		return data;
	}
}

class UserProfileModel {
  String? login;
  String? avatarUrl;
  String? htmlUrl;
  String? reposUrl;
  String? name;
  String? blog;
  String? location;
  String? bio;
  int? publicRepos;
  int? followers;
  int? following;

  UserProfileModel({
    this.login,
    this.avatarUrl,
    this.htmlUrl,
    this.reposUrl,
    this.name,
    this.blog,
    this.location,
    this.bio,
    this.publicRepos,
    this.followers,
    this.following,
  });

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    login = json['login'];
    avatarUrl = json['avatar_url'];
    htmlUrl = json['html_url'];
    reposUrl = json['repos_url'];
    name = json['name'];
    blog = json['blog'];
    location = json['location'];
    bio = json['bio'];
    publicRepos = json['public_repos'];
    followers = json['followers'];
    following = json['following'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = login;
    data['avatar_url'] = avatarUrl;
    data['html_url'] = htmlUrl;
    data['repos_url'] = reposUrl;
    data['name'] = name;
    data['blog'] = blog;
    data['location'] = location;
    data['bio'] = bio;
    data['public_repos'] = publicRepos;
    data['followers'] = followers;
    data['following'] = following;
    return data;
  }
}

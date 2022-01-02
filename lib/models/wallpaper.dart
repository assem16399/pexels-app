class Wallpaper {
  final int? id;
  final int? width;
  final int? height;
  final String? imageUrl;
  final String? photographer;
  final String? photographerUrl;
  final int? photographerId;
  final WallpaperSource? src;
  bool inFavorites;
  final String? alt;

  Wallpaper({
    this.id,
    this.width,
    this.height,
    this.imageUrl,
    this.photographer,
    this.photographerUrl,
    this.photographerId,
    this.src,
    this.inFavorites = false,
    this.alt,
  });
}

class WallpaperSource {
  final String? original;
  final String? large;
  final String? large2x;
  final String? medium;
  final String? small;
  final String? portrait;
  final String? tiny;

  WallpaperSource({
    this.original,
    this.large,
    this.large2x,
    this.medium,
    this.small,
    this.portrait,
    this.tiny,
  });
}

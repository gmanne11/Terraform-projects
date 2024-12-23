resource "spotify_playlist" "GymPlaylist" {
  name        = "My Gym Playlist"
  public      = false

  tracks = [
    data.spotify_track.Lokiverse.id,
    data.spotify_track.Redsea.id,
    data.spotify_track.Vaathiraid.id,
    data.spotify_track.Hukum.id,
    data.spotify_track.pushpa.id,
    data.spotify_track.RaaMacha.id,
    data.spotify_track.salaar.id
  ]
}

data "spotify_track" "Lokiverse" {
  url = "https://open.spotify.com/track/5OxVOeYmIzelfupJtq1X6G"
}
data "spotify_track" "Redsea" {
  url = "https://open.spotify.com/track/75IywzsrO67PjCrFHnA9tb"
}
data "spotify_track" "Vaathiraid" {
  url = "https://open.spotify.com/track/4PML5RtrVcYAwTTS46otXB"
}

data "spotify_track" "Hukum" {
  url = "https://open.spotify.com/track/3pDbPKZHrpHAWcJVMsrNwA"
}

data "spotify_track" "pushpa" {
  url = "https://open.spotify.com/track/5bnxMZqd9Kpn9ByHj3Dc9C"
}

data "spotify_track" "RaaMacha" {
  url = "https://open.spotify.com/track/6u8t6sLXxwUmBN9rnaiuW0"
}

data "spotify_track" "salaar" {
  url = "https://open.spotify.com/track/31vpcDxdXuy1WOJjAH4JA4"
}



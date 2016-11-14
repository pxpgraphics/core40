# CORE40 iOS App:

## Estimate:
The following estimate is based on our initial discussion about the minimal proof of concept. The costs detailed below may be adjusted to meet any new project requirements. We should discuss the areas below that are undefined, because they will either reduce or increase the amount of work needed.

- Flat Rate: $10,000 - $15,000
- Hourly: $100 per hour

## Front End:

### Branding:
**Do you need an app icon?**
  - Unknown

**Do you need a digital logo?**
  - No

**Do you need mobile licensed brand image assets?**
  - If you'd like to have a user-centeric experience, I'd suggest purchasing high-res mobile stock photography. Otherwise, we can discuss other options. Modern mobile design trends are typically either completely flat UI or very image heavy to provide the best user experience for their content.
  - There are [free options](https://unsplash.com/search/fitness) as well as [paid-by-license](http://www.istockphoto.com/photos/spin-class?excludenudity=true&mediatype=photography&page=1&phrase=spin%20class&sort=best) services available for us to discuss.

### Design:
**Do you need a cutting edge user interface?**

*Main Features:*

  - multiple paged/tabbed app
  - user dashboard/profile page (Read)
  - trainer platform toggling {Spin, Lagree}
  - account info {Spin, Lagree} (Read/Update/Delete)
  - playlist management {Lagree, Spin?} (Create/Read/Update/Delete)
  - music playback timer {Lagree, Spin?} (Read)
  - music playback activity feed {Lagree, Spin?} (Create/Read/Update/Delete)
  - playlist email sharing {Lagree, Spin?}
  - playlist URL deep linking {Lagree, Spin?}
  
*Nice To Have Features:*

  - routine/exercise management {Spin, Lagree?} (Create/Read/Update/Delete)
  - routine/exercise organization / ordering {Spin, Lagree?} (Update)
  - routine/exercise notes {Spin, Lagree?} (Create/Read/Update/Delete)
  - routine/exercise email sharing {Spin, Lagree?}
  - routine/exercise URL deep linking {Spin, Lagree?}

**Do you need wireframes for user experience flows?**
  - Basic development wireframe provided at no cost

## Backend:

### Authentication:
**Do people need to log in?**
  - Facebook (OAuth2)
  - Spotify (needs Facebook)

**Do people create personal profiles?**
  - first name
  - last name
  - email
  - Facebook ID
  - playlists
  - routines (exercises)
  - activities (notes)

### Functionality:
**Does the app have any dependencies?**
  - [Spotify iOS SDK](https://developer.spotify.com/technologies/spotify-ios-sdk/), for audio streaming
  - [Spotify Web API](https://developer.spotify.com/web-api/), for modifying playlists

**Does the app need to open from external links?**
  - Send playlist(s) via email that would prompt the recipient to open in the app
  - Send routines/exercises(s) via email that would prompt the recipient to open in the app

### Hosting:
**Do you need a new hosting service for your app?**
  - Unknown

**Do you need a backend service to handle app interaction(s)?**
  - Unknown, but most likely.
  
### Product Requirements:

** How will trainers use their notes?**
  - Unknown
  
** How will trainers use their playslits?**
  - Unknown

** How will trainers use their routines?**
  - Unknown

** What is the app trying to achieve?**
  - Unknown
  
** How are you currently achieving this goal(s) without the app?**
  - Unknown

### Database:
**Do you need a database to configure and store your app's content?**

  - User:
    - first_name: String
    - last_name: String
    - email: String
    - facebook_id: Int
    - created_at: Date
    - updated_at: Date
    - playlists: [Playlist]
    - routines: [Routine]
    - activities: [Activity]


  - Playlist:
    - name: String
    - user: User
    - created_at: Date
    - updated_at: Date
    - playback_tracks: [PlaybackTrack]


  - PlaybackTrack:
    - name: String
    - uri: String
    - playback_source_name: String
    - playback_source_uri: String
    - artist_name: String
    - artist_uri: String
    - album_name: String
    - album_uri: String
    - duration: Double
    - index: Int
    - activities: [Date : Activity]


  - Routine
    - name: String
    - type: String
    - duration: Double
    - index: Int
    - user: User
    - created_at: Date
    - updated_at: Date
    - activities: [Date : Activity]


  - Activity:
    - fromUser: User
    - toUser: User
    - type: String
    - content: String
    - created_at: Date
    - updated_at: Date
    - playback_track: PlaybackTrack
    

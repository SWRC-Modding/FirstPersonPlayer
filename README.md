# First Person Player
This mod adds a visible body to the player in first person. It is multiplayer compatible (body won't be visible there) and works with any other mod that does not change the default player pawn class.

In order for it to be enabled, the `DefaultPlayer` section in User.ini must be modified:
```ini
[DefaultPlayer]
Name=Player
Class=FirstPersonPlayer.FirstPersonPlayerCommando
team=255
```

This will not work with existing save games. The current level needs to be restarted from the main menu. If an old save was loaded by mistake, it is also necessary to modify the profile specific User.ini in `GameData\Save\<profile_name>_Profile` (or just delete it).

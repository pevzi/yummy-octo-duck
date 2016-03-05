return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.14.2",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 40,
  height = 40,
  tilewidth = 32,
  tileheight = 32,
  nextobjectid = 12,
  backgroundcolor = { 255, 255, 255 },
  properties = {},
  tilesets = {
    {
      name = "tiles",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "../images/tiles.png",
      imagewidth = 32,
      imageheight = 32,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 1,
      tiles = {}
    },
    {
      name = "crate",
      firstgid = 2,
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      image = "../images/crate.png",
      imagewidth = 32,
      imageheight = 32,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 1,
      tiles = {}
    },
    {
      name = "player",
      firstgid = 3,
      tilewidth = 64,
      tileheight = 64,
      spacing = 0,
      margin = 0,
      image = "../images/player.png",
      imagewidth = 128,
      imageheight = 64,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tilecount = 2,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "impassable",
      x = 0,
      y = 0,
      width = 40,
      height = 40,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eJzt1dEJACAIBUDdf+l2yMKMO/Dbh6BmRGShbqv0kE++qgn5dvfS/P7J5z6f79G5v6/8XwAAAIDpFlhrAEE="
    },
    {
      type = "objectgroup",
      name = "interactable",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 3,
          name = "",
          type = "crate",
          shape = "rectangle",
          x = 128,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 2,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "crate",
          shape = "rectangle",
          x = 384,
          y = 224,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 2,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "crate",
          shape = "rectangle",
          x = 224,
          y = 352,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 2,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "characters",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 7,
          name = "",
          type = "player",
          shape = "rectangle",
          x = 64,
          y = 192,
          width = 32,
          height = 32,
          rotation = 0,
          gid = 4,
          visible = true,
          properties = {}
        }
      }
    }
  }
}

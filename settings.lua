data:extend({
  {
    name = "time-refill",
    type = "int-setting",
    setting_type = "runtime-global",
    default_value = 300,
    minimum_value = 1,
    maximum_value = 1000000,
    order = "ba"
  },
  {
    name = "refill-iron",
    type = "bool-setting",
    setting_type = "runtime-global",
    default_value = true,
    order = "ca"
  },
  {
    name = "refill-copper",
    type = "bool-setting",
    setting_type = "runtime-global",
    default_value = true,
    order = "cb"
  },
  {
    name = "refill-coal",
    type = "bool-setting",
    setting_type = "runtime-global",
    default_value = true,
    order = "cd"
  },
  {
    name = "refill-stone",
    type = "bool-setting",
    setting_type = "runtime-global",
    default_value = true,
    order = "ce"
  },
  {
    name = "refill-uranium",
    type = "bool-setting",
    setting_type = "runtime-global",
    default_value = true,
    order = "cf"
  },
  {
    name = "refill-modded-ores",
    type = "bool-setting",
    setting_type = "runtime-global",
    default_value = true,
    order = "cz"
  },
  {
    name = "refill-oil",
    type = "bool-setting",
    setting_type = "runtime-global",
    default_value = true,
    order = "da"
  },
  {
    name = "oil-yield",
    type = "int-setting",
    setting_type = "runtime-global",
    default_value = 100,
    minimum_value = 1,
    maximum_value = 1000000,
    order = "db"
  },
  {
    name = "refill-modded-yield",
    type = "bool-setting",
    setting_type = "runtime-global",
    default_value = true,
    order = "dy"
  },
  {
    name = "modded-yield",
    type = "int-setting",
    setting_type = "runtime-global",
    default_value = 100,
    minimum_value = 1,
    maximum_value = 1000000,
    order = "dz"
  }
});

if mods['space-age'] then
  data:extend({
    {
      name = "refill-calcite",
      type = "bool-setting",
      setting_type = "runtime-global",
      default_value = true,
      order = "cg"
    },
    {
      name = "refill-tungsten",
      type = "bool-setting",
      setting_type = "runtime-global",
      default_value = true,
      order = "ch"
    },
    {
      name = "refill-scrap",
      type = "bool-setting",
      setting_type = "runtime-global",
      default_value = true,
      order = "ci"
    },
    {
      name = "refill-lithium",
      type = "bool-setting",
      setting_type = "runtime-global",
      default_value = true,
      order = "cj"
    },
    {
      name = "refill-sulfuric-acid",
      type = "bool-setting",
      setting_type = "runtime-global",
      default_value = true,
      order = "dc"
    },
    {
      name = "sulfuric-acid-yield",
      type = "int-setting",
      setting_type = "runtime-global",
      default_value = 100,
      minimum_value = 1,
      maximum_value = 1000000,
      order = "dd"
    },
    {
      name = "refill-fluorine",
      type = "bool-setting",
      setting_type = "runtime-global",
      default_value = true,
      order = "de"
    },
    {
      name = "fluorine-yield",
      type = "int-setting",
      setting_type = "runtime-global",
      default_value = 100,
      minimum_value = 1,
      maximum_value = 1000000,
      order = "df"
    }
  });
end
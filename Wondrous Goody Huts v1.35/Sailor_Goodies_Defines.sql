UPDATE GoodyHuts SET Weight = 0 AND ImprovementType = 'IMPROVEMENT_METEOR_GOODY' WHERE GoodyHutType NOT LIKE '%SAILOR%';
CREATE TABLE IF NOT EXISTS Sailor_WondrousGoodyWeights (SubTypeGoodyHut text default null, Weight integer default 0);
--////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////
--////////// CHANGE REWARD VALUES BELOW
--////////// Weight is a percentage chance out of 100.
INSERT OR REPLACE INTO Sailor_WondrousGoodyWeights
		(SubTypeGoodyHut,						Weight) 
VALUES	('GOODYHUT_SAILOR_RANDOMRESOURCE',		100), -- Random resource granted.
		('GOODYHUT_SAILOR_RANDOMUNIT',			100), -- Random unit granted.
		('GOODYHUT_SAILOR_RANDOMIMPROVEMENT',	100), -- Random improvement granted.
		('GOODYHUT_SAILOR_SIGHTBOMB',			100), -- Increased sight + sight through features.
		('GOODYHUT_SAILOR_RANDOMPOLICY',		100), -- Random policy granted.
		('GOODYHUT_SAILOR_FORMATION',			100), -- Unit formation upgraded.
		('GOODYHUT_SAILOR_WONDER',				100), -- Discover a new natural wonder.
		('GOODYHUT_SAILOR_CITYSTATE',			100); -- Meet unmet city-state.
--////////// CHANGE REWARD VALUES ABOVE
--////////////////////////////////////////////////////////////
--////////////////////////////////////////////////////////////


--////////// Goody Huts
INSERT INTO GoodyHuts (GoodyHutType, ImprovementType, Weight, ShowMoment)
VALUES ('GOODYHUT_SAILOR_WONDROUS', 'IMPROVEMENT_GOODY_HUT', 100, 1);

--////////// Random Goody Hut Subtypes
--// 1 Resource Subtype
INSERT INTO GoodyHutSubTypes (GoodyHut, SubTypeGoodyHut, Description, Weight, ModifierID, UpgradeUnit, Turn, Experience, Heal, Relic, Trader, MinOneCity, RequiresUnit)
SELECT	'GOODYHUT_SAILOR_WONDROUS', 'GOODYHUT_SAILOR_RANDOMRESOURCE', 'LOC_GOODYHUT_SAILOR_RANDOMRESOURCE', Weight, 'SAILOR_GOODY_RANDOMRESOURCE_SWITCH', 0, 0, 0, 0, 0, 0, 0, 0
FROM Sailor_WondrousGoodyWeights WHERE SubTypeGoodyHut = 'GOODYHUT_SAILOR_RANDOMRESOURCE';

--// 2 Unit Subtype
INSERT INTO GoodyHutSubTypes (GoodyHut, SubTypeGoodyHut, Description, Weight, ModifierID, UpgradeUnit, Turn, Experience, Heal, Relic, Trader, MinOneCity, RequiresUnit)
SELECT	'GOODYHUT_SAILOR_WONDROUS', 'GOODYHUT_SAILOR_RANDOMUNIT', 'LOC_GOODYHUT_SAILOR_RANDOMUNIT', Weight, 'SAILOR_GOODY_RANDOMUNIT_SWITCH', 0, 0, 0, 0, 0, 0, 0, 0
FROM Sailor_WondrousGoodyWeights WHERE SubTypeGoodyHut = 'GOODYHUT_SAILOR_RANDOMUNIT';

--// 3 Improvement Subtype
INSERT INTO GoodyHutSubTypes (GoodyHut, SubTypeGoodyHut, Description, Weight, ModifierID, UpgradeUnit, Turn, Experience, Heal, Relic, Trader, MinOneCity, RequiresUnit)
SELECT	'GOODYHUT_SAILOR_WONDROUS', 'GOODYHUT_SAILOR_RANDOMIMPROVEMENT', 'LOC_GOODYHUT_SAILOR_RANDOMIMPROVEMENT', Weight, 'SAILOR_GOODY_RANDOMIMPROVEMENT_SWITCH', 0, 0, 0, 0, 0, 0, 0, 0
FROM Sailor_WondrousGoodyWeights WHERE SubTypeGoodyHut = 'GOODYHUT_SAILOR_RANDOMIMPROVEMENT';

--// 4 Sight Bomb Subtype
INSERT INTO GoodyHutSubTypes (GoodyHut, SubTypeGoodyHut, Description, Weight, ModifierID, UpgradeUnit, Turn, Experience, Heal, Relic, Trader, MinOneCity, RequiresUnit)
SELECT	'GOODYHUT_SAILOR_WONDROUS', 'GOODYHUT_SAILOR_SIGHTBOMB', 'LOC_GOODYHUT_SAILOR_SIGHTBOMB', Weight, 'SAILOR_GOODY_SIGHTBOMB_SWITCH', 0, 0, 0, 0, 0, 0, 0, 0
FROM Sailor_WondrousGoodyWeights WHERE SubTypeGoodyHut = 'GOODYHUT_SAILOR_SIGHTBOMB';

--// 5 RandomPolicy Subtype
INSERT INTO GoodyHutSubTypes (GoodyHut, SubTypeGoodyHut, Description, Weight, ModifierID, UpgradeUnit, Turn, Experience, Heal, Relic, Trader, MinOneCity, RequiresUnit)
SELECT	'GOODYHUT_SAILOR_WONDROUS', 'GOODYHUT_SAILOR_RANDOMPOLICY', 'LOC_GOODYHUT_SAILOR_RANDOMPOLICY', Weight, 'SAILOR_GOODY_RANDOMPOLICY_SWITCH', 0, 0, 0, 0, 0, 0, 0, 0
FROM Sailor_WondrousGoodyWeights WHERE SubTypeGoodyHut = 'GOODYHUT_SAILOR_RANDOMPOLICY';

--// 6 Formation
INSERT INTO GoodyHutSubTypes (GoodyHut, SubTypeGoodyHut, Description, Weight, ModifierID, UpgradeUnit, Turn, Experience, Heal, Relic, Trader, MinOneCity, RequiresUnit)
SELECT	'GOODYHUT_SAILOR_WONDROUS', 'GOODYHUT_SAILOR_FORMATION', 'LOC_GOODYHUT_SAILOR_FORMATION', Weight, 'SAILOR_GOODY_FORMATION_SWITCH', 0, 0, 0, 0, 0, 0, 0, 0
FROM Sailor_WondrousGoodyWeights WHERE SubTypeGoodyHut = 'GOODYHUT_SAILOR_FORMATION';

--// 7 Wonder
INSERT INTO GoodyHutSubTypes (GoodyHut, SubTypeGoodyHut, Description, Weight, ModifierID, UpgradeUnit, Turn, Experience, Heal, Relic, Trader, MinOneCity, RequiresUnit)
SELECT	'GOODYHUT_SAILOR_WONDROUS', 'GOODYHUT_SAILOR_WONDER', 'LOC_GOODYHUT_SAILOR_WONDER', Weight, 'SAILOR_GOODY_WONDER_SWITCH', 0, 0, 0, 0, 0, 0, 0, 0
FROM Sailor_WondrousGoodyWeights WHERE SubTypeGoodyHut = 'GOODYHUT_SAILOR_WONDER';

--// 8 City-State
INSERT INTO GoodyHutSubTypes (GoodyHut, SubTypeGoodyHut, Description, Weight, ModifierID, UpgradeUnit, Turn, Experience, Heal, Relic, Trader, MinOneCity, RequiresUnit)
SELECT	'GOODYHUT_SAILOR_WONDROUS', 'GOODYHUT_SAILOR_CITYSTATE', 'LOC_GOODYHUT_SAILOR_CITYSTATE', Weight, 'SAILOR_GOODY_CITYSTATE_SWITCH', 0, 0, 0, 0, 0, 0, 0, 0
FROM Sailor_WondrousGoodyWeights WHERE SubTypeGoodyHut = 'GOODYHUT_SAILOR_CITYSTATE';


--////////// Abilities
--////////// Most of these are for passing commands to the Lua side of the mod.
INSERT INTO Types (Type, Kind)
VALUES	('ABILITY_SAILOR_GOODY_RANDOMRESOURCE',		'KIND_ABILITY'),
		('ABILITY_SAILOR_GOODY_RANDOMUNIT',			'KIND_ABILITY'),
		('ABILITY_SAILOR_GOODY_RANDOMIMPROVEMENT',	'KIND_ABILITY'),
		('ABILITY_SAILOR_GOODY_SIGHTBOMB',			'KIND_ABILITY'),
		('ABILITY_SAILOR_GOODY_WILDERNESS',			'KIND_ABILITY'),
		('ABILITY_SAILOR_GOODY_RANDOMPOLICY',		'KIND_ABILITY'),
		('ABILITY_SAILOR_GOODY_FORMATION',			'KIND_ABILITY'),
		('ABILITY_SAILOR_GOODY_FORMATION_ARMY',		'KIND_ABILITY'),
		('ABILITY_SAILOR_GOODY_FORMATION_CORPS',	'KIND_ABILITY'),
		('ABILITY_SAILOR_GOODY_WONDER',				'KIND_ABILITY'),
		('ABILITY_SAILOR_GOODY_CITYSTATE',			'KIND_ABILITY');

INSERT INTO TypeTags (Type, Tag) SELECT DISTINCT 'ABILITY_SAILOR_GOODY_RANDOMRESOURCE', Tag
FROM TypeTags WHERE Type IN (SELECT UnitType FROM Units WHERE DOMAIN != 'DOMAIN_SEA');

INSERT INTO TypeTags (Type, Tag) SELECT DISTINCT 'ABILITY_SAILOR_GOODY_RANDOMUNIT',	Tag
FROM TypeTags WHERE Type IN (SELECT UnitType FROM Units WHERE DOMAIN != 'DOMAIN_SEA');

INSERT INTO TypeTags (Type, Tag) SELECT DISTINCT 'ABILITY_SAILOR_GOODY_RANDOMIMPROVEMENT', Tag
FROM TypeTags WHERE Type IN (SELECT UnitType FROM Units WHERE DOMAIN != 'DOMAIN_SEA');

INSERT INTO TypeTags (Type, Tag) SELECT DISTINCT 'ABILITY_SAILOR_GOODY_SIGHTBOMB', Tag
FROM TypeTags WHERE Type IN (SELECT UnitType FROM Units WHERE DOMAIN != 'DOMAIN_SEA');

INSERT INTO TypeTags (Type, Tag) SELECT DISTINCT 'ABILITY_SAILOR_GOODY_WILDERNESS', Tag
FROM TypeTags WHERE Type IN (SELECT UnitType FROM Units WHERE DOMAIN != 'DOMAIN_SEA');

INSERT INTO TypeTags (Type, Tag) SELECT DISTINCT 'ABILITY_SAILOR_GOODY_RANDOMPOLICY', Tag
FROM TypeTags WHERE Type IN (SELECT UnitType FROM Units WHERE DOMAIN != 'DOMAIN_SEA');

INSERT INTO TypeTags (Type, Tag) SELECT DISTINCT 'ABILITY_SAILOR_GOODY_FORMATION',	Tag
FROM TypeTags WHERE Type IN (SELECT UnitType FROM Units WHERE DOMAIN != 'DOMAIN_SEA');

INSERT INTO TypeTags (Type, Tag) SELECT DISTINCT 'ABILITY_SAILOR_GOODY_FORMATION_ARMY',	Tag
FROM TypeTags WHERE Type IN (SELECT UnitType FROM Units WHERE DOMAIN != 'DOMAIN_SEA');

INSERT INTO TypeTags (Type, Tag) SELECT DISTINCT 'ABILITY_SAILOR_GOODY_FORMATION_CORPS', Tag
FROM TypeTags WHERE Type IN (SELECT UnitType FROM Units WHERE DOMAIN != 'DOMAIN_SEA');

INSERT INTO TypeTags (Type, Tag) SELECT DISTINCT 'ABILITY_SAILOR_GOODY_WONDER',	Tag
FROM TypeTags WHERE Type IN (SELECT UnitType FROM Units WHERE DOMAIN != 'DOMAIN_SEA');

INSERT INTO TypeTags (Type, Tag) SELECT DISTINCT 'ABILITY_SAILOR_GOODY_CITYSTATE', Tag
FROM TypeTags WHERE Type IN (SELECT UnitType FROM Units WHERE DOMAIN != 'DOMAIN_SEA');

INSERT INTO UnitAbilities (UnitAbilityType,	Name, Description, Inactive, Permanent)
VALUES	('ABILITY_SAILOR_GOODY_RANDOMRESOURCE', NULL, NULL, 1, 1),
		('ABILITY_SAILOR_GOODY_RANDOMUNIT', NULL, NULL, 1, 1),
		('ABILITY_SAILOR_GOODY_RANDOMIMPROVEMENT', NULL, NULL, 1, 1),
		('ABILITY_SAILOR_GOODY_SIGHTBOMB', NULL, NULL, 1, 1),
		('ABILITY_SAILOR_GOODY_WILDERNESS', NULL, NULL, 1, 1),
		('ABILITY_SAILOR_GOODY_RANDOMPOLICY', NULL, NULL, 1, 1),
		('ABILITY_SAILOR_GOODY_FORMATION', NULL, NULL, 1, 1),
		('ABILITY_SAILOR_GOODY_FORMATION_ARMY', NULL, NULL, 1, 1),
		('ABILITY_SAILOR_GOODY_FORMATION_CORPS', NULL, NULL, 1, 1),
		('ABILITY_SAILOR_GOODY_WONDER', NULL, NULL, 1, 1),
		('ABILITY_SAILOR_GOODY_CITYSTATE', NULL, NULL, 1, 1);

INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId)
VALUES	('ABILITY_SAILOR_GOODY_WILDERNESS', 'SAILOR_GOODY_SIGHTBOMB_MOD1'),
		('ABILITY_SAILOR_GOODY_WILDERNESS', 'SAILOR_GOODY_SIGHTBOMB_MOD2'),
		('ABILITY_SAILOR_GOODY_FORMATION_ARMY',	'SAILOR_GOODY_FORMATION_ARMY'),
		('ABILITY_SAILOR_GOODY_FORMATION_CORPS', 'SAILOR_GOODY_FORMATION_CORPS');

--////////// Modifiers
INSERT INTO Modifiers (ModifierId, ModifierType)
VALUES	('SAILOR_GOODY_RANDOMRESOURCE_SWITCH', 'MODIFIER_PLAYER_UNIT_GRANT_ABILITY'),
		('SAILOR_GOODY_RANDOMUNIT_SWITCH', 'MODIFIER_PLAYER_UNIT_GRANT_ABILITY'),
		('SAILOR_GOODY_RANDOMIMPROVEMENT_SWITCH', 'MODIFIER_PLAYER_UNIT_GRANT_ABILITY'),
		('SAILOR_GOODY_SIGHTBOMB_SWITCH', 'MODIFIER_PLAYER_UNIT_GRANT_ABILITY'),
		('SAILOR_GOODY_SIGHTBOMB_MOD1', 'MODIFIER_PLAYER_UNIT_ADJUST_SIGHT'),
		('SAILOR_GOODY_SIGHTBOMB_MOD2',	'MODIFIER_PLAYER_UNIT_ADJUST_SEE_THROUGH_FEATURES'),
		('SAILOR_GOODY_RANDOMPOLICY_SWITCH', 'MODIFIER_PLAYER_UNIT_GRANT_ABILITY'),
		('SAILOR_GOODY_FORMATION_SWITCH', 'MODIFIER_PLAYER_UNIT_GRANT_ABILITY'),
		('SAILOR_GOODY_FORMATION_ARMY', 'MODIFIER_PLAYER_UNIT_ADJUST_MILITARY_FORMATION'),
		('SAILOR_GOODY_FORMATION_CORPS', 'MODIFIER_PLAYER_UNIT_ADJUST_MILITARY_FORMATION'),
		('SAILOR_GOODY_WONDER_SWITCH', 'MODIFIER_PLAYER_UNIT_GRANT_ABILITY'),
		('SAILOR_GOODY_CITYSTATE_SWITCH', 'MODIFIER_PLAYER_UNIT_GRANT_ABILITY');

INSERT INTO ModifierArguments (ModifierID, Name, Value)
VALUES	('SAILOR_GOODY_RANDOMRESOURCE_SWITCH', 'AbilityType', 'ABILITY_SAILOR_GOODY_RANDOMRESOURCE'),
		('SAILOR_GOODY_RANDOMUNIT_SWITCH', 'AbilityType', 'ABILITY_SAILOR_GOODY_RANDOMUNIT'),
		('SAILOR_GOODY_RANDOMIMPROVEMENT_SWITCH', 'AbilityType', 'ABILITY_SAILOR_GOODY_RANDOMIMPROVEMENT'),
		('SAILOR_GOODY_SIGHTBOMB_SWITCH', 'AbilityType', 'ABILITY_SAILOR_GOODY_SIGHTBOMB'),
		('SAILOR_GOODY_SIGHTBOMB_MOD1',	'Amount', 1),
		('SAILOR_GOODY_SIGHTBOMB_MOD2',	'CanSee', 1),
		('SAILOR_GOODY_RANDOMPOLICY_SWITCH', 'AbilityType', 'ABILITY_SAILOR_GOODY_RANDOMPOLICY'),
		('SAILOR_GOODY_FORMATION_SWITCH', 'AbilityType', 'ABILITY_SAILOR_GOODY_FORMATION'),
		('SAILOR_GOODY_FORMATION_ARMY', 'MilitaryFormationType', 'ARMY_MILITARY_FORMATION'),
		('SAILOR_GOODY_FORMATION_CORPS', 'MilitaryFormationType', 'CORPS_MILITARY_FORMATION'),
		('SAILOR_GOODY_WONDER_SWITCH', 'AbilityType', 'ABILITY_SAILOR_GOODY_WONDER'),
		('SAILOR_GOODY_CITYSTATE_SWITCH', 'AbilityType', 'ABILITY_SAILOR_GOODY_CITYSTATE');
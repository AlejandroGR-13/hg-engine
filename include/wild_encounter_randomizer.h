#ifndef WILD_ENCOUNTER_RANDOMIZER_H
#define WILD_ENCOUNTER_RANDOMIZER_H

#include "types.h"

/**
 *  @brief get (and, if needed, generate) this save file's wild encounter randomizer seed.
 *         the seed is rolled once per save file, the first time a wild encounter needs it,
 *         and then persisted in the save data for the rest of that playthrough.
 *
 *  @return the 32-bit seed for the current save file
 */
u32 LONG_CALL WildEncounterRandomizer_GetOrCreateSeed(void);

/**
 *  @brief deterministically pick a replacement species for a wild encounter.
 *
 *         same (save seed, originalSpecies, level) always maps to the same result within a
 *         given save file, so a location keeps giving the same substitute species every time
 *         you visit it, but a fresh save file gets a different mapping. legendaries/mythicals
 *         can appear as substitutes; mega/regional/gigantamax/cosmetic-only forms never do.
 *
 *  @param originalSpecies the species the vanilla wild encounter tables would have produced
 *  @param level the level of the wild encounter (adds a bit more variety between areas)
 *  @return the species to actually use. Returns originalSpecies unchanged if the randomizer
 *          pool could not be resolved (should not normally happen).
 */
u16 LONG_CALL WildEncounterRandomizer_GetReplacementSpecies(u16 originalSpecies, u8 level);

/**
 *  @brief deterministically pick a replacement species for one of the 3 starter slots.
 *
 *         slot 0 (grass, vanilla Chikorita), slot 1 (fire, vanilla Cyndaquil) and slot 2
 *         (water, vanilla Totodile) each resolve to a same-typed starter from any of the 9
 *         generations, at any evolution stage. Uses the same per-save seed as
 *         WildEncounterRandomizer_GetOrCreateSeed, so the result is fixed for the rest of
 *         that playthrough once rolled.
 *
 *  @param slot which starter slot (0 = grass, 1 = fire, 2 = water)
 *  @return the species to offer for that slot. Returns SPECIES_NONE for an invalid slot.
 */
u16 LONG_CALL StarterRandomizer_GetReplacementSpecies(u8 slot);

/**
 *  @brief deterministically pick a replacement item for a hidden item (Itemfinder) location.
 *
 *         same (save seed, locationIndex) always maps to the same item within a given save
 *         file, so a specific hidden item spot always gives the same thing every time you dig
 *         it up, but a fresh save file gets a different mapping.
 *
 *  @param originalItem the item the vanilla hidden item table would have given
 *  @param locationIndex the hidden item's unique index (HiddenItemData.index)
 *  @return the item to actually give. Returns originalItem unchanged if it was ITEM_NONE.
 */
u16 LONG_CALL ItemRandomizer_GetReplacementHiddenItem(u16 originalItem, u16 locationIndex);

/**
 *  @brief deterministically pick a replacement item for a Rock Smash reward slot.
 *
 *         same (save seed, tableIndex, quality) always maps to the same item within a given
 *         save file. The existing odds/quality system (including ability bonuses) is untouched -
 *         this only changes which item comes out of each slot.
 *
 *  @param originalItem the item the vanilla Rock Smash table would have given for this slot
 *  @param tableIndex which Rock Smash item table (Default/Ruins of Alph/Cliff Cave/etc.)
 *  @param quality the quality index within that table (0 = worst, higher = better)
 *  @return the item to actually give. Returns originalItem unchanged if it was ITEM_NONE.
 */
u16 LONG_CALL ItemRandomizer_GetReplacementRockSmashItem(u16 originalItem, u32 tableIndex, u32 quality);

#endif // WILD_ENCOUNTER_RANDOMIZER_H

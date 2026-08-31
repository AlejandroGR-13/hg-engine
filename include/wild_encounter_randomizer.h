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

#endif // WILD_ENCOUNTER_RANDOMIZER_H

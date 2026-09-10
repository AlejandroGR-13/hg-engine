#include "config.h"
#include "debug.h"
#include "types.h"

#include "constants/item.h"

#include "pokemon.h"
#include "save.h"
#include "script.h"
#include "wild_encounter_randomizer.h"

#ifdef MART_EXPANSION

struct MartItem {
    u16 item_id;
    u16 override_cost;
};

struct BadgeMartItems {
    u16 item_id;
    u8 required_badges;
};

// note: limited to 203 items (~34 pages)
//
// Expanded pool: the entries after the original block below are every "normal shop item" this
// hack could reasonably sell over the counter - all of POCKET_MEDICINE, POCKET_BERRIES and
// POCKET_BATTLE_ITEMS, plus a curated batch of evolution stones, type plates, held-item gems,
// Apricorns, EV-training feathers, misc valuables (Heart Scale, Star Piece, shards, ...) and
// classic type-boosting/utility held items - deliberately EXCLUDING Poké Balls (progression is
// tied to badge count already via the entries above, more ball variety doesn't belong here),
// Mega Stones, and every item in sCompetitiveItemPool, since both of those already have their
// own dedicated unlock condition appended below in ScrCmd_MartBuy (MegaStoneShop_GetItems /
// CompetitiveItemShop_GetItems) - listing them here too would just be a redundant duplicate.
// (They also each get an independent, seeded CHANCE of showing up here early regardless of that
// unlock condition - see MART_BONUS_MEGA_STONE_CHANCE_PERCENT / MART_BONUS_COMPETITIVE_CHANCE_PERCENT
// below.) Also deliberately excluded: Rare Candy, every revive (Revive/Max Revive/Revival Herb),
// and X Attack/X Defense/X Accuracy specifically - these stay tied to their existing sources
// (Goldenrod/Celadon Dept. Store, Battle Frontier, wild/gift pickups, etc.) instead of being sold
// freely everywhere; the other X-items (Speed/Sp.Atk/Sp.Def), Dire Hit and Guard Spec are unaffected.
// Badge requirement is assigned by each item's own shop price (cheapest -> earliest, spread
// evenly 0-8 badges) rather than hand-picked, since there's no other "rarity" signal to sort by.
const struct BadgeMartItems sBadgeMart[] = {
    { ITEM_POKE_BALL, 0 },
    { ITEM_GREAT_BALL, 3 },
    { ITEM_ULTRA_BALL, 5 },
    { ITEM_POTION, 0 },
    { ITEM_SUPER_POTION, 1 },
    { ITEM_HYPER_POTION, 5 },
    { ITEM_MAX_POTION, 7 },
    { ITEM_FULL_RESTORE, 8 },
    { ITEM_ANTIDOTE, 0 },
    { ITEM_PARALYZE_HEAL, 0 },
    { ITEM_AWAKENING, 1 },
    { ITEM_BURN_HEAL, 1 },
    { ITEM_ICE_HEAL, 1 },
    { ITEM_FULL_HEAL, 5 },
    { ITEM_ESCAPE_ROPE, 1 },
    { ITEM_REPEL, 1 },
    { ITEM_SUPER_REPEL, 3 },
    { ITEM_MAX_REPEL, 5 },
    { ITEM_RAZZ_BERRY, 0 },
    { ITEM_BLUK_BERRY, 0 },
    { ITEM_NANAB_BERRY, 0 },
    { ITEM_WEPEAR_BERRY, 0 },
    { ITEM_PINAP_BERRY, 0 },
    { ITEM_CORNN_BERRY, 0 },
    { ITEM_MAGOST_BERRY, 0 },
    { ITEM_RABUTA_BERRY, 0 },
    { ITEM_NOMEL_BERRY, 0 },
    { ITEM_SPELON_BERRY, 0 },
    { ITEM_PAMTRE_BERRY, 0 },
    { ITEM_WATMEL_BERRY, 0 },
    { ITEM_DURIN_BERRY, 0 },
    { ITEM_BELUE_BERRY, 0 },
    { ITEM_CHERI_BERRY, 0 },
    { ITEM_CHESTO_BERRY, 0 },
    { ITEM_PECHA_BERRY, 0 },
    { ITEM_RAWST_BERRY, 0 },
    { ITEM_ASPEAR_BERRY, 0 },
    { ITEM_LEPPA_BERRY, 0 },
    { ITEM_ORAN_BERRY, 1 },
    { ITEM_PERSIM_BERRY, 1 },
    { ITEM_LUM_BERRY, 1 },
    { ITEM_SITRUS_BERRY, 1 },
    { ITEM_FIGY_BERRY, 1 },
    { ITEM_WIKI_BERRY, 1 },
    { ITEM_MAGO_BERRY, 1 },
    { ITEM_AGUAV_BERRY, 1 },
    { ITEM_IAPAPA_BERRY, 1 },
    { ITEM_POMEG_BERRY, 1 },
    { ITEM_KELPSY_BERRY, 1 },
    { ITEM_QUALOT_BERRY, 1 },
    { ITEM_HONDEW_BERRY, 1 },
    { ITEM_GREPA_BERRY, 1 },
    { ITEM_TAMATO_BERRY, 1 },
    { ITEM_OCCA_BERRY, 1 },
    { ITEM_PASSHO_BERRY, 1 },
    { ITEM_WACAN_BERRY, 1 },
    { ITEM_RINDO_BERRY, 1 },
    { ITEM_YACHE_BERRY, 1 },
    { ITEM_CHOPLE_BERRY, 2 },
    { ITEM_KEBIA_BERRY, 2 },
    { ITEM_SHUCA_BERRY, 2 },
    { ITEM_COBA_BERRY, 2 },
    { ITEM_PAYAPA_BERRY, 2 },
    { ITEM_TANGA_BERRY, 2 },
    { ITEM_CHARTI_BERRY, 2 },
    { ITEM_KASIB_BERRY, 2 },
    { ITEM_HABAN_BERRY, 2 },
    { ITEM_COLBUR_BERRY, 2 },
    { ITEM_BABIRI_BERRY, 2 },
    { ITEM_CHILAN_BERRY, 2 },
    { ITEM_LIECHI_BERRY, 2 },
    { ITEM_GANLON_BERRY, 2 },
    { ITEM_SALAC_BERRY, 2 },
    { ITEM_PETAYA_BERRY, 2 },
    { ITEM_APICOT_BERRY, 2 },
    { ITEM_LANSAT_BERRY, 2 },
    { ITEM_STARF_BERRY, 2 },
    { ITEM_ENIGMA_BERRY, 2 },
    { ITEM_MICLE_BERRY, 3 },
    { ITEM_CUSTAP_BERRY, 3 },
    { ITEM_JABOCA_BERRY, 3 },
    { ITEM_ROWAP_BERRY, 3 },
    { ITEM_ROSELI_BERRY, 3 },
    { ITEM_BERRY_JUICE, 3 },
    { ITEM_SWEET_HEART, 3 },
    { ITEM_CASTELIACONE, 3 },
    { ITEM_BLUE_FLUTE, 3 },
    { ITEM_HEART_SCALE, 3 },
    { ITEM_FRESH_WATER, 3 },
    { ITEM_LAVA_COOKIE, 3 },
    { ITEM_SACRED_ASH, 3 },
    { ITEM_OLD_GATEAU, 3 },
    { ITEM_YELLOW_FLUTE, 3 },
    { ITEM_RED_SHARD, 3 },
    { ITEM_BLUE_SHARD, 3 },
    { ITEM_YELLOW_SHARD, 3 },
    { ITEM_GREEN_SHARD, 3 },
    { ITEM_FIRE_GEM, 3 },
    { ITEM_WATER_GEM, 4 },
    { ITEM_ELECTRIC_GEM, 4 },
    { ITEM_GRASS_GEM, 4 },
    { ITEM_ICE_GEM, 4 },
    { ITEM_FIGHTING_GEM, 4 },
    { ITEM_POISON_GEM, 4 },
    { ITEM_GROUND_GEM, 4 },
    { ITEM_FLYING_GEM, 4 },
    { ITEM_PSYCHIC_GEM, 4 },
    { ITEM_BUG_GEM, 4 },
    { ITEM_ROCK_GEM, 4 },
    { ITEM_GHOST_GEM, 4 },
    { ITEM_DRAGON_GEM, 4 },
    { ITEM_DARK_GEM, 4 },
    { ITEM_STEEL_GEM, 4 },
    { ITEM_FAIRY_GEM, 4 },
    { ITEM_RED_APRICORN, 4 },
    { ITEM_YELLOW_APRICORN, 4 },
    { ITEM_BLUE_APRICORN, 4 },
    { ITEM_GREEN_APRICORN, 4 },
    { ITEM_PINK_APRICORN, 5 },
    { ITEM_WHITE_APRICORN, 5 },
    { ITEM_BLACK_APRICORN, 5 },
    { ITEM_SODA_POP, 5 },
    { ITEM_HEAL_POWDER, 5 },
    { ITEM_POKE_DOLL, 5 },
    { ITEM_RED_FLUTE, 5 },
    { ITEM_HEALTH_FEATHER, 5 },
    { ITEM_MUSCLE_FEATHER, 5 },
    { ITEM_RESIST_FEATHER, 5 },
    { ITEM_GENIUS_FEATHER, 5 },
    { ITEM_CLEVER_FEATHER, 5 },
    { ITEM_SWIFT_FEATHER, 5 },
    { ITEM_LUMIOSE_GALETTE, 5 },
    { ITEM_SHALOUR_SABLE, 5 },
    { ITEM_BIG_MALASADA, 5 },
    { ITEM_LEMONADE, 5 },
    { ITEM_ENERGY_POWDER, 5 },
    { ITEM_PEWTER_CRUNCHIES, 5 },
    { ITEM_MOOMOO_MILK, 5 },
    { ITEM_DIRE_HIT, 6 },
    { ITEM_X_SPEED, 6 },
    { ITEM_X_SP_ATK, 6 },
    { ITEM_FLUFFY_TAIL, 6 },
    { ITEM_FLAME_PLATE, 6 },
    { ITEM_SPLASH_PLATE, 6 },
    { ITEM_ZAP_PLATE, 6 },
    { ITEM_MEADOW_PLATE, 6 },
    { ITEM_ICICLE_PLATE, 6 },
    { ITEM_FIST_PLATE, 6 },
    { ITEM_TOXIC_PLATE, 6 },
    { ITEM_EARTH_PLATE, 6 },
    { ITEM_SKY_PLATE, 6 },
    { ITEM_MIND_PLATE, 6 },
    { ITEM_INSECT_PLATE, 6 },
    { ITEM_STONE_PLATE, 6 },
    { ITEM_SPOOKY_PLATE, 6 },
    { ITEM_DRACO_PLATE, 6 },
    { ITEM_DREAD_PLATE, 7 },
    { ITEM_IRON_PLATE, 7 },
    { ITEM_PIXIE_PLATE, 7 },
    { ITEM_TINY_MUSHROOM, 7 },
    { ITEM_ENERGY_ROOT, 7 },
    { ITEM_ETHER, 7 },
    { ITEM_GUARD_SPEC, 7 },
    { ITEM_MAX_ETHER, 7 },
    { ITEM_X_SP_DEF, 7 },
    { ITEM_PRETTY_FEATHER, 7 },
    { ITEM_ELIXIR, 7 },
    { ITEM_SUN_STONE, 7 },
    { ITEM_MOON_STONE, 7 },
    { ITEM_FIRE_STONE, 7 },
    { ITEM_THUNDER_STONE, 7 },
    { ITEM_WATER_STONE, 7 },
    { ITEM_LEAF_STONE, 7 },
    { ITEM_SHINY_STONE, 7 },
    { ITEM_DUSK_STONE, 8 },
    { ITEM_DAWN_STONE, 8 },
    { ITEM_ICE_STONE, 8 },
    { ITEM_PEARL, 8 },
    { ITEM_MAX_ELIXIR, 8 },
    { ITEM_STARDUST, 8 },
    { ITEM_HP_UP, 8 },
    { ITEM_PROTEIN, 8 },
    { ITEM_IRON, 8 },
    { ITEM_CARBOS, 8 },
    { ITEM_CALCIUM, 8 },
    { ITEM_PP_UP, 8 },
    { ITEM_ZINC, 8 },
    { ITEM_PP_MAX, 8 },
    { ITEM_NORMAL_GEM, 8 },
    { ITEM_BIG_PEARL, 8 },
    { ITEM_STAR_PIECE, 8 },
    { ITEM_ABILITY_CAPSULE, 8 },
};

void LONG_CALL InitMartUI(void *taskManager, FieldSystem *fieldSystem, const u16 *items, int kind, int buySell, int decoWhich, const struct MartItem *priceOverrides);

#ifdef MEGA_STONE_MART_EXPANSION
// unlocks the Mega Stone shop stock (see MegaStoneShop_GetItems) once you've earned this many badges.
#define MEGA_STONE_SHOP_REQUIRED_BADGES 6
// Independent of that badge requirement: every save also gets one persistent, seeded roll (so
// it's the same answer for the whole playthrough, not re-rolled per visit) for a small chance
// that a handful of Mega Stones show up in the mart even before badge 6. See ScrCmd_MartBuy.
#define MART_BONUS_MEGA_STONE_CHANCE_PERCENT 30
#define MART_BONUS_MEGA_STONE_SLOTS 5
#endif

// competitive item shop unlocks once PlayerProfile.gameClear is set (i.e. you've beaten the
// Champion) - same flag ProgressiveLevelCap_Get (src/pokemon.c) uses. Its item pool
// (sCompetitiveItemPool) and selection (CompetitiveItemShop_GetItems) live in
// src/wild_encounter_randomizer.c alongside the other shop/randomizer pools.
//
// Independent of the Champion requirement: same idea as the Mega Stone bonus roll above - one
// persistent, seeded chance per save for a handful of competitive items to show up in the mart
// even before beating the Champion. See ScrCmd_MartBuy.
#ifdef COMPETITIVE_ITEM_MART_EXPANSION
#define MART_BONUS_COMPETITIVE_CHANCE_PERCENT 30
#define MART_BONUS_COMPETITIVE_SLOTS 5
#endif

u16 sCherrygroveCityMart[] = {
    ITEM_AIR_MAIL, ITEM_HEAL_BALL, 0xFFFF
};

u16 sVioletCityMart[] = {
    ITEM_TUNNEL_MAIL, ITEM_HEAL_BALL, ITEM_NET_BALL, 0xFFFF
};

u16 sAzaleaCityMart[] = {
    ITEM_BLOOM_MAIL, ITEM_HEAL_BALL, ITEM_NET_BALL, 0xFFFF
};

u16 sGoldenrodDepartmentUpper2F[] = {
    ITEM_POTION, ITEM_SUPER_POTION, ITEM_HYPER_POTION, ITEM_MAX_POTION, ITEM_REVIVE, ITEM_ANTIDOTE, ITEM_PARALYZE_HEAL, ITEM_BURN_HEAL, ITEM_ICE_HEAL, ITEM_AWAKENING, ITEM_FULL_HEAL, 0xFFFF
};

u16 sGoldenrodDepartmentLower2F[] = {
    ITEM_POKE_BALL, ITEM_GREAT_BALL, ITEM_ULTRA_BALL, ITEM_ESCAPE_ROPE, ITEM_POKE_DOLL, ITEM_REPEL, ITEM_SUPER_REPEL, ITEM_MAX_REPEL, ITEM_GRASS_MAIL, ITEM_FLAME_MAIL, ITEM_BUBBLE_MAIL, ITEM_SPACE_MAIL, 0xFFFF
};

u16 sGoldenrodDepartment3F[] = {
    ITEM_X_SPEED, ITEM_X_ATTACK, ITEM_X_DEFENSE, ITEM_GUARD_SPEC, ITEM_DIRE_HIT, ITEM_X_ACCURACY, ITEM_X_SP_ATK, ITEM_X_SP_DEF, 0xFFFF
};

u16 sGoldenrodDepartment4F[] = {
    ITEM_PROTEIN, ITEM_IRON, ITEM_CALCIUM, ITEM_ZINC, ITEM_CARBOS, ITEM_HP_UP, 0xFFFF
};

u16 sGoldenrodDepartment5F[] = {
    ITEM_TM070, ITEM_TM017, ITEM_TM054, ITEM_TM083, ITEM_TM016, ITEM_TM033, ITEM_TM022, ITEM_TM052, ITEM_TM038, ITEM_TM025, ITEM_TM014, ITEM_TM015, 0xFFFF
};

u16 sGoldenrodHerbs[] = {
    ITEM_HEAL_POWDER, ITEM_ENERGY_POWDER, ITEM_ENERGY_ROOT, ITEM_REVIVAL_HERB, 0xFFFF
};

u16 sEcruteakMart[] = {
    ITEM_HEART_MAIL, ITEM_HEAL_BALL, ITEM_NET_BALL, 0xFFFF
};

u16 sOlivineMart[] = {
    ITEM_HEART_MAIL, ITEM_HEAL_BALL, ITEM_NET_BALL, 0xFFFF
};

u16 sCianwoodPharmacy[] = {
    ITEM_POTION, ITEM_SUPER_POTION, ITEM_HYPER_POTION, ITEM_FULL_HEAL, ITEM_REVIVE, 0xFFFF
};

u16 sBlackthornAndBattleFrontierMart[] = {
    ITEM_AIR_MAIL, ITEM_NET_BALL, ITEM_DUSK_BALL, 0xFFFF
};

u16 sIndigoPlateau[] = {
    ITEM_ULTRA_BALL, ITEM_MAX_REPEL, ITEM_HYPER_POTION, ITEM_MAX_POTION, ITEM_FULL_RESTORE, ITEM_REVIVE, ITEM_FULL_HEAL, 0xFFFF
};

u16 sVermilionAndSafariMart[] = {
    ITEM_AIR_MAIL, ITEM_NEST_BALL, ITEM_DUSK_BALL, ITEM_QUICK_BALL, 0xFFFF
};

u16 sSaffronMart[] = {
    ITEM_AIR_MAIL, ITEM_DUSK_BALL, ITEM_QUICK_BALL, 0xFFFF
};

u16 sLavenderMart[] = {
    ITEM_AIR_MAIL, ITEM_DUSK_BALL, ITEM_QUICK_BALL, 0xFFFF
};

u16 sCeruleanMart[] = {
    ITEM_AIR_MAIL, ITEM_QUICK_BALL, 0xFFFF
};

u16 sCeladonDepartmentUpper2F[] = {
    ITEM_POTION, ITEM_SUPER_POTION, ITEM_HYPER_POTION, ITEM_MAX_POTION, ITEM_REVIVE, ITEM_ANTIDOTE, ITEM_PARALYZE_HEAL, ITEM_BURN_HEAL, ITEM_ICE_HEAL, ITEM_AWAKENING, ITEM_FULL_HEAL, 0xFFFF
};

u16 sCeladonDepartmentLower2F[] = {
    ITEM_POKE_BALL, ITEM_GREAT_BALL, ITEM_ULTRA_BALL, ITEM_ESCAPE_ROPE, ITEM_POKE_DOLL, ITEM_REPEL, ITEM_SUPER_REPEL, ITEM_MAX_REPEL, ITEM_GRASS_MAIL, ITEM_FLAME_MAIL, ITEM_BUBBLE_MAIL, ITEM_SPACE_MAIL, 0xFFFF
};

u16 sCeladonDepartment3F[] = {
    ITEM_TM021, ITEM_TM027, ITEM_TM087, ITEM_TM078, ITEM_TM012, ITEM_TM041, ITEM_TM020, ITEM_TM028, ITEM_TM076, ITEM_TM055, ITEM_TM072, ITEM_TM079, 0xFFFF
};

u16 sCeladonDepartment4F[] = {
    ITEM_AIR_MAIL, ITEM_TUNNEL_MAIL, ITEM_BLOOM_MAIL, 0xFFFF
};

u16 sCeladonDepartmentLeft5F[] = {
    ITEM_X_SPEED, ITEM_X_ATTACK, ITEM_X_DEFENSE, ITEM_GUARD_SPEC, ITEM_DIRE_HIT, ITEM_X_ACCURACY, ITEM_X_SP_ATK, ITEM_X_SP_DEF, 0xFFFF
};

u16 sCeladonDepartmentRight5F[] = {
    ITEM_PROTEIN, ITEM_IRON, ITEM_CALCIUM, ITEM_ZINC, ITEM_CARBOS, ITEM_HP_UP, 0xFFFF
};

u16 sFuschiaMart[] = {
    ITEM_STEEL_MAIL, ITEM_DUSK_BALL, ITEM_QUICK_BALL, 0xFFFF
};

u16 sPewterMart[] = {
    ITEM_STEEL_MAIL, ITEM_NEST_BALL, ITEM_QUICK_BALL, 0xFFFF
};

u16 sViridianMart[] = {
    ITEM_STEEL_MAIL, ITEM_NET_BALL, ITEM_HEAL_BALL, 0xFFFF
};

u16 sMtMoonSquare[] = {
    ITEM_POKE_DOLL, ITEM_FRESH_WATER, ITEM_SODA_POP, ITEM_LEMONADE, ITEM_REPEL, ITEM_HEART_MAIL, 0xFFFF
};

u16 sMahoganyPreRocketHideout[] = {
    ITEM_TINY_MUSHROOM, ITEM_POKE_BALL, ITEM_POTION, 0xFFFF
};

u16 sMahoganyPostRocketHideout[] = {
    ITEM_GREAT_BALL, ITEM_SUPER_POTION, ITEM_HYPER_POTION, ITEM_ANTIDOTE, ITEM_PARALYZE_HEAL, ITEM_SUPER_REPEL, ITEM_REVIVE, ITEM_AIR_MAIL, 0xFFFF
};

// how many extra slots ScrCmd_MartBuy's items[] buffer needs beyond sBadgeMart for the
// optional Mega Stone / competitive item shops (0 when a feature is disabled).
#ifdef MEGA_STONE_MART_EXPANSION
#define MART_BUY_MEGA_STONE_SLOTS MEGA_STONE_SHOP_MAX_ITEMS
#else
#define MART_BUY_MEGA_STONE_SLOTS 0
#endif

#ifdef COMPETITIVE_ITEM_MART_EXPANSION
#define MART_BUY_COMPETITIVE_SLOTS COMPETITIVE_ITEM_SHOP_MAX_ITEMS
#else
#define MART_BUY_COMPETITIVE_SLOTS 0
#endif

BOOL ScrCmd_MartBuy(SCRIPTCONTEXT *ctx)
{
    u16 unused UNUSED = ScriptGetVar(ctx);

    u16 items[NELEMS(sBadgeMart) + MART_BUY_MEGA_STONE_SLOTS + MART_BUY_COMPETITIVE_SLOTS + 1];
    struct PlayerProfile *profile = Sav2_PlayerData_GetProfileAddr(ctx->fsys->savedata);
    u8 badgeCount = 0;
    u8 index = 0;
    u32 i;

    for (i = 0; i < 16; i++) {
        if (PlayerProfile_TestBadgeFlag(profile, i) == TRUE) {
            badgeCount++;
        }
    }

    for (i = 0; i < NELEMS(sBadgeMart); i++) {
        if (badgeCount >= sBadgeMart[i].required_badges) {
            items[index] = sBadgeMart[i].item_id;
            index++;
        }
    }

#ifdef MEGA_STONE_MART_EXPANSION
    // Mega Stone shop: unlocks once you've earned your MEGA_STONE_SHOP_REQUIRED_BADGES-th
    // badge. Offers a random subset of every Mega Stone in the game - fixed for the rest of
    // the save the first time it's rolled, so it's the same stock every time you check, but
    // different from one playthrough to the next.
    if (badgeCount >= MEGA_STONE_SHOP_REQUIRED_BADGES) {
        u16 megaStones[MEGA_STONE_SHOP_MAX_ITEMS];
        u32 megaStoneCount = MegaStoneShop_GetItems(megaStones, MEGA_STONE_SHOP_MAX_ITEMS);

        for (i = 0; i < megaStoneCount; i++) {
            items[index] = megaStones[i];
            index++;
        }
    } else {
        // Not unlocked yet - but every save still gets one persistent, seeded roll for a small
        // chance that a handful of Mega Stones show up early anyway. MegaStoneShop_GetItems'
        // selection is deterministic per save, so the few stones handed out here are always a
        // subset of whatever the full shop above would eventually offer - never a duplicate,
        // and never a different roll depending on when this script runs.
        u32 seed = WildEncounterRandomizer_GetOrCreateSeed();
        u32 mixed = seed ^ 0x4D454741u; // "MEGA" salt
        mixed ^= mixed >> 16;
        mixed *= 0x7feb352du;
        mixed ^= mixed >> 15;
        mixed *= 0x846ca68bu;
        mixed ^= mixed >> 16;

        if ((mixed % 100) < MART_BONUS_MEGA_STONE_CHANCE_PERCENT) {
            u16 bonusMegaStones[MART_BONUS_MEGA_STONE_SLOTS];
            u32 bonusMegaStoneCount = MegaStoneShop_GetItems(bonusMegaStones, MART_BONUS_MEGA_STONE_SLOTS);

            for (i = 0; i < bonusMegaStoneCount; i++) {
                items[index] = bonusMegaStones[i];
                index++;
            }
        }
    }
#endif

#ifdef COMPETITIVE_ITEM_MART_EXPANSION
    // Competitive item shop: unlocks once you've become Champion (PlayerProfile.gameClear).
    // Offers a random subset (about half) of the competitive item pool - fixed for the rest
    // of the save the first time it's rolled, different from one playthrough to the next.
    if (profile->gameClear) {
        u16 competitiveItems[COMPETITIVE_ITEM_SHOP_MAX_ITEMS];
        u32 competitiveItemCount = CompetitiveItemShop_GetItems(competitiveItems, COMPETITIVE_ITEM_SHOP_MAX_ITEMS);

        for (i = 0; i < competitiveItemCount; i++) {
            items[index] = competitiveItems[i];
            index++;
        }
    } else {
        // Same idea as the Mega Stone bonus above: not Champion yet, but still a persistent,
        // seeded chance for a handful of competitive items to show up early - always a subset
        // of the eventual full shop's selection, so nothing is ever duplicated once you win.
        u32 seed = WildEncounterRandomizer_GetOrCreateSeed();
        u32 mixed = seed ^ 0x434F4D50u; // "COMP" salt
        mixed ^= mixed >> 16;
        mixed *= 0x7feb352du;
        mixed ^= mixed >> 15;
        mixed *= 0x846ca68bu;
        mixed ^= mixed >> 16;

        if ((mixed % 100) < MART_BONUS_COMPETITIVE_CHANCE_PERCENT) {
            u16 bonusCompetitiveItems[MART_BONUS_COMPETITIVE_SLOTS];
            u32 bonusCompetitiveItemCount = CompetitiveItemShop_GetItems(bonusCompetitiveItems, MART_BONUS_COMPETITIVE_SLOTS);

            for (i = 0; i < bonusCompetitiveItemCount; i++) {
                items[index] = bonusCompetitiveItems[i];
                index++;
            }
        }
    }
#endif

    items[index] = 0xFFFF;
    InitMartUI(ctx->taskman, ctx->fsys, items, 0, 0, 0, 0); // this doesn't honor price overrides
    return TRUE;
}

#endif // MART_EXPANSION

#ifdef POKEATHLON_SHOP_EXPANSION

const struct MartItem sPokeathlonShop_Sunday[] = {
    { ITEM_RED_APRICORN, 200 },
    { ITEM_BLUE_APRICORN, 200 },
    { ITEM_BLACK_APRICORN, 200 },
    { ITEM_MOOMOO_MILK, 100 },
    { ITEM_KINGS_ROCK, 3000 },
    { ITEM_HEART_SCALE, 1000 },
    { 0xFFFF, 0 },
};

const struct MartItem sPokeathlonShop_Monday[] = {
    { ITEM_RED_APRICORN, 200 },
    { ITEM_BLUE_APRICORN, 200 },
    { ITEM_GREEN_APRICORN, 200 },
    { ITEM_MOOMOO_MILK, 100 },
    { ITEM_MOON_STONE, 3000 },
    { ITEM_RARE_CANDY, 2000 },
    { 0xFFFF, 0 },
};

const struct MartItem sPokeathlonShop_Tuesday[] = {
    { ITEM_YELLOW_APRICORN, 200 },
    { ITEM_PINK_APRICORN, 200 },
    { ITEM_WHITE_APRICORN, 200 },
    { ITEM_MOOMOO_MILK, 100 },
    { ITEM_FIRE_STONE, 2500 },
    { ITEM_PP_UP, 1000 },
    { 0xFFFF, 0 },
};

const struct MartItem sPokeathlonShop_Wednesday[] = {
    { ITEM_BLUE_APRICORN, 200 },
    { ITEM_PINK_APRICORN, 200 },
    { ITEM_BLACK_APRICORN, 200 },
    { ITEM_MOOMOO_MILK, 100 },
    { ITEM_WATER_STONE, 2500 },
    { ITEM_HEART_SCALE, 1000 },
    { 0xFFFF, 0 },
};

const struct MartItem sPokeathlonShop_Thursday[] = {
    { ITEM_YELLOW_APRICORN, 200 },
    { ITEM_PINK_APRICORN, 200 },
    { ITEM_WHITE_APRICORN, 200 },
    { ITEM_MOOMOO_MILK, 100 },
    { ITEM_THUNDER_STONE, 2500 },
    { ITEM_PP_UP, 1000 },
    { 0xFFFF, 0 },
};

const struct MartItem sPokeathlonShop_Friday[] = {
    { ITEM_RED_APRICORN, 200 },
    { ITEM_YELLOW_APRICORN, 200 },
    { ITEM_GREEN_APRICORN, 200 },
    { ITEM_MOOMOO_MILK, 100 },
    { ITEM_METAL_COAT, 2500 },
    { ITEM_NUGGET, 500 },
    { 0xFFFF, 0 },
};

const struct MartItem sPokeathlonShop_Saturday[] = {
    { ITEM_GREEN_APRICORN, 200 },
    { ITEM_WHITE_APRICORN, 200 },
    { ITEM_BLACK_APRICORN, 200 },
    { ITEM_MOOMOO_MILK, 100 },
    { ITEM_LEAF_STONE, 2500 },
    { ITEM_RARE_CANDY, 2000 },
    { 0xFFFF, 0 },
};

const struct MartItem sPokeathlonShop_NatdexSunday[] = {
    { ITEM_RED_APRICORN, 200 },
    { ITEM_BLUE_APRICORN, 200 },
    { ITEM_BLACK_APRICORN, 200 },
    { ITEM_MOOMOO_MILK, 100 },
    { ITEM_KINGS_ROCK, 3000 },
    { ITEM_HEART_SCALE, 1000 },
    { ITEM_FULL_RESTORE, 500 },
    { ITEM_NUGGET, 500 },
    { ITEM_SUN_STONE, 3000 },
    { ITEM_FIRE_STONE, 2500 },
    { ITEM_SHINY_STONE, 3000 },
    { ITEM_DAWN_STONE, 3000 },
    { 0xFFFF, 0 },
};

const struct MartItem sPokeathlonShop_NatdexMonday[] = {
    { ITEM_RED_APRICORN, 200 },
    { ITEM_BLUE_APRICORN, 200 },
    { ITEM_GREEN_APRICORN, 200 },
    { ITEM_MOOMOO_MILK, 100 },
    { ITEM_MOON_STONE, 3000 },
    { ITEM_RARE_CANDY, 2000 },
    { ITEM_FULL_RESTORE, 500 },
    { ITEM_KINGS_ROCK, 3000 },
    { ITEM_SUN_STONE, 3000 },
    { ITEM_WATER_STONE, 2500 },
    { ITEM_SHINY_STONE, 3000 },
    { ITEM_DUSK_STONE, 3000 },
    { 0xFFFF, 0 },
};

const struct MartItem sPokeathlonShop_NatdexTuesday[] = {
    { ITEM_YELLOW_APRICORN, 200 },
    { ITEM_PINK_APRICORN, 200 },
    { ITEM_WHITE_APRICORN, 200 },
    { ITEM_MOOMOO_MILK, 100 },
    { ITEM_FIRE_STONE, 2500 },
    { ITEM_PP_UP, 1000 },
    { ITEM_FULL_RESTORE, 500 },
    { ITEM_METAL_COAT, 2500 },
    { ITEM_WATER_STONE, 2500 },
    { ITEM_LEAF_STONE, 2500 },
    { ITEM_DUSK_STONE, 3000 },
    { ITEM_DAWN_STONE, 3000 },
    { 0xFFFF, 0 },
};

const struct MartItem sPokeathlonShop_NatdexWednesday[] = {
    { ITEM_BLUE_APRICORN, 200 },
    { ITEM_PINK_APRICORN, 200 },
    { ITEM_BLACK_APRICORN, 200 },
    { ITEM_MOOMOO_MILK, 100 },
    { ITEM_WATER_STONE, 2500 },
    { ITEM_HEART_SCALE, 1000 },
    { ITEM_FULL_RESTORE, 500 },
    { ITEM_DRAGON_SCALE, 2500 },
    { ITEM_THUNDER_STONE, 2500 },
    { ITEM_MOON_STONE, 3000 },
    { ITEM_SHINY_STONE, 3000 },
    { ITEM_DAWN_STONE, 3000 },
    { 0xFFFF, 0 },
};

const struct MartItem sPokeathlonShop_NatdexThursday[] = {
    { ITEM_YELLOW_APRICORN, 200 },
    { ITEM_PINK_APRICORN, 200 },
    { ITEM_WHITE_APRICORN, 200 },
    { ITEM_MOOMOO_MILK, 100 },
    { ITEM_THUNDER_STONE, 2500 },
    { ITEM_PP_UP, 1000 },
    { ITEM_FULL_RESTORE, 500 },
    { ITEM_KINGS_ROCK, 3000 },
    { ITEM_FIRE_STONE, 2500 },
    { ITEM_LEAF_STONE, 2500 },
    { ITEM_SHINY_STONE, 3000 },
    { ITEM_DUSK_STONE, 3000 },
    { 0xFFFF, 0 },
};

const struct MartItem sPokeathlonShop_NatdexFriday[] = {
    { ITEM_RED_APRICORN, 200 },
    { ITEM_YELLOW_APRICORN, 200 },
    { ITEM_GREEN_APRICORN, 200 },
    { ITEM_MOOMOO_MILK, 100 },
    { ITEM_METAL_COAT, 2500 },
    { ITEM_NUGGET, 500 },
    { ITEM_FULL_RESTORE, 500 },
    { ITEM_DRAGON_SCALE, 2500 },
    { ITEM_WATER_STONE, 2500 },
    { ITEM_SUN_STONE, 3000 },
    { ITEM_DUSK_STONE, 3000 },
    { ITEM_DAWN_STONE, 3000 },
    { 0xFFFF, 0 },
};

const struct MartItem sPokeathlonShop_NatdexSaturday[] = {
    { ITEM_GREEN_APRICORN, 200 },
    { ITEM_WHITE_APRICORN, 200 },
    { ITEM_BLACK_APRICORN, 200 },
    { ITEM_MOOMOO_MILK, 100 },
    { ITEM_LEAF_STONE, 2500 },
    { ITEM_RARE_CANDY, 2000 },
    { ITEM_FULL_RESTORE, 500 },
    { ITEM_METAL_COAT, 2500 },
    { ITEM_THUNDER_STONE, 2500 },
    { ITEM_SHINY_STONE, 3000 },
    { ITEM_DUSK_STONE, 3000 },
    { ITEM_DAWN_STONE, 3000 },
    { 0xFFFF, 0 },
};

#endif // POKEATHLON_SHOP_EXPANSION

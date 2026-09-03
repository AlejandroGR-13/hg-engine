#include "../../include/constants/species.h"
#include "../../include/npc_trade.h"
#include "../../include/pokemon.h"
#include "../../include/save.h"
#include "../../include/types.h"

void __attribute__((section(".init"))) CreateTradeMon_Internal(struct PartyPokemon *mon, struct NPCTrade *trade_dat, u32 level, u32 tradeno, u32 mapno, u32 met_level_strat, u32 heapId)
{
    String *name;
    u8 nickname_flag;
    u32 mapsec;
    int heapId_2;

    u8 perfectIv;

    PokeParaSet(mon, trade_dat->give_species, level, 32, TRUE, trade_dat->pid, OT_ID_PRESET, trade_dat->otId);

    heapId_2 = (int)heapId;
    name = _GetNpcTradeName(heapId_2, tradeno);
    SetMonData(mon, MON_DATA_NICKNAME_3 /*MON_DATA_NICKNAME_STRING = 119*/, name);
    String_Delete(name);

    nickname_flag = TRUE;
    SetMonData(mon, MON_DATA_HAS_NICKNAME, &nickname_flag);

    // Perfect IVs on traded-in Pokemon too, regardless of what this trade's own data table says.
    perfectIv = MAX_IVS;
    SetMonData(mon, MON_DATA_HP_IV, &perfectIv);
    SetMonData(mon, MON_DATA_ATK_IV, &perfectIv);
    SetMonData(mon, MON_DATA_DEF_IV, &perfectIv);
    SetMonData(mon, MON_DATA_SPEED_IV, &perfectIv);
    SetMonData(mon, MON_DATA_SPATK_IV, &perfectIv);
    SetMonData(mon, MON_DATA_SPDEF_IV, &perfectIv);

    SetMonData(mon, MON_DATA_COOL, &trade_dat->cool);
    SetMonData(mon, MON_DATA_BEAUTY, &trade_dat->beauty);
    SetMonData(mon, MON_DATA_CUTE, &trade_dat->cute);
    SetMonData(mon, MON_DATA_SMART, &trade_dat->smart);
    SetMonData(mon, MON_DATA_TOUGH, &trade_dat->tough);

    SetMonData(mon, MON_DATA_HELD_ITEM, &trade_dat->heldItem);

    name = _GetNpcTradeName(heapId_2, NPC_TRADE_OT_NUM(tradeno));
    SetMonData(mon, MON_DATA_OT_NAME_2, name);
    String_Delete(name);

    SetMonData(mon, MON_DATA_MET_GENDER, &trade_dat->gender);
    SetMonData(mon, MON_DATA_GAME_LANGUAGE, &trade_dat->language);

    mapsec = MapHeader_GetMapSec(mapno);
    MonSetTrainerMemo(mon, NULL, met_level_strat, mapsec, heapId);

    RecalcPartyPokemonStats(mon); // CalcMonLevelAndStats(mon);
    // GF_ASSERT(!MonIsShiny(mon));
}

.nds
.thumb

.include "armips/include/scriptmacros.s"
.include "armips/include/flags.s"
.include "armips/include/soundeffects.s"
.include "armips/include/vars.s"

// need to convert this to assembly ANYWAY


// text archive to grab from: 040.txt

.create "build/a012/2_003", 0


scrdef scr_seq_0003_000
scrdef scr_seq_0003_001
scrdef scr_seq_0003_002
scrdef scr_seq_0003_003
scrdef scr_seq_0003_004
scrdef scr_seq_0003_005
scrdef scr_seq_0003_006
scrdef scr_seq_0003_007
scrdef scr_seq_0003_008
scrdef scr_seq_0003_009
scrdef scr_seq_0003_010
scrdef scr_seq_0003_011
scrdef scr_seq_0003_012
scrdef scr_seq_0003_013
scrdef scr_seq_0003_014
scrdef scr_seq_0003_015
scrdef scr_seq_0003_016
scrdef scr_seq_0003_017
scrdef scr_seq_0003_018
scrdef scr_seq_0003_019
scrdef scr_seq_0003_020
scrdef scr_seq_0003_021
scrdef scr_seq_0003_022
scrdef scr_seq_0003_023
scrdef scr_seq_0003_024
scrdef scr_seq_0003_025
scrdef scr_seq_0003_026
scrdef scr_seq_0003_027
scrdef scr_seq_0003_028
scrdef scr_seq_0003_029
scrdef scr_seq_0003_030
scrdef scr_seq_0003_031
scrdef scr_seq_0003_032
scrdef scr_seq_0003_033_give_item_verbose
scrdef scr_seq_0003_034
scrdef scr_seq_0003_035
scrdef scr_seq_0003_036
scrdef scr_seq_0003_037
scrdef scr_seq_0003_038
scrdef scr_seq_0003_039
scrdef scr_seq_0003_040
scrdef scr_seq_0003_041
scrdef scr_seq_0003_042
scrdef scr_seq_0003_043
scrdef scr_seq_0003_044
scrdef scr_seq_0003_045
scrdef scr_seq_0003_046
scrdef scr_seq_0003_047
scrdef scr_seq_0003_048
scrdef scr_seq_0003_049
scrdef scr_seq_0003_050
scrdef scr_seq_0003_051
scrdef scr_seq_0003_052
scrdef scr_seq_0003_053
scrdef scr_seq_0003_054
scrdef scr_seq_0003_055
scrdef scr_seq_0003_056
scrdef scr_seq_0003_057
scrdef scr_seq_0003_058
scrdef scr_seq_0003_059
scrdef scr_seq_0003_060
scrdef scr_seq_0003_061
scrdef scr_seq_0003_062
scrdef scr_seq_0003_063
scrdef scr_seq_0003_064
scrdef scr_seq_0003_065
scrdef scr_seq_0003_066
scrdef scr_seq_0003_067
scrdef scr_seq_0003_068
scrdef scr_seq_0003_069
scrdef scr_seq_0003_070
scrdef scr_seq_0003_071
scrdef scr_seq_0003_072_repels
scrdef scr_seq_0003_073_autobattle_testing
scrdef_end

scr_seq_0003_002:
    play_se SEQ_SE_DP_SELECT
    lockall
    faceplayer
    get_trcard_stars VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 4
    goto_if_ge _03E3
    setvar VAR_SPECIAL_x8004, 0
    scrcmd_379 VAR_SPECIAL_RESULT
    debugwatch VAR_SPECIAL_RESULT
    setvar VAR_SPECIAL_x8004, 83
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _0175
    setvar VAR_SPECIAL_x8004, 84
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _0175
    setvar VAR_SPECIAL_x8004, 0
_0175:
    non_npc_msg_var VAR_SPECIAL_x8004
    touchscreen_menu_hide
    getmenuchoice VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _01AA
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _019B
    end

_019B:
    npc_msg 3
    wait_button_or_walk_away
    touchscreen_menu_show
    closemsg
    releaseall
    endstd
    end

_01AA:
    get_player_state VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, PLAYER_STATE_ROCKET
    goto_if_ne _01C5
    set_avatar_bits PLAYER_TRANSITION_ROCKET_HEAL
    goto _01C9

_01C5:
    set_avatar_bits PLAYER_TRANSITION_HEAL
_01C9:
    update_avatar_state
    apply_movement obj_player, _0460
    wait_movement
    scrcmd_599
    get_trcard_stars VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 4
    call_if_ge _0211
    compare VAR_SPECIAL_RESULT, 4
    call_if_lt _020C
    call _0216
    goto_if_unset FLAG_UNK_065, _034D
    goto _023A

_020C:
    npc_msg 1
    return

_0211:
    npc_msg 7
    return

_0216:
    apply_movement VAR_SPECIAL_x8007, _1064
    wait_movement
    party_count_not_egg VAR_SPECIAL_x8006
    pokecen_anim VAR_SPECIAL_x8006
    apply_movement VAR_SPECIAL_x8007, _107C
    wait_movement
    get_party_lead_alive VAR_SPECIAL_x8008
    heal_party
    return

_023A:
    compare VAR_SPECIAL_x8004, 1
    goto_if_eq _02CB
    npc_msg 2
    apply_movement obj_player, _0468
    wait_movement
    get_player_state VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, PLAYER_STATE_ROCKET
    goto_if_ne _026F
    set_avatar_bits PLAYER_TRANSITION_ROCKET
    goto _0273

_026F:
    set_avatar_bits PLAYER_TRANSITION_WALKING
_0273:
    update_avatar_state
    get_party_lead_alive VAR_SPECIAL_x8009
    compare VAR_SPECIAL_x8008, VAR_SPECIAL_x8009
    goto_if_eq _02B2
    wait 15, VAR_SPECIAL_x800A
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    closemsg
    scrcmd_436
    scrcmd_150
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    bufferpartymonnick 0, VAR_SPECIAL_x8009
    npc_msg 102
_02B2:
    apply_movement VAR_SPECIAL_x8007, _0454
    wait_movement
    npc_msg 3
    wait_button_or_walk_away
    closemsg
    touchscreen_menu_show
    releaseall
    endstd
    end

_02CB:
    npc_msg 8
    apply_movement obj_player, _0468
    wait_movement
    get_player_state VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, PLAYER_STATE_ROCKET
    goto_if_ne _02F3
    set_avatar_bits PLAYER_TRANSITION_ROCKET
    goto _02F7

_02F3:
    set_avatar_bits PLAYER_TRANSITION_WALKING
_02F7:
    update_avatar_state
    get_party_lead_alive VAR_SPECIAL_x8009
    compare VAR_SPECIAL_x8008, VAR_SPECIAL_x8009
    goto_if_eq _0336
    wait 15, VAR_SPECIAL_x800A
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    closemsg
    scrcmd_436
    scrcmd_150
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    bufferpartymonnick 0, VAR_SPECIAL_x8009
    npc_msg 102
_0336:
    apply_movement VAR_SPECIAL_x8007, _0454
    wait_movement
    npc_msg 9
    wait_button_or_walk_away
    closemsg
    releaseall
    endstd
    end

_034D:
    party_has_pokerus VAR_SPECIAL_x8006
    compare VAR_SPECIAL_x8006, 1
    goto_if_eq _0364
    goto _023A

_0364:
    setflag FLAG_UNK_065
    scrcmd_148 1, 0
    apply_movement obj_player, _0468
    wait_movement
    get_player_state VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, PLAYER_STATE_ROCKET
    goto_if_ne _0391
    set_avatar_bits PLAYER_TRANSITION_ROCKET
    goto _0395

_0391:
    set_avatar_bits PLAYER_TRANSITION_WALKING
_0395:
    get_party_lead_alive VAR_SPECIAL_x8009
    compare VAR_SPECIAL_x8008, VAR_SPECIAL_x8009
    goto_if_eq _03D4
    update_avatar_state
    wait 15, VAR_SPECIAL_x800A
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    closemsg
    scrcmd_436
    scrcmd_150
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    bufferpartymonnick 0, VAR_SPECIAL_x8009
    npc_msg 102
_03D4:
    npc_msg 10
    wait_button_or_walk_away
    closemsg
    touchscreen_menu_show
    releaseall
    endstd
    end

_03E3:
    goto_if_set FLAG_NURSE_NOTICED_TRAINER_CARD, _041D
    setflag FLAG_NURSE_NOTICED_TRAINER_CARD
    npc_msg 4
    buffer_players_name 0
    npc_msg 5
    touchscreen_menu_hide
    getmenuchoice VAR_SPECIAL_RESULT
    touchscreen_menu_show
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _0445
    npc_msg 9
    wait_button_or_walk_away
    closemsg
    releaseall
    endstd
    end

_041D:
    buffer_players_name 0
    npc_msg 6
    touchscreen_menu_hide
    getmenuchoice VAR_SPECIAL_RESULT
    touchscreen_menu_show
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _0445
    npc_msg 9
    wait_button_or_walk_away
    closemsg
    releaseall
    endstd
    end

_0445:
    setvar VAR_SPECIAL_x8004, 1
    goto _01AA

.align 4

_0454:
    step 100, 1
    step 62, 1
    step_end

_0460:
    step 102, 1
    step_end

_0468:
    step 104, 1
    step_end


scr_seq_0003_069:
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    scrcmd_436
    play_fanfare SEQ_ME_ASA
    wait_fanfare
    heal_party
    scrcmd_150
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    endstd
    end

scr_seq_0003_000:
    switch VAR_SPECIAL_RESULT
    case 0, _04D6
    case 1, _04DD
    scrcmd_060 VAR_SPECIAL_RESULT
    switch VAR_SPECIAL_RESULT
    case 1, _04DD
    scrcmd_057 2
    endstd
    end

_04D6:
    scrcmd_057 2
    endstd
    end

_04DD:
    scrcmd_057 4
    scrcmd_058
    scrcmd_061
    endstd
    end

scr_seq_0003_001:
    call _04F2
    endstd
    end

_04F2:
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    switch VAR_SPECIAL_RESULT
    case 7, _0574
    case 0, _0568
    case 4, _0568
    case 1, _0568
    case 2, _0568
    case 6, _0568
    case 5, _057A
    case 3, _056E
    end

_0568:
    play_fanfare SEQ_ME_ITEM
    return

_056E:
    play_fanfare SEQ_ME_WAZA
    return

_0574:
    play_fanfare SEQ_ME_KEYITEM
    return

_057A:
    play_fanfare SEQ_ME_HYOUKA2
    return
    .byte 0x15, 0x00, 0x02, 0x00
scr_seq_0003_003:
    scrcmd_609
    lockall
    get_party_count VAR_SPECIAL_x8004
    setvar VAR_SPECIAL_x8005, 0
_0592:
    survive_poisoning VAR_SPECIAL_RESULT, VAR_SPECIAL_x8005
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _05AD
    bufferpartymonnick 0, VAR_SPECIAL_x8005
    npc_msg 53
_05AD:
    addvar VAR_SPECIAL_x8005, 1
    compare VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
    goto_if_ne _0592
    count_alive_mons VAR_SPECIAL_RESULT, 6
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _05F5
    closemsg
    releaseall
    end

scr_seq_0003_004:
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    wait_button
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    end

_05F5:
    buffer_players_name 0
    npc_msg 11
    wait_button
    closemsg
    fade_out_bgm 0, 10
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    scrcmd_436
    overworld_white_out
    end

scr_seq_0003_005:
    clearflag FLAG_MAPTEMP_020
    call _0646
    scrcmd_347 VAR_SPECIAL_RESULT
    closemsg
    end

scr_seq_0003_024:
    npc_msg 20
    wait_button
    closemsg
    end

scr_seq_0003_006:
    setflag FLAG_MAPTEMP_020
    call _0646
    copyvar VAR_TEMP_x4000, VAR_SPECIAL_RESULT
    endstd
    end

_0646:
    show_save_stats
    npc_msg 13
    touchscreen_menu_hide
    getmenuchoice VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _0740
    get_save_file_state VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _0698
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _06BD
    compare VAR_SPECIAL_RESULT, 2
    goto_if_eq _06A9
    compare VAR_SPECIAL_RESULT, 3
    goto_if_eq _06C6
    end

_0698:
    hide_save_stats
    touchscreen_menu_show
    npc_msg 20
    wait_button
    setvar VAR_SPECIAL_RESULT, 0
    return

_06A9:
    npc_msg 14
    getmenuchoice VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _0740
_06BD:
    npc_msg 21
    goto _06F2

_06C6:
    npc_msg 14
    getmenuchoice VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _0740
    goto_if_unset FLAG_MAPTEMP_020, _076A
    goto_if_set FLAG_MAPTEMP_020, _0775
    end

_06F2:
    player_movement_saving_set
    wait 2, VAR_SPECIAL_RESULT
    call _0708
    player_movement_saving_clear
    goto _071D

_0708:
    add_waiting_icon
    call_if_set FLAG_MAPTEMP_020, _0762
    save_game_normal VAR_SPECIAL_RESULT
    remove_waiting_icon
    return

_071D:
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _074C
    buffer_players_name 0
    npc_msg 16
    play_se SEQ_SE_DP_SAVE
    wait_se SEQ_SE_DP_SAVE
    wait_button_or_delay 30
    hide_save_stats
    return

_0740:
    hide_save_stats
    touchscreen_menu_show
    setvar VAR_SPECIAL_RESULT, 0
    return

_074C:
    npc_msg 18
    wait_button
    hide_save_stats
    touchscreen_menu_show
    return

_0757:
    npc_msg 21
    goto _06F2
    .byte 0x02, 0x00
_0762:
    save_wipe_extra_chunks
    clearflag FLAG_MAPTEMP_020
    return

_076A:
    npc_msg 15
    goto _06F2
    .byte 0x02, 0x00
_0775:
    scrcmd_642 VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _0757
    goto _076A
    .byte 0x02, 0x00
scr_seq_0003_007:
    call _07AA
    npc_msg 32
    wait_button
    endstd
    end

scr_seq_0003_035:
    call _07AA
    npc_msg 90
    endstd
    end

_07AA:
    play_fanfare SEQ_ME_ACCE
    scrcmd_403 VAR_SPECIAL_x8004, VAR_SPECIAL_x8005
    buffer_fashion_name 0, VAR_SPECIAL_x8004
    npc_msg 25
    wait_fanfare
    buffer_players_name 0
    buffer_fashion_name 1, VAR_SPECIAL_x8004
    return

scr_seq_0003_026:
    call _07E4
    npc_msg 32
    wait_button
    endstd
    end

scr_seq_0003_034:
    call _07E4
    npc_msg 90
    endstd
    end

_07E4:
    play_fanfare SEQ_ME_ACCE
    scrcmd_406 VAR_SPECIAL_x8004
    buffer_background_name 0, VAR_SPECIAL_x8004
    npc_msg 25
    wait_fanfare
    buffer_players_name 0
    buffer_background_name 1, VAR_SPECIAL_x8004
    return

scr_seq_0003_008:
    call _080A
    endstd
    end

_080A:
    // --- ground item randomizer -------------------------------------------------------
    // Fixed swap table for every visible (Poke Ball sprite) field item currently placed on
    // a map, built from what's actually in the compiled ROM at the time this was written.
    // Each original item is swapped for a replacement drawn from every item ID 1-1000 that
    // isn't a key item, a TM/HM, an unnamed/unused "ITEM_UNKNOWN_*" slot, or a Z-Crystal
    // (Z-moves are disabled in this hack, see config.h) - so Mega Stones and the curated
    // competitive-item set (Leftovers, Choice items, Eviolite, ...) can turn up here too,
    // same pool the Mega Stone/competitive item shops draw from (see MegaStoneShop_GetItems /
    // CompetitiveItemShop_GetItems in src/wild_encounter_randomizer.c). One Mega Stone and one
    // competitive item are guaranteed among the picks below so the feature is actually visible
    // in-game; the rest are a straight random draw from that ~770-item pool (seed 20260910).
    // Same for every save file/every player (this build has no way to seed this per-save -
    // unlike wild encounters/trainers, individual map scripts aren't rebuilt from source).
    // Key items and TMs/HMs are deliberately left out of the table below - they still give
    // the vanilla item unchanged, same as this repo's other item randomizers never touch
    // anything that could block progression.
    //
    // IMPORTANT: this table can only cover an item ball if the scan tool actually found it -
    // it only sees an original item value when the per-map script sets VAR_SPECIAL_x8004 to a
    // plain literal right before calling into this std; an item ball whose script sets that
    // variable some other way (copied from another variable, computed, etc.) is invisible to
    // the scan and silently falls through unchanged below, which is exactly what was happening
    // to the Antidote on Route 29 - it isn't compared against at all further down, so it always
    // reached giveitem completely untouched. Added by hand once reported; if any other ground
    // item is found still giving its original vanilla item, it's almost certainly the same gap -
    // just add another compare/goto_if_eq + _GISwap_fromXXX pair below for it the same way.
    // Regenerate/extend this list (see the item-ball scan script the project keeps around) if
    // more maps/item balls get added or found later - just pick a fresh (still non-key-item,
    // non-TM/HM, non-Z-Crystal) replacement for whatever new items turn up.
    compare VAR_SPECIAL_x8004, 10
    goto_if_eq _GISwap_from10 // ITEM_TIMER_BALL -> ITEM_MEWTWONITE_Y
    compare VAR_SPECIAL_x8004, 17
    goto_if_eq _GISwap_from17 // ITEM_POTION -> ITEM_EVIOLITE
    compare VAR_SPECIAL_x8004, 18
    goto_if_eq _GISwap_from18 // ITEM_ANTIDOTE -> ITEM_ICE_GEM (Route 29 - reported missing, added by hand)
    compare VAR_SPECIAL_x8004, 92
    goto_if_eq _GISwap_from92 // ITEM_NUGGET -> ITEM_SUN_STONE
    compare VAR_SPECIAL_x8004, 149
    goto_if_eq _GISwap_from149 // ITEM_CHERI_BERRY -> ITEM_OCCA_BERRY
    compare VAR_SPECIAL_x8004, 225
    goto_if_eq _GISwap_from225 // ITEM_SOUL_DEW -> ITEM_ELECTRIC_MEMORY
    compare VAR_SPECIAL_x8004, 249
    goto_if_eq _GISwap_from249 // ITEM_CHARCOAL -> ITEM_FLYING_GEM
    compare VAR_SPECIAL_x8004, 492
    goto_if_eq _GISwap_from492 // ITEM_FAST_BALL -> ITEM_TOUGH_CANDY
    goto _GISwap_continue

_GISwap_from10:
    setvar VAR_SPECIAL_x8004, 663 // ITEM_MEWTWONITE_Y
    goto _GISwap_continue
_GISwap_from17:
    setvar VAR_SPECIAL_x8004, 538 // ITEM_EVIOLITE
    goto _GISwap_continue
_GISwap_from18:
    setvar VAR_SPECIAL_x8004, 552 // ITEM_ICE_GEM
    goto _GISwap_continue
_GISwap_from92:
    setvar VAR_SPECIAL_x8004, 80 // ITEM_SUN_STONE
    goto _GISwap_continue
_GISwap_from149:
    setvar VAR_SPECIAL_x8004, 184 // ITEM_OCCA_BERRY
    goto _GISwap_continue
_GISwap_from225:
    setvar VAR_SPECIAL_x8004, 915 // ITEM_ELECTRIC_MEMORY
    goto _GISwap_continue
_GISwap_from249:
    setvar VAR_SPECIAL_x8004, 556 // ITEM_FLYING_GEM
    goto _GISwap_continue
_GISwap_from492:
    setvar VAR_SPECIAL_x8004, 962 // ITEM_TOUGH_CANDY
    goto _GISwap_continue

_GISwap_continue:
    // --- end ground item randomizer ---------------------------------------------------
    call _04F2
    giveitem VAR_SPECIAL_x8004, VAR_SPECIAL_x8005, VAR_SPECIAL_RESULT
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 7
    call_if_eq _0892
    compare VAR_SPECIAL_RESULT, 7
    call_if_ne _08A3
    compare VAR_SPECIAL_x8005, 1
    goto_if_gt _084E
    npc_msg 30
    goto _0851

_084E:
    npc_msg 31
_0851:
    wait_button_or_walk_away
    return

scr_seq_0003_033_give_item_verbose:
    call _085F
    endstd
    end

_085F:
    // --- NPC gift item randomizer -----------------------------------------------------
    // Fixed swap table for every regular (non key-item, non-TM/HM) item an NPC hands you
    // directly through this shared "give item" routine - found by scanning the compiled ROM
    // for every call into this exact std (2033) with a literal item value, the same technique
    // used for the ground-item-ball table in _080A above. 54 distinct items covered; pool and
    // exclusions are identical to _080A (item ID 1-1000, no key items/TM-HM/unnamed "ITEM_
    // UNKNOWN_*" slots/Z-Crystals - Mega Stones and the curated competitive-item set can turn
    // up here too, one of each guaranteed among the picks below), seed 20260912.
    // ITEM_MASTER_BALL is deliberately left OUT of this table on purpose even though the scan
    // found it here (it's the one-time Radio Tower gift) - it always still gives a real Master
    // Ball, same as every key item/TM/HM already does. Same caveat as _080A: this can only catch
    // an instance whose item value is a literal set right before the call - an item set
    // dynamically (e.g. the Route 29 Antidote) is invisible to this and passes through
    // unchanged; report it and it can be added by hand the same way.
    compare VAR_SPECIAL_x8004, 4
    goto_if_eq _NPCGiftSwap_from4 // ITEM_POKE_BALL -> ITEM_VENUSAURITE
    compare VAR_SPECIAL_x8004, 37
    goto_if_eq _NPCGiftSwap_from37 // ITEM_REVIVAL_HERB -> ITEM_MENTAL_HERB
    compare VAR_SPECIAL_x8004, 38
    goto_if_eq _NPCGiftSwap_from38 // ITEM_ETHER -> ITEM_PERMIT
    compare VAR_SPECIAL_x8004, 44
    goto_if_eq _NPCGiftSwap_from44 // ITEM_SACRED_ASH -> ITEM_LIGHT_BALL
    compare VAR_SPECIAL_x8004, 45
    goto_if_eq _NPCGiftSwap_from45 // ITEM_HP_UP -> ITEM_BUBBLE_MAIL
    compare VAR_SPECIAL_x8004, 50
    goto_if_eq _NPCGiftSwap_from50 // ITEM_RARE_CANDY -> ITEM_SODA_POP
    compare VAR_SPECIAL_x8004, 53
    goto_if_eq _NPCGiftSwap_from53 // ITEM_PP_MAX -> ITEM_PSYCHIC_MEMORY
    compare VAR_SPECIAL_x8004, 83
    goto_if_eq _NPCGiftSwap_from83 // ITEM_THUNDER_STONE -> ITEM_RED_NECTAR
    compare VAR_SPECIAL_x8004, 92
    goto_if_eq _NPCGiftSwap_from92 // ITEM_NUGGET -> ITEM_NIDORAN_MALE_CANDY
    compare VAR_SPECIAL_x8004, 149
    goto_if_eq _NPCGiftSwap_from149 // ITEM_CHERI_BERRY -> ITEM_GOLD_LEAF
    compare VAR_SPECIAL_x8004, 150
    goto_if_eq _NPCGiftSwap_from150 // ITEM_CHESTO_BERRY -> ITEM_CHARIZARDITE_Y
    compare VAR_SPECIAL_x8004, 151
    goto_if_eq _NPCGiftSwap_from151 // ITEM_PECHA_BERRY -> ITEM_WATER_STONE
    compare VAR_SPECIAL_x8004, 152
    goto_if_eq _NPCGiftSwap_from152 // ITEM_RAWST_BERRY -> ITEM_KINGS_ROCK
    compare VAR_SPECIAL_x8004, 153
    goto_if_eq _NPCGiftSwap_from153 // ITEM_ASPEAR_BERRY -> ITEM_MOON_STONE
    compare VAR_SPECIAL_x8004, 154
    goto_if_eq _NPCGiftSwap_from154 // ITEM_LEPPA_BERRY -> ITEM_POWER_PLANT_PASS
    compare VAR_SPECIAL_x8004, 155
    goto_if_eq _NPCGiftSwap_from155 // ITEM_ORAN_BERRY -> ITEM_SAFETY_GOGGLES
    compare VAR_SPECIAL_x8004, 156
    goto_if_eq _NPCGiftSwap_from156 // ITEM_PERSIM_BERRY -> ITEM_METEORITE_SHARD
    compare VAR_SPECIAL_x8004, 157
    goto_if_eq _NPCGiftSwap_from157 // ITEM_LUM_BERRY -> ITEM_FORAGE_BAG
    compare VAR_SPECIAL_x8004, 158
    goto_if_eq _NPCGiftSwap_from158 // ITEM_SITRUS_BERRY -> ITEM_X_ATTACK
    compare VAR_SPECIAL_x8004, 160
    goto_if_eq _NPCGiftSwap_from160 // ITEM_WIKI_BERRY -> ITEM_SMART_CANDY_L
    compare VAR_SPECIAL_x8004, 162
    goto_if_eq _NPCGiftSwap_from162 // ITEM_AGUAV_BERRY -> ITEM_MISTY_SEED
    compare VAR_SPECIAL_x8004, 163
    goto_if_eq _NPCGiftSwap_from163 // ITEM_IAPAPA_BERRY -> ITEM_YELLOW_FLUTE
    compare VAR_SPECIAL_x8004, 164
    goto_if_eq _NPCGiftSwap_from164 // ITEM_RAZZ_BERRY -> ITEM_DATA_CARD_14
    compare VAR_SPECIAL_x8004, 165
    goto_if_eq _NPCGiftSwap_from165 // ITEM_BLUK_BERRY -> ITEM_MEGA_STICKPIN
    compare VAR_SPECIAL_x8004, 167
    goto_if_eq _NPCGiftSwap_from167 // ITEM_WEPEAR_BERRY -> ITEM_TRAVEL_TRUNK
    compare VAR_SPECIAL_x8004, 168
    goto_if_eq _NPCGiftSwap_from168 // ITEM_PINAP_BERRY -> ITEM_PROTEIN
    compare VAR_SPECIAL_x8004, 169
    goto_if_eq _NPCGiftSwap_from169 // ITEM_POMEG_BERRY -> ITEM_AMAZE_MULCH
    compare VAR_SPECIAL_x8004, 170
    goto_if_eq _NPCGiftSwap_from170 // ITEM_KELPSY_BERRY -> ITEM_ACRO_BIKE
    compare VAR_SPECIAL_x8004, 172
    goto_if_eq _NPCGiftSwap_from172 // ITEM_HONDEW_BERRY -> ITEM_DAWN_STONE
    compare VAR_SPECIAL_x8004, 173
    goto_if_eq _NPCGiftSwap_from173 // ITEM_GREPA_BERRY -> ITEM_ABSOLITE
    compare VAR_SPECIAL_x8004, 175
    goto_if_eq _NPCGiftSwap_from175 // ITEM_CORNN_BERRY -> ITEM_ROLLER_SKATES
    compare VAR_SPECIAL_x8004, 178
    goto_if_eq _NPCGiftSwap_from178 // ITEM_NOMEL_BERRY -> ITEM_SHOAL_SALT
    compare VAR_SPECIAL_x8004, 182
    goto_if_eq _NPCGiftSwap_from182 // ITEM_DURIN_BERRY -> ITEM_KELPSY_BERRY
    compare VAR_SPECIAL_x8004, 213
    goto_if_eq _NPCGiftSwap_from213 // ITEM_BRIGHT_POWDER -> ITEM_UP_GRADE
    compare VAR_SPECIAL_x8004, 216
    goto_if_eq _NPCGiftSwap_from216 // ITEM_EXP_SHARE -> ITEM_MOSAIC_MAIL
    compare VAR_SPECIAL_x8004, 217
    goto_if_eq _NPCGiftSwap_from217 // ITEM_QUICK_CLAW -> ITEM_SHELL_BELL
    compare VAR_SPECIAL_x8004, 221
    goto_if_eq _NPCGiftSwap_from221 // ITEM_KINGS_ROCK -> ITEM_LIFE_ORB
    compare VAR_SPECIAL_x8004, 224
    goto_if_eq _NPCGiftSwap_from224 // ITEM_CLEANSE_TAG -> ITEM_DATA_CARD_10
    compare VAR_SPECIAL_x8004, 229
    goto_if_eq _NPCGiftSwap_from229 // ITEM_EVERSTONE -> ITEM_DURIN_BERRY
    compare VAR_SPECIAL_x8004, 233
    goto_if_eq _NPCGiftSwap_from233 // ITEM_METAL_COAT -> ITEM_SPORT_BALL
    compare VAR_SPECIAL_x8004, 237
    goto_if_eq _NPCGiftSwap_from237 // ITEM_SOFT_SAND -> ITEM_LEPPA_BERRY
    compare VAR_SPECIAL_x8004, 238
    goto_if_eq _NPCGiftSwap_from238 // ITEM_HARD_STONE -> ITEM_WACAN_BERRY
    compare VAR_SPECIAL_x8004, 240
    goto_if_eq _NPCGiftSwap_from240 // ITEM_BLACK_GLASSES -> ITEM_NEVER_MELT_ICE
    compare VAR_SPECIAL_x8004, 241
    goto_if_eq _NPCGiftSwap_from241 // ITEM_BLACK_BELT -> ITEM_DEVON_SCUBA_GEAR
    compare VAR_SPECIAL_x8004, 242
    goto_if_eq _NPCGiftSwap_from242 // ITEM_MAGNET -> ITEM_BOOST_MULCH
    compare VAR_SPECIAL_x8004, 243
    goto_if_eq _NPCGiftSwap_from243 // ITEM_MYSTIC_WATER -> ITEM_GRISEOUS_ORB
    compare VAR_SPECIAL_x8004, 244
    goto_if_eq _NPCGiftSwap_from244 // ITEM_SHARP_BEAK -> ITEM_CHOICE_SPECS
    compare VAR_SPECIAL_x8004, 245
    goto_if_eq _NPCGiftSwap_from245 // ITEM_POISON_BARB -> ITEM_LOVE_BALL
    compare VAR_SPECIAL_x8004, 247
    goto_if_eq _NPCGiftSwap_from247 // ITEM_SPELL_TAG -> ITEM_GUARD_SPEC
    compare VAR_SPECIAL_x8004, 248
    goto_if_eq _NPCGiftSwap_from248 // ITEM_TWISTED_SPOON -> ITEM_ELIXIR
    compare VAR_SPECIAL_x8004, 252
    goto_if_eq _NPCGiftSwap_from252 // ITEM_UP_GRADE -> ITEM_DATA_CARD_07
    compare VAR_SPECIAL_x8004, 256
    goto_if_eq _NPCGiftSwap_from256 // ITEM_LUCKY_PUNCH -> ITEM_LAX_INCENSE
    compare VAR_SPECIAL_x8004, 271
    goto_if_eq _NPCGiftSwap_from271 // ITEM_POWER_HERB -> ITEM_GRAM_1
    compare VAR_SPECIAL_x8004, 494
    goto_if_eq _NPCGiftSwap_from494 // ITEM_LURE_BALL -> ITEM_MEDICHAMITE
    goto _NPCGiftSwap_continue

_NPCGiftSwap_from4:
    setvar VAR_SPECIAL_x8004, 659 // ITEM_VENUSAURITE
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from37:
    setvar VAR_SPECIAL_x8004, 219 // ITEM_MENTAL_HERB
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from38:
    setvar VAR_SPECIAL_x8004, 630 // ITEM_PERMIT
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from44:
    setvar VAR_SPECIAL_x8004, 236 // ITEM_LIGHT_BALL
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from45:
    setvar VAR_SPECIAL_x8004, 139 // ITEM_BUBBLE_MAIL
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from50:
    setvar VAR_SPECIAL_x8004, 31 // ITEM_SODA_POP
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from53:
    setvar VAR_SPECIAL_x8004, 916 // ITEM_PSYCHIC_MEMORY
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from83:
    setvar VAR_SPECIAL_x8004, 853 // ITEM_RED_NECTAR
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from92:
    setvar VAR_SPECIAL_x8004, 990 // ITEM_NIDORAN_MALE_CANDY
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from149:
    setvar VAR_SPECIAL_x8004, 890 // ITEM_GOLD_LEAF
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from150:
    setvar VAR_SPECIAL_x8004, 678 // ITEM_CHARIZARDITE_Y
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from151:
    setvar VAR_SPECIAL_x8004, 84 // ITEM_WATER_STONE
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from152:
    setvar VAR_SPECIAL_x8004, 221 // ITEM_KINGS_ROCK
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from153:
    setvar VAR_SPECIAL_x8004, 81 // ITEM_MOON_STONE
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from154:
    setvar VAR_SPECIAL_x8004, 695 // ITEM_POWER_PLANT_PASS
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from155:
    setvar VAR_SPECIAL_x8004, 650 // ITEM_SAFETY_GOGGLES
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from156:
    setvar VAR_SPECIAL_x8004, 774 // ITEM_METEORITE_SHARD
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from157:
    setvar VAR_SPECIAL_x8004, 841 // ITEM_FORAGE_BAG
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from158:
    setvar VAR_SPECIAL_x8004, 57 // ITEM_X_ATTACK
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from160:
    setvar VAR_SPECIAL_x8004, 969 // ITEM_SMART_CANDY_L
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from162:
    setvar VAR_SPECIAL_x8004, 883 // ITEM_MISTY_SEED
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from163:
    setvar VAR_SPECIAL_x8004, 66 // ITEM_YELLOW_FLUTE
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from164:
    setvar VAR_SPECIAL_x8004, 518 // ITEM_DATA_CARD_14
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from165:
    setvar VAR_SPECIAL_x8004, 748 // ITEM_MEGA_STICKPIN
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from167:
    setvar VAR_SPECIAL_x8004, 707 // ITEM_TRAVEL_TRUNK
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from168:
    setvar VAR_SPECIAL_x8004, 46 // ITEM_PROTEIN
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from169:
    setvar VAR_SPECIAL_x8004, 655 // ITEM_AMAZE_MULCH
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from170:
    setvar VAR_SPECIAL_x8004, 719 // ITEM_ACRO_BIKE
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from172:
    setvar VAR_SPECIAL_x8004, 109 // ITEM_DAWN_STONE
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from173:
    setvar VAR_SPECIAL_x8004, 677 // ITEM_ABSOLITE
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from175:
    setvar VAR_SPECIAL_x8004, 643 // ITEM_ROLLER_SKATES
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from178:
    setvar VAR_SPECIAL_x8004, 70 // ITEM_SHOAL_SALT
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from182:
    setvar VAR_SPECIAL_x8004, 170 // ITEM_KELPSY_BERRY
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from213:
    setvar VAR_SPECIAL_x8004, 252 // ITEM_UP_GRADE
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from216:
    setvar VAR_SPECIAL_x8004, 147 // ITEM_MOSAIC_MAIL
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from217:
    setvar VAR_SPECIAL_x8004, 253 // ITEM_SHELL_BELL
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from221:
    setvar VAR_SPECIAL_x8004, 270 // ITEM_LIFE_ORB
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from224:
    setvar VAR_SPECIAL_x8004, 514 // ITEM_DATA_CARD_10
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from229:
    setvar VAR_SPECIAL_x8004, 182 // ITEM_DURIN_BERRY
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from233:
    setvar VAR_SPECIAL_x8004, 499 // ITEM_SPORT_BALL
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from237:
    setvar VAR_SPECIAL_x8004, 154 // ITEM_LEPPA_BERRY
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from238:
    setvar VAR_SPECIAL_x8004, 186 // ITEM_WACAN_BERRY
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from240:
    setvar VAR_SPECIAL_x8004, 246 // ITEM_NEVER_MELT_ICE
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from241:
    setvar VAR_SPECIAL_x8004, 738 // ITEM_DEVON_SCUBA_GEAR
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from242:
    setvar VAR_SPECIAL_x8004, 654 // ITEM_BOOST_MULCH
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from243:
    setvar VAR_SPECIAL_x8004, 112 // ITEM_GRISEOUS_ORB
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from244:
    setvar VAR_SPECIAL_x8004, 297 // ITEM_CHOICE_SPECS
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from245:
    setvar VAR_SPECIAL_x8004, 496 // ITEM_LOVE_BALL
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from247:
    setvar VAR_SPECIAL_x8004, 55 // ITEM_GUARD_SPEC
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from248:
    setvar VAR_SPECIAL_x8004, 40 // ITEM_ELIXIR
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from252:
    setvar VAR_SPECIAL_x8004, 511 // ITEM_DATA_CARD_07
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from256:
    setvar VAR_SPECIAL_x8004, 255 // ITEM_LAX_INCENSE
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from271:
    setvar VAR_SPECIAL_x8004, 623 // ITEM_GRAM_1
    goto _NPCGiftSwap_continue
_NPCGiftSwap_from494:
    setvar VAR_SPECIAL_x8004, 665 // ITEM_MEDICHAMITE
    goto _NPCGiftSwap_continue

_NPCGiftSwap_continue:

    call _04F2
    giveitem VAR_SPECIAL_x8004, VAR_SPECIAL_x8005, VAR_SPECIAL_RESULT
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 7
    call_if_eq _0892
    compare VAR_SPECIAL_RESULT, 7
    call_if_ne _08A3
    npc_msg 89
    return

_0892:
    buffer_players_name 0
    buffer_item_name_indef 1, VAR_SPECIAL_x8004
    npc_msg 28
    goto _08C9

_08A3:
    compare VAR_SPECIAL_x8005, 1
    goto_if_gt _08BB
    buffer_item_name_indef 0, VAR_SPECIAL_x8004
    goto _08C0

_08BB:
    buffer_item_name_plural 0, VAR_SPECIAL_x8004
_08C0:
    npc_msg 25
    goto _08C9

_08C9:
    wait_fanfare
    buffer_players_name 0
    compare VAR_SPECIAL_x8005, 1
    goto_if_gt _08E6
    buffer_item_name 1, VAR_SPECIAL_x8004
    goto _08EB

_08E6:
    buffer_item_name_plural 1, VAR_SPECIAL_x8004
_08EB:
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    switch VAR_SPECIAL_RESULT
    case 7, _0972
    case 0, _0961
    case 4, _09B6
    case 1, _09A5
    case 2, _09C7
    case 6, _0983
    case 5, _0994
    case 3, _09D8
    end

_0961:
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    buffer_pocket_name 2, VAR_SPECIAL_RESULT
    goto _09E9

_0972:
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    buffer_pocket_name 2, VAR_SPECIAL_RESULT
    goto _09E9

_0983:
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    buffer_pocket_name 2, VAR_SPECIAL_RESULT
    goto _09E9

_0994:
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    buffer_pocket_name 2, VAR_SPECIAL_RESULT
    goto _09E9

_09A5:
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    buffer_pocket_name 2, VAR_SPECIAL_RESULT
    goto _09E9

_09B6:
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    buffer_pocket_name 2, VAR_SPECIAL_RESULT
    goto _09E9

_09C7:
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    buffer_pocket_name 2, VAR_SPECIAL_RESULT
    goto _09E9

_09D8:
    getitempocket VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    buffer_pocket_name 2, VAR_SPECIAL_RESULT
    goto _09E9

_09E9:
    return

scr_seq_0003_009:
    call _09F5
    endstd
    end

_09F5:
    npc_msg 27
    wait_button_or_walk_away
    return

scr_seq_0003_010:
    scrcmd_609
    lockall
    play_se SEQ_SE_DP_PC_ON
    call _0A18
    buffer_players_name 0
    npc_msg 33
    touchscreen_menu_hide
    goto _0A2E

_0A18:
    scrcmd_500 90
    scrcmd_501 90
    scrcmd_308 90
    return

_0A23:
    scrcmd_502 90
    scrcmd_308 90
    scrcmd_309 90
    return

_0A2E:
    buffer_players_name 0
    npc_msg 34
    menu_init_std_gmm 1, 1, 0, 1, VAR_SPECIAL_x8006
    call_if_unset FLAG_SYS_MET_BILL, _0A78
    call_if_set FLAG_SYS_MET_BILL, _0A82
    menu_item_add 63, 255, 1
    goto_if_set FLAG_GAME_CLEAR, _0A8C
    goto_if_unset FLAG_GAME_CLEAR, _0AD1
    goto _0AD1
    .byte 0x02, 0x00
_0A78:
    menu_item_add 61, 255, 0
    return

_0A82:
    menu_item_add 62, 255, 0
    return

_0A8C:
    menu_item_add 64, 255, 2
    menu_item_add 66, 255, 3
    menu_exec
    switch VAR_SPECIAL_x8006
    case 0, _0B01
    case 1, _0C23
    case 2, _0DBA
    goto _0DF0

_0AD1:
    menu_item_add 66, 255, 2
    menu_exec
    switch VAR_SPECIAL_x8006
    case 0, _0B01
    case 1, _0C23
    goto _0DF0

_0B01:
    play_se SEQ_SE_DP_PC_LOGIN
    buffer_players_name 0
    npc_msg 35
    call _0B17
    goto _0B53

_0B17:
    menu_init_std_gmm 1, 1, 0, 1, VAR_SPECIAL_RESULT
    menu_item_add 67, 76, 0
    menu_item_add 68, 77, 1
    menu_item_add 69, 78, 2
    menu_item_add 70, 79, 3
    menu_item_add 72, 81, 5
    return
    .byte 0x46, 0x00, 0x47, 0x00, 0x50, 0x00, 0x04
    .byte 0x00, 0x1b, 0x00
_0B53:
    menu_exec
    switch VAR_SPECIAL_RESULT
    case 0, _0BA2
    case 1, _0BB5
    case 2, _0BC8
    case 3, _0BDB
    case 4, _0BEE
    goto _0A2E

_0BA2:
    closemsg
    call _0E16
    scrcmd_158 0
    scrcmd_150
    goto _0C01

_0BB5:
    closemsg
    call _0E16
    scrcmd_158 1
    scrcmd_150
    goto _0C01

_0BC8:
    closemsg
    call _0E16
    scrcmd_158 2
    scrcmd_150
    goto _0C01

_0BDB:
    closemsg
    call _0E16
    scrcmd_158 3
    scrcmd_150
    goto _0C01

_0BEE:
    closemsg
    call _0E16
    scrcmd_158 4
    scrcmd_150
    goto _0C01

_0C01:
    buffer_players_name 0
    non_npc_msg 34
    call _0B17
    call _0A18
    fade_screen 6, 1, 1, RGB_BLACK
    goto _0B53

_0C23:
    play_se SEQ_SE_DP_PC_LOGIN
    buffer_players_name 0
    npc_msg 36
    goto _0C33

_0C33:
    call _0CA7
_0C39:
    scrcmd_616 VAR_TEMP_x4000
    compare VAR_TEMP_x4000, 0
    goto_if_ne _0C72
    menu_exec
    switch VAR_SPECIAL_RESULT
    case 0, _0CEC
    case 1, _0D3A
    goto _0A2E

_0C72:
    menu_exec
    switch VAR_SPECIAL_RESULT
    case 0, _0CEC
    case 1, _0D3A
    case 2, _0D86
    goto _0A2E

_0CA7:
    menu_init_std_gmm 1, 1, 0, 1, VAR_SPECIAL_RESULT
    menu_item_add 73, 82, 0
    menu_item_add 74, 83, 1
    scrcmd_616 VAR_TEMP_x4000
    compare VAR_TEMP_x4000, 0
    goto_if_ne _0CDA
    menu_item_add 75, 84, 2
    return

_0CDA:
    menu_item_add 65, 85, 2
    menu_item_add 75, 84, 3
    return

_0CEC:
    closemsg
    scrcmd_377 VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _0D0F
    call _0E16
    scrcmd_376
    scrcmd_150
    goto _0D18

_0D0F:
    npc_msg 47
    goto _0C33

_0D18:
    buffer_players_name 0
    non_npc_msg 34
    call _0CA7
    call _0A18
    fade_screen 6, 1, 1, RGB_BLACK
    goto _0C39

_0D3A:
    scrcmd_572 VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _0D5B
    closemsg
    call _0E16
    scrcmd_156
    goto _0D64

_0D5B:
    npc_msg 79
    goto _0C33

_0D64:
    buffer_players_name 0
    non_npc_msg 34
    call _0CA7
    call _0A18
    fade_screen 6, 1, 1, RGB_BLACK
    goto _0C39

_0D86:
    closemsg
    call _0E16
    scrcmd_617
    scrcmd_150
    goto _0D98

_0D98:
    buffer_players_name 0
    non_npc_msg 34
    call _0CA7
    call _0A18
    fade_screen 6, 1, 1, RGB_BLACK
    goto _0C39

_0DBA:
    play_se SEQ_SE_DP_PC_LOGIN
    closemsg
    scrcmd_706 VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _0DE7
    call _0E16
    scrcmd_164
    scrcmd_150
    call _0E02
    goto _0A2E

_0DE7:
    npc_msg 94
    goto _0A2E

_0DF0:
    closemsg
    play_se SEQ_SE_DP_PC_LOGOFF
    call _0A23
    touchscreen_menu_show
    releaseall
    end

_0E02:
    call _0A18
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    return

_0E16:
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    scrcmd_309 90
    return

scr_seq_0003_014:
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    scrcmd_156
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    end

scr_seq_0003_011:
    npc_msg 38
    endstd
    end

scr_seq_0003_012:
    scrcmd_609
    lockall
    apply_movement obj_player, _1054
    apply_movement 0, _105C
    wait_movement
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    buffer_players_name 0
    npc_msg 41
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    closemsg
    play_fanfare SEQ_ME_ASA
    wait_fanfare
    heal_party
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    npc_msg 42
    wait_button_or_walk_away
    closemsg
    releaseall
    end
    .byte 0x2d
    .byte 0x00, 0x2a, 0x1b, 0x00, 0x2d, 0x00, 0x2b, 0x1b, 0x00
scr_seq_0003_013:
    scrcmd_609
    lockall
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    get_player_state VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, PLAYER_STATE_ROCKET
    goto_if_ne _0ED4
    set_avatar_bits PLAYER_TRANSITION_ROCKET_HEAL
    goto _0ED8

_0ED4:
    set_avatar_bits PLAYER_TRANSITION_HEAL
_0ED8:
    update_avatar_state
    apply_movement obj_player, _0460
    wait_movement
    npc_msg 44
    call _0F89
    call _0216
    check_badge BADGE_ZEPHYR, VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _0F49
    npc_msg 45
    apply_movement obj_player, _0468
    wait_movement
    get_player_state VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, PLAYER_STATE_ROCKET
    goto_if_ne _0F2E
    set_avatar_bits PLAYER_TRANSITION_ROCKET
    goto _0F32

_0F2E:
    set_avatar_bits PLAYER_TRANSITION_WALKING
_0F32:
    update_avatar_state
    apply_movement VAR_SPECIAL_x8007, _0454
    wait_movement
    npc_msg 46
    wait_button_or_walk_away
    closemsg
    releaseall
    end

_0F49:
    apply_movement obj_player, _0468
    wait_movement
    get_player_state VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, PLAYER_STATE_ROCKET
    goto_if_ne _0F6E
    set_avatar_bits PLAYER_TRANSITION_ROCKET
    goto _0F72

_0F6E:
    set_avatar_bits PLAYER_TRANSITION_WALKING
_0F72:
    update_avatar_state
    apply_movement VAR_SPECIAL_x8007, _0454
    wait_movement
    npc_msg 40
    wait_button_or_walk_away
    closemsg
    releaseall
    end

_0F89:
    scrcmd_446 VAR_SPECIAL_x8004
    compare VAR_SPECIAL_x8004, 69
    goto_if_eq _100A
    compare VAR_SPECIAL_x8004, 158
    goto_if_eq _1012
    compare VAR_SPECIAL_x8004, 166
    goto_if_eq _101A
    compare VAR_SPECIAL_x8004, 236
    goto_if_eq _1022
    compare VAR_SPECIAL_x8004, 185
    goto_if_eq _102A
    compare VAR_SPECIAL_x8004, 81
    goto_if_eq _1032
    compare VAR_SPECIAL_x8004, 246
    goto_if_eq _103A
    compare VAR_SPECIAL_x8004, 293
    goto_if_eq _1042
    compare VAR_SPECIAL_x8004, 169
    goto_if_eq _104A
    setvar VAR_SPECIAL_x8007, 0
    return

_100A:
    setvar VAR_SPECIAL_x8007, 0
    return

_1012:
    setvar VAR_SPECIAL_x8007, 3
    return

_101A:
    setvar VAR_SPECIAL_x8007, 6
    return

_1022:
    setvar VAR_SPECIAL_x8007, 3
    return

_102A:
    setvar VAR_SPECIAL_x8007, 0
    return

_1032:
    setvar VAR_SPECIAL_x8007, 0
    return

_103A:
    setvar VAR_SPECIAL_x8007, 2
    return

_1042:
    setvar VAR_SPECIAL_x8007, 3
    return

_104A:
    setvar VAR_SPECIAL_x8007, 3
    return

.align 4

_1054:
    step 0, 1
    step_end

_105C:
    step 1, 1
    step_end

_1064:
    step 2, 1
    step_end
    .byte 0x00, 0x00, 0x01, 0x00
    .byte 0xfe, 0x00, 0x00, 0x00, 0x03, 0x00, 0x01, 0x00, 0xfe, 0x00, 0x00, 0x00

_107C:
    step 1, 1
    step_end


scr_seq_0003_015:
    play_se SEQ_SE_DP_SELECT
    lockall
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    scrcmd_450
    scrcmd_150
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    releaseall
    end

scr_seq_0003_016:
    play_se SEQ_SE_DP_SELECT
    lockall
    faceplayer
    scrcmd_455
    wait_button_or_walk_away
    closemsg
    releaseall
    end

scr_seq_0003_017:
    simple_npc_msg 54
    end

scr_seq_0003_018:
    simple_npc_msg 57
    end

scr_seq_0003_019:
    simple_npc_msg 58
    end

scr_seq_0003_020:
    hasitem 450, 1, VAR_SPECIAL_RESULT // ITEM_BIKE
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _1163
    scrcmd_609
    lockall
    play_se SEQ_SE_DP_SELECT
    player_on_bike_check VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _1140
    npc_msg 59
    yesno VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _115D
    player_on_bike_set 1
    closemsg
    releaseall
    end

_1140:
    npc_msg 60
    yesno VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq _115D
    player_on_bike_set 0
    closemsg
    releaseall
    end

_115D:
    closemsg
    releaseall
    end

_1163:
    end

scr_seq_0003_021:
    play_se SEQ_SE_DP_SELECT
    lockall
    npc_msg 62
    wait_button
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    closemsg
    egg_hatch_anim
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    releaseall
    end

scr_seq_0003_022:
    play_se SEQ_SE_DP_SELECT
    lockall
    npc_msg 65
    wait_button
    closemsg
    releaseall
    end

scr_seq_0003_072_repels:
    play_se SEQ_SE_DP_SELECT
    lockall
    npc_msg 118
    yesno VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 1
    goto_if_eq scr_seq_0003_072_end
    QueueNewRepel
    PlayFanfare SEQ_SE_DP_CARD2
    buffer_players_name 0
    buffer_item_name 1, VAR_SPECIAL_RESULT
    npc_msg 119
    wait_button_or_walk_away
scr_seq_0003_072_end:
    closemsg
    releaseall
    end

scr_seq_0003_023:
    play_se SEQ_SE_DP_SELECT
    lockall
    faceplayer
    npc_msg 103
    touchscreen_menu_hide
_11AE:
    menu_init 1, 1, 0, 1, VAR_SPECIAL_RESULT
    menu_item_add 112, 255, 0
    menu_item_add 113, 255, 1
    menu_item_add 114, 255, 2
    menu_item_add 115, 255, 3
    menu_item_add 116, 255, 4
    menu_exec
    compare VAR_SPECIAL_RESULT, 4
    goto_if_ge _1277
    setvar VAR_SPECIAL_x8004, 104
    addvar VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    non_npc_msg_var VAR_SPECIAL_x8004
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    closemsg
    setvar VAR_SPECIAL_x8000, 2
    addvar VAR_SPECIAL_x8000, VAR_SPECIAL_RESULT
    scrcmd_492 VAR_SPECIAL_x8000, VAR_SPECIAL_RESULT, VAR_SPECIAL_x8001
    scrcmd_150
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _1277
    npc_msg 109
    getmenuchoice VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _11AE
    compare VAR_SPECIAL_x8001, 65535
    goto_if_eq _126A
    scrcmd_494 0, VAR_SPECIAL_x8001
    npc_msg 111
    goto _126D

_126A:
    npc_msg 110
_126D:
    wait_button_or_walk_away
    closemsg
    touchscreen_menu_show
    releaseall
    end

_1277:
    npc_msg 108
    goto _126D
    .byte 0x02, 0x00
scr_seq_0003_025:
    simple_npc_msg 68
    end

scr_seq_0003_027:
    end

scr_seq_0003_028:
    scrcmd_609
    lockall
    releaseall
    end
    .byte 0x2d
    .byte 0x00, 0x58, 0x32, 0x00, 0x35, 0x00, 0x61, 0x00, 0x02, 0x00, 0x35, 0x00, 0x61, 0x00, 0x02, 0x00
scr_seq_0003_029:
    stop_bgm 0
    get_player_gender VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 0
    call_if_eq _12D6
    compare VAR_SPECIAL_RESULT, 1
    call_if_eq _12DC
    endstd
    end

_12D6:
    temp_bgm SEQ_GS_E_SUPPORT_F
    return

_12DC:
    temp_bgm SEQ_GS_E_SUPPORT_M
    return

scr_seq_0003_031:
    stop_bgm 0
    temp_bgm SEQ_GS_E_RIVAL1
    endstd
    end

scr_seq_0003_070:
    stop_bgm 0
    temp_bgm SEQ_GS_E_RIVAL2
    endstd
    end

scr_seq_0003_042:
    stop_bgm 0
    temp_bgm SEQ_GS_E_MINAKI
    endstd
    end

scr_seq_0003_044:
    stop_bgm 0
    temp_bgm SEQ_GS_IBUKI
    endstd
    end

scr_seq_0003_036:
    stop_bgm 0
    temp_bgm SEQ_GS_E_TSURETEKE1
    endstd
    end

scr_seq_0003_037:
    stop_bgm 0
    temp_bgm SEQ_GS_E_TSURETEKE2
    endstd
    end

scr_seq_0003_065:
    stop_bgm 0
    temp_bgm SEQ_GS_E_G_PICHU
    endstd
    end

scr_seq_0003_067:
    stop_bgm 0
    temp_bgm SEQ_GS_E_MAIKO_THEME
    endstd
    end

scr_seq_0003_030:
scr_seq_0003_032:
scr_seq_0003_038:
scr_seq_0003_043:
scr_seq_0003_045:
scr_seq_0003_066:
scr_seq_0003_068:
scr_seq_0003_071:
    fade_out_bgm 0, 30
    stop_bgm 0
    reset_bgm
    endstd
    end

scr_seq_0003_039:
    set_phone_call VAR_SPECIAL_x8004, VAR_SPECIAL_x8005, VAR_SPECIAL_x8006
    call _136C
    endstd
    end

scr_seq_0003_047:
    call _136C
    end

_136C:
    play_se SEQ_SE_GS_PHONE0
    wait_se SEQ_SE_GS_PHONE0
    play_se SEQ_SE_GS_PHONE0
    wait_se SEQ_SE_GS_PHONE0
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    run_phone_call
    scrcmd_150
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    return

scr_seq_0003_040:
    goto_if_set FLAG_GOT_ALL_FOUR_FRONTIER_PRINTS, _13F6
    compare VAR_BATTLE_FACTORY_PRINT_PROGRESS, 4
    goto_if_ne _13F6
    compare VAR_BATTLE_HALL_PRINT_PROGRESS, 4
    goto_if_ne _13F6
    compare VAR_BATTLE_CASTLE_PRINT_PROGRESS, 4
    goto_if_ne _13F6
    compare VAR_BATTLE_ARCADE_PRINT_PROGRESS, 4
    goto_if_ne _13F6
    compare VAR_BATTLE_TOWER_PRINT_PROGRESS, 4
    goto_if_ne _13F6
    setflag FLAG_GOT_ALL_FOUR_FRONTIER_PRINTS
    add_special_game_stat_2 31
    goto _13F6
    .byte 0x02, 0x00
_13F6:
    endstd
    end

scr_seq_0003_041:
    npc_msg 93
    wait_button_or_walk_away
    closemsg
    releaseall
    endstd
    end

scr_seq_0003_046:
    fade_screen 6, 1, 0, RGB_BLACK
    wait_fade
    scrcmd_166 VAR_SPECIAL_RESULT
    copyvar VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    scrcmd_662 VAR_SPECIAL_x8005, VAR_SPECIAL_x8004, VAR_SPECIAL_RESULT
    compare VAR_SPECIAL_RESULT, 0
    goto_if_eq _1444
    scrcmd_150
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    endstd
    end

_1444:
    scrcmd_150
    fade_screen 6, 1, 1, RGB_BLACK
    wait_fade
    endstd
    end

scr_seq_0003_048:
    goto _145E
    .byte 0x02, 0x00
_145E:
    touchscreen_menu_hide
    menu_init_std_gmm 1, 1, 0, 1, VAR_SPECIAL_RESULT
    menu_item_add 321, 255, 0
    menu_item_add 322, 255, 1
    menu_item_add 323, 255, 2
    menu_exec
    switch VAR_SPECIAL_RESULT
    case 0, scr_seq_0003_049
    case 1, scr_seq_0003_050
    case 2, scr_seq_0003_051
    end

scr_seq_0003_049:
    mart_buy VAR_SPECIAL_x8004
    goto _14DD
    .byte 0x02, 0x00
scr_seq_0003_050:
    mart_sell
    goto _14DD
    .byte 0x02, 0x00
scr_seq_0003_051:
    touchscreen_menu_show
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 1
    wait_button_or_walk_away
    closemsg
    endstd
    end

_14DD:
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 6
    holdmsg
    goto _145E
    .byte 0x02, 0x00
scr_seq_0003_052:
    goto _14FB
    .byte 0x02, 0x00
_14FB:
    touchscreen_menu_hide
    menu_init_std_gmm 1, 1, 0, 1, VAR_SPECIAL_RESULT
    menu_item_add 321, 255, 0
    menu_item_add 322, 255, 1
    menu_item_add 323, 255, 2
    menu_exec
    switch VAR_SPECIAL_RESULT
    case 0, scr_seq_0003_053
    case 1, scr_seq_0003_054
    case 2, scr_seq_0003_055
    end

scr_seq_0003_053:
    special_mart_buy VAR_SPECIAL_x8004
    goto _15A6
    .byte 0x02, 0x00
scr_seq_0003_054:
    mart_sell
    goto _15A6
    .byte 0x02, 0x00
scr_seq_0003_055:
    touchscreen_menu_show
    goto_if_set FLAG_SPECIAL_MART_PHARMACY, _15E8
    goto_if_set FLAG_SPECIAL_MART_BITTER, _160C
    goto_if_set FLAG_SPECIAL_MART_MAHOGANY_GOOD, _1630
    goto_if_set FLAG_SPECIAL_MART_MT_MOON, _1654
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 1
_159E:
    wait_button_or_walk_away
    closemsg
    endstd
    end

_15A6:
    goto_if_set FLAG_SPECIAL_MART_PHARMACY, _15FA
    goto_if_set FLAG_SPECIAL_MART_BITTER, _161E
    goto_if_set FLAG_SPECIAL_MART_MAHOGANY_GOOD, _1642
    goto_if_set FLAG_SPECIAL_MART_MT_MOON, _1666
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 6
_15DE:
    holdmsg
    goto _14FB
    .byte 0x02, 0x00
_15E8:
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 2
    goto _159E

_15FA:
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 7
    goto _15DE

_160C:
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 3
    goto _159E

_161E:
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 8
    goto _15DE

_1630:
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 4
    goto _159E

_1642:
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 9
    goto _15DE

_1654:
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 5
    goto _159E

_1666:
    get_std_msg_naix 3, VAR_SPECIAL_RESULT
    msgbox_extern VAR_SPECIAL_RESULT, 10
    goto _15DE

scr_seq_0003_056:
    touchscreen_menu_hide
    menu_init_std_gmm 1, 1, 0, 1, VAR_SPECIAL_RESULT
    menu_item_add 321, 255, 0
    menu_item_add 324, 255, 1
    menu_item_add 323, 255, 2
    menu_exec
    switch VAR_SPECIAL_RESULT
    case 0, scr_seq_0003_057
    case 1, scr_seq_0003_058
    case 2, scr_seq_0003_059
    end

scr_seq_0003_057:
    scrcmd_771
    endstd
    end

scr_seq_0003_058:
    touchscreen_menu_show
    endstd
    end

scr_seq_0003_059:
    touchscreen_menu_show
    endstd
    end

scr_seq_0003_060:
    touchscreen_menu_hide
    menu_init_std_gmm 1, 1, 0, 1, VAR_SPECIAL_RESULT
    menu_item_add 321, 255, 0
    menu_item_add 324, 255, 1
    menu_item_add 323, 255, 2
    menu_exec
    switch VAR_SPECIAL_RESULT
    case 0, scr_seq_0003_061
    case 1, scr_seq_0003_062
    case 2, scr_seq_0003_063
    end

scr_seq_0003_061:
    scrcmd_772
    endstd
    end

scr_seq_0003_062:
    touchscreen_menu_show
    endstd
    end

scr_seq_0003_063:
    touchscreen_menu_show
    endstd
    end

scr_seq_0003_064:
    play_se SEQ_SE_DP_SELECT
    lockall
    scrcmd_727 VAR_SPECIAL_x8005
    bufferpartymonnick 0, VAR_SPECIAL_x8005
    npc_msg 99
    closemsg
    scrcmd_806
    scrcmd_727 VAR_SPECIAL_x8005
    bufferpartymonnick 0, VAR_SPECIAL_x8005
    npc_msg 100
    wait_button
    closemsg
    releaseall
    end

scr_seq_0003_073_autobattle_testing:
    play_se SEQ_SE_DP_SELECT
    lockall
    npc_msg 120
    closemsg
    trainer_battle 5, 0, 0, 0
    //setvar 0x800B, 1
    //WildBattleSp 785 | (1 << 11), 50, 0
    releaseall
    end



.close

#include "config.h"
#include "types.h"

#include "save.h"

#include "route_capture_tracker.h"

// keep in sync with the routeCaptureAttempted[68] field in struct SAVE_MISC_DATA (save.h)
#define ROUTE_CAPTURE_TRACKER_NUM_BYTES 68
#define ROUTE_CAPTURE_TRACKER_NUM_BITS  (ROUTE_CAPTURE_TRACKER_NUM_BYTES * 8)

BOOL LONG_CALL RouteCaptureTracker_WasAttempted(u32 mapId)
{
#ifdef ONE_CAPTURE_PER_ROUTE
    if (mapId >= ROUTE_CAPTURE_TRACKER_NUM_BITS) {
        return FALSE;
    }

    struct SAVE_MISC_DATA *saveMiscData = Sav2_Misc_get(SaveBlock2_get());

    return (saveMiscData->routeCaptureAttempted[mapId / 8] & (1 << (mapId % 8))) != 0;
#else
    return FALSE;
#endif
}

void LONG_CALL RouteCaptureTracker_MarkAttempted(u32 mapId)
{
#ifdef ONE_CAPTURE_PER_ROUTE
    if (mapId >= ROUTE_CAPTURE_TRACKER_NUM_BITS) {
        return;
    }

    struct SAVE_MISC_DATA *saveMiscData = Sav2_Misc_get(SaveBlock2_get());

    saveMiscData->routeCaptureAttempted[mapId / 8] |= (1 << (mapId % 8));
#endif
}

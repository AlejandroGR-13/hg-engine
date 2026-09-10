#ifndef ROUTE_CAPTURE_TRACKER_H
#define ROUTE_CAPTURE_TRACKER_H

#include "types.h"

/**
 *  @brief check whether a wild encounter has already started on this map before, this save file.
 *
 *         Purely informational - used to show a warning message in the encounter battle script,
 *         see ONE_CAPTURE_PER_ROUTE in config.h. Does not affect whether catching is possible.
 *
 *  @param mapId the map id to check (see constants/maps.h)
 *  @return TRUE if a wild encounter has already started on this map before, FALSE otherwise
 *          (including for a mapId outside the tracked range, or if the feature is disabled)
 */
BOOL LONG_CALL RouteCaptureTracker_WasAttempted(u32 mapId);

/**
 *  @brief mark this map as having had a wild encounter start on it, for the rest of this save file.
 *
 *  @param mapId the map id to mark (see constants/maps.h). Does nothing for a mapId outside the
 *         tracked range, or if the feature is disabled.
 */
void LONG_CALL RouteCaptureTracker_MarkAttempted(u32 mapId);

#endif // ROUTE_CAPTURE_TRACKER_H

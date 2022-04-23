#include "TileData.h"
int TileData::getState() { return mState; }
void TileData::setState(int state)
{
    if (mState == state)
        return;
    mState = state;
    emit stateChanged();
}
